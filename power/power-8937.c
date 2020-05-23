/*
 * Copyright (c) 2015, The Linux Foundation. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * *    * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above
 *       copyright notice, this list of conditions and the following
 *       disclaimer in the documentation and/or other materials provided
 *       with the distribution.
 *     * Neither the name of The Linux Foundation nor the names of its
 *       contributors may be used to endorse or promote products derived
 *       from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
 * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
 * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
 * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#define LOG_NIDEBUG 0

#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <dlfcn.h>
#include <stdlib.h>

#define LOG_TAG "QTI PowerHAL"
#include <log/log.h>
#include <hardware/hardware.h>
#include <hardware/power.h>

#include "utils.h"
#include "hint-data.h"
#include "performance.h"
#include "power-common.h"

#define MAX_INTERACTIVE_DURATION 5000
#define MIN_INTERACTIVE_DURATION 500
#define MIN_FLING_DURATION 1100
#define MAX_LAUNCH_DURATION 5000

static int saved_interactive_mode = -1;
static int display_hint_sent;
static int video_encode_hint_sent;

extern void interaction(int duration, int num_args, int opt_list[]);

static int current_power_profile = PROFILE_BALANCED;

static int profile_high_performance[] = {
    SCHED_BOOST_ON_V3, 0x1,
    ALL_CPUS_PWR_CLPS_DIS_V3, 0x1,
    CPUS_ONLINE_MIN_BIG, 0x4,
    MIN_FREQ_BIG_CORE_0, 0xFFF,
    MIN_FREQ_LITTLE_CORE_0, 0xFFF,
    GPU_MIN_PWRLVL_BOOST, 0x1,
    SCHED_PREFER_IDLE_DIS_V3, 0x1,
    SCHED_SMALL_TASK_DIS, 0x1,
    SCHED_IDLE_NR_RUN_DIS, 0x1,
    SCHED_IDLE_LOAD_DIS, 0x1,
};

static int profile_power_save[] = {
    CPUS_ONLINE_MAX_LIMIT_BIG, 0x1,
    MAX_FREQ_BIG_CORE_0, 0x3bf,
    MAX_FREQ_LITTLE_CORE_0, 0x300,
};

static int profile_bias_power[] = {
    MAX_FREQ_BIG_CORE_0, 0x4B0,
    MAX_FREQ_LITTLE_CORE_0, 0x300,
};

static int profile_bias_performance[] = {
    CPUS_ONLINE_MAX_LIMIT_BIG, 0x4,
    MIN_FREQ_BIG_CORE_0, 0x540,
};

#ifdef INTERACTION_BOOST
int get_number_of_profiles() {
    return 5;
}
#endif

static void set_power_profile(int profile) {

    if (profile == current_power_profile)
        return;

    ALOGV("%s: profile=%d", __func__, profile);

    if (current_power_profile != PROFILE_BALANCED) {
        undo_hint_action(DEFAULT_PROFILE_HINT_ID);
        ALOGV("%s: hint undone", __func__);
    }

    if (profile == PROFILE_HIGH_PERFORMANCE) {
        perform_hint_action(DEFAULT_PROFILE_HINT_ID, profile_high_performance,
                ARRAY_SIZE(profile_high_performance));
        ALOGD("%s: set performance mode", __func__);

    } else if (profile == PROFILE_POWER_SAVE) {
        perform_hint_action(DEFAULT_PROFILE_HINT_ID, profile_power_save,
                ARRAY_SIZE(profile_power_save));
        ALOGD("%s: set powersave", __func__);

    } else if (profile == PROFILE_BIAS_POWER) {
        perform_hint_action(DEFAULT_PROFILE_HINT_ID, profile_bias_power,
                ARRAY_SIZE(profile_bias_power));
        ALOGD("%s: Set bias power mode", __func__);

    } else if (profile == PROFILE_BIAS_PERFORMANCE) {
        perform_hint_action(DEFAULT_PROFILE_HINT_ID, profile_bias_performance,
                ARRAY_SIZE(profile_bias_performance));
        ALOGD("%s: Set bias perf mode", __func__);
    }

    current_power_profile = profile;
}

static void process_activity_launch_hint(int state)
{
    static int lock_handle = -1;

    if (state) {
        int resource_values[] = {
            SCHED_BOOST_ON_V3, 0x1,
            MIN_FREQ_BIG_CORE_0, 0x5DC,
            ALL_CPUS_PWR_CLPS_DIS_V3, 0x1,
            CPUS_ONLINE_MIN_BIG, 0x4,
            GPU_MIN_PWRLVL_BOOST, 0x1,
        };
        lock_handle = interaction_with_handle(lock_handle, MAX_LAUNCH_DURATION,
                ARRAY_SIZE(resource_values), resource_values);
    } else {
        // release lock early since launch has finished
        if (CHECK_HANDLE(lock_handle)) {
            release_request(lock_handle);
            lock_handle = -1;
        }
    }
}

static void process_video_encode_hint(int state)
{
    char governor[80];

    ALOGI("Got process_video_encode_hint");

    if (get_scaling_governor_check_cores(governor,
                sizeof(governor),CPU0) == -1) {
        if (get_scaling_governor_check_cores(governor,
                    sizeof(governor),CPU1) == -1) {
            if (get_scaling_governor_check_cores(governor,
                        sizeof(governor),CPU2) == -1) {
                if (get_scaling_governor_check_cores(governor,
                            sizeof(governor),CPU3) == -1) {
                    ALOGE("Can't obtain scaling governor.");
                    return;
                }
            }
        }
    }

    if (state) {
        if (is_interactive_governor(governor)) {
            /* Sched_load and migration_notif*/
            int resource_values[] = {
                INT_OP_CLUSTER0_USE_SCHED_LOAD, 0x1,
                INT_OP_CLUSTER1_USE_SCHED_LOAD, 0x1,
                INT_OP_CLUSTER0_USE_MIGRATION_NOTIF, 0x1,
                INT_OP_CLUSTER1_USE_MIGRATION_NOTIF, 0x1,
                INT_OP_CLUSTER0_TIMER_RATE, BIG_LITTLE_TR_MS_40,
                INT_OP_CLUSTER1_TIMER_RATE, BIG_LITTLE_TR_MS_40
            };
            if (!video_encode_hint_sent) {
                perform_hint_action(DEFAULT_VIDEO_ENCODE_HINT_ID,
                        resource_values, ARRAY_SIZE(resource_values));
                video_encode_hint_sent = 1;
            }
        }
    } else {
        if (is_interactive_governor(governor)) {
            undo_hint_action(DEFAULT_VIDEO_ENCODE_HINT_ID);
            video_encode_hint_sent = 0;
        }
    }
}

int power_hint_override(power_hint_t hint, int data)
{
    int duration;
    int resources_interaction_fling_boost[] = {
        MIN_FREQ_BIG_CORE_0, 0x514,
        SCHED_BOOST_ON_V3, 0x1,
    };

    if (hint == POWER_HINT_SET_PROFILE) {
        set_power_profile(data);
        return HINT_HANDLED;
    }

    // Skip other hints in high/low power mode
    if (current_power_profile == PROFILE_POWER_SAVE ||
            current_power_profile == PROFILE_HIGH_PERFORMANCE) {
        return HINT_HANDLED;
    }

    switch (hint) {
        case POWER_HINT_INTERACTION:
            duration = data;
            if (duration > MAX_INTERACTIVE_DURATION)
                duration = MAX_INTERACTIVE_DURATION;
            if (duration >= MIN_FLING_DURATION) {
                interaction(duration, ARRAY_SIZE(resources_interaction_fling_boost),
                        resources_interaction_fling_boost);
            }
            return HINT_HANDLED;
        case POWER_HINT_LAUNCH:
            process_activity_launch_hint(data);
            return HINT_HANDLED;
        case POWER_HINT_VIDEO_ENCODE:
            process_video_encode_hint(data);
            return HINT_HANDLED;
        default:
            break;
    }
    return HINT_NONE;
}

int set_interactive_override(int on)
{
    char governor[80];
    char tmp_str[NODE_MAX];
    int rc;

    ALOGI("Got set_interactive hint");

    if (get_scaling_governor_check_cores(governor, sizeof(governor),CPU0) == -1) {
        if (get_scaling_governor_check_cores(governor, sizeof(governor),CPU1) == -1) {
            if (get_scaling_governor_check_cores(governor, sizeof(governor),CPU2) == -1) {
                if (get_scaling_governor_check_cores(governor, sizeof(governor),CPU3) == -1) {
                    ALOGE("Can't obtain scaling governor.");
                    return HINT_NONE;
                }
            }
        }
    }

    if (!on) {
        /* Display off. */
        if (is_interactive_governor(governor)) {
            int resource_values[] = {
                INT_OP_CLUSTER0_TIMER_RATE, BIG_LITTLE_TR_MS_50,
                INT_OP_CLUSTER1_TIMER_RATE, BIG_LITTLE_TR_MS_50,
                INT_OP_NOTIFY_ON_MIGRATE, 0x00
            };

            if (!display_hint_sent) {
                perform_hint_action(
                        DISPLAY_STATE_HINT_ID,
                        resource_values,
                        ARRAY_SIZE(resource_values));
                display_hint_sent = 1;
            }
        } /* Perf time rate set for CORE0,CORE4 8952 target*/
    } else {
        /* Display on. */
        if (is_interactive_governor(governor)) {
            undo_hint_action(DISPLAY_STATE_HINT_ID);
            display_hint_sent = 0;
        }
    }
    saved_interactive_mode = !!on;
    return HINT_HANDLED;
}
