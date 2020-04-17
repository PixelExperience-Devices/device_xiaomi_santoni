# Audio
PRODUCT_PROPERTY_OVERRIDES += \
af.fast_track_multiplier=1 \
audio.deep_buffer.media=true \
audio.offload.disable=true \
audio.offload.min.duration.secs=30 \
audio.offload.video=true \
ro.vendor.audio.sdk.fluencetype=fluence \
persist.audio.dirac.speaker=true \
persist.vendor.audio.fluence.voicecall=true \
persist.vendor.audio.fluence.voicerec=false \
persist.vendor.audio.fluence.speaker=true \
persist.vendor.audio.speaker.prot.enable=false \
persist.vendor.audio.hw.binder.size_kbyte=1024 \
ro.vendor.audio.sdk.ssr=false \
vendor.audio.dolby.ds2.enabled=true \
vendor.audio.dolby.ds2.hardbypass=true \
vendor.audio.flac.sw.decoder.24bit=true \
vendor.audio.hw.aac.encoder=true \
vendor.audio.offload.buffer.size.kb=64 \
vendor.audio.offload.gapless.enabled=true \
vendor.audio.offload.multiaac.enable=true \
vendor.audio.offload.multiple.enabled=false \
vendor.audio.offload.passthrough=false \
vendor.audio.offload.track.enable=true \
vendor.audio.parser.ip.buffer.size=262144 \
vendor.audio.playback.mch.downsample=true \
vendor.audio.pp.asphere.enabled=false \
vendor.audio.safx.pbe.enabled=true \
vendor.audio.tunnel.encode=false \
vendor.audio.use.sw.alac.decoder=true \
vendor.audio.use.sw.ape.decoder=true \
vendor.audio_hal.period_size=192 \
vendor.voice.conc.fallbackpath=deep-buffer \
vendor.voice.path.for.pcm.voip=true \
vendor.voice.playback.conc.disabled=true \
vendor.voice.record.conc.disabled=false \
vendor.voice.voip.conc.disabled=true \
ro.config.vc_call_vol_steps=8 \
ro.config.media_vol_steps=20

# Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
persist.vendor.btstack.a2dp_offload_cap=sbc-aptx-aptxtws-aptxhd-aac-ldac-aptxadaptive \
persist.bluetooth.a2dp_offload.disabled=true \
persist.vendor.bluetooth.modem_nv_support=true \
persist.vendor.bt.enable.splita2dp=false \
vendor.qcom.bluetooth.soc=smd

# Boot
PRODUCT_PROPERTY_OVERRIDES += \
sys.vendor.shutdown.waittime=500

# Camera
PRODUCT_PROPERTY_OVERRIDES += \
camera.display.lmax=1280x720 \
camera.display.umax=1920x1080 \
vendor.camera.hal1.packagelist=com.whatsapp,com.facebook.katana,com.instagram.android,com.snapchat.android \
persist.camera.gyro.disable=0 \
persist.camera.imglib.cac3=2 \
camera.lowpower.record.enable=1 \
persist.camera.isp.clock.optmz=0 \
vidc.enc.dcvs.extra-buff-count=2 \
vendor.vidc.enc.narrow.searchrange=1 \
persist.vendor.qti.telephony.vt_cam_interface=2 \
media.camera.ts.monotonic=1 \
persist.camera.HAL3.enabled=1

# CNE/DPM
PRODUCT_PROPERTY_OVERRIDES += \
persist.vendor.cne.feature=1 \
persist.vendor.dpm.feature=0 \
persist.vendor.sys.cnd.iwlan=1 \

# Coresight
PRODUCT_PROPERTY_OVERRIDES += \
persist.debug.coresight.config=stm-events

# Dalvik
PRODUCT_PROPERTY_OVERRIDES += \
dalvik.vm.dex2oat-filter=speed \
dalvik.vm.image-dex2oat-filter=speed \
dalvik.vm.heaptargetutilization=0.75 \

# Display
PRODUCT_PROPERTY_OVERRIDES += \
debug.sf.enable_hwc_vds=1 \
debug.sf.hw=0 \
debug.sf.latch_unsignaled=0 \
debug.sf.enable_gl_backpressure=1 \
debug.egl.hw=0 \
persist.hwc.mdpcomp.enable=true \
debug.mdpcomp.logs=0 \
dev.pm.dyn_samplingrate=1 \
persist.demo.hdmirotationlock=false \
debug.enable.sglscale=1 \
sdm.debug.disable_skip_validate=1 \
debug.sf.recomputecrop=0 \
ro.opengles.version=196610 \
ro.qualcomm.cabl=0 \
ro.qualcomm.svi=0 \
persist.debug.wfd.enable=1 \
persist.hwc.enable_vds=1 \
vendor.display.disable_skip_validate=1 \
vendor.display.rotator_downscale=1 \
vendor.display.perf_hint_window=50 \
vendor.display.enable_default_color_mode=0 \
vendor.gralloc.enable_fb_ubwc=1 \
debug.hwui.use_buffer_age=false \
vendor.video.disable.ubwc=1 \
debug.sdm.support_writeback=0

# DRM
PRODUCT_PROPERTY_OVERRIDES += \
drm.service.enabled=true

# Fingerprint
PRODUCT_PROPERTY_OVERRIDES += \
persist.qfp=false \

# Fm
PRODUCT_PROPERTY_OVERRIDES += \
ro.fm.transmitter=false

# FWK
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
ro.vendor.qti.va_aosp.support=1 \
ro.vendor.qti.va_odm.support=1

# GPS
PRODUCT_PROPERTY_OVERRIDES += \
persist.gps.qc_nlp_in_use=1 \
persist.loc.nlp_name=com.qualcomm.location \
ro.gps.agps_provider=1

# LMKD
PRODUCT_PRODUCT_PROPERTIES += \
    ro.lmk.low=1001 \
    ro.lmk.medium=800 \
    ro.lmk.critical=0 \
    ro.lmk.critical_upgrade=false \
    ro.lmk.upgrade_pressure=100 \
    ro.lmk.downgrade_pressure=100 \
    ro.lmk.kill_heaviest_task=true \
    ro.lmk.kill_timeout_ms=100 \
    ro.lmk.use_minfree_levels=true

# Media
PRODUCT_PROPERTY_OVERRIDES += \
debug.stagefright.omx_default_rank.sw-audio=1 \
debug.stagefright.omx_default_rank=0 \
debug.media.codec2=2 \
media.msm8956hw=0 \
mm.enable.smoothstreaming=true \
mm.sec.enable.smoothstreaming=true \
mmp.enable.3g2=true \
media.aac_51_output_enabled=true \
media.stagefright.audio.sink=280 \
vendor.mm.enable.qcom_parser=1048575 \
vendor.vidc.disable.split.mode=1 \
vendor.vidc.enc.disable.pq=true \
vendor.video.disable.ubwc=1 \
av.debug.disable.pers.cache=1
media.settings.xml=/vendor/etc/media_profiles_V1_0.xml \
media.stagefright.thumbnail.prefer_hw_codecs=true

# Memory optimizations
PRODUCT_PROPERTY_OVERRIDES += \
ro.vendor.qti.sys.fw.bservice_enable=true \
ro.config.fha_enable=true \
ro.sys.fw.bg_apps_limit=32 \
ro.config.dha_cached_max=16 \
ro.config.dha_empty_max=42 \
ro.config.dha_empty_init=32 \
ro.config.dha_lmk_scale=0.545 \
ro.config.dha_th_rate=2.3 \
ro.config.sdha_apps_bg_max=64 \
ro.config.sdha_apps_bg_min=8

# Perf Ux IOPrefetcher
PRODUCT_PROPERTY_OVERRIDES += \
vendor.enable_prefetch=1 \
vendor.iop.enable_uxe=1 \
vendor.iop.enable_prefetch_ofr=1 \
vendor.perf.iop_v3.enable=1 \
persist.vendor.qti.games.gt.prof=1 \

# Perf
PRODUCT_PROPERTY_OVERRIDES += \
dalvik.vm.boot-dex2oat-threads=8 \
ro.sys.fw.dex2oat_thread_count=8 \
dalvik.vm.bg-dex2oat-threads=2 \
dalvik.vm.dex2oat-threads=6 \
ro.vendor.qti.am.reschedule_service=true \
ro.vendor.qti.core_ctl_min_cpu=1 \
ro.vendor.qti.core_ctl_max_cpu=4 \
ro.vendor.at_library=libqti-at.so \
ro.vendor.extension_library=libqti-perfd-client.so \
ro.vendor.gt_library=libqti-gt.so \
vendor.perf.gestureflingboost.enable=true

# Perf configuration
PRODUCT_PROPERTY_OVERRIDES += \
ro.vendor.qti.sys.fw.bservice_enable=true \
ro.vendor.qti.sys.fw.bservice_limit=5 \
ro.vendor.qti.sys.fw.bservice_age=5000 \
ro.vendor.qti.sys.fw.use_trim_settings=true \
ro.vendor.qti.sys.fw.empty_app_percent=50 \
ro.vendor.qti.sys.fw.trim_empty_percent=100 \
ro.vendor.qti.sys.fw.trim_cache_percent=100 \
ro.vendor.qti.sys.fw.trim_enable_memory=2147483648

# Netmgrd
PRODUCT_PROPERTY_OVERRIDES += \
ro.vendor.use_data_netmgrd=true \
persist.data.netmgrd.qos.enable=true \
persist.vendor.data.mode=concurrent

# Radio
PRODUCT_PROPERTY_OVERRIDES += \
DEVICE_PROVISIONED=1 \
persist.dbg.volte_avail_ovr=1 \
persist.dbg.vt_avail_ovr=1 \
persist.dbg.wfc_avail_ovr=1 \
persist.vendor.data.iwlan.enable=true \
persist.vendor.lte.pco_mmi_legacy_mode=true \
persist.vendor.lte.pco_supported=true \
persist.vendor.radio.add_power_save=1 \
persist.vendor.radio.aosp_usr_pref_sel=true \
persist.vendor.radio.apm_sim_not_pwdn=1 \
persist.vendor.radio.multisim_switch_support=true \
persist.radio.force_on_dc=true \
persist.radio.ignore_dom_time=5 \
persist.radio.multisim.config=dsds \
persist.radio.schd.cache=3500 \
persist.vendor.ims.dropset_feature=0 \
persist.vendor.radio.custom_ecc=1 \
persist.vendor.radio.force_get_pref=1 \
persist.vendor.radio.lte_vrte_ltd=1 \
persist.vendor.radio.enable_temp_dds=true \
persist.vendor.radio.force_get_pref=1 \
persist.vendor.radio.no_wait_for_card=1 \
persist.vendor.radio.prefer_spn=1 \
persist.vendor.radio.rat_on=combine \
persist.vendor.radio.relay_oprt_change=1 \
persist.vendor.radio.sib16_support=1 \
ril.subscription.types=NV,RUIM \
rild.libpath=/vendor/lib64/libril-qc-qmi-1.so \
vendor.rild.libpath=/vendor/lib64/libril-qc-qmi-1.so \
ro.telephony.call_ring.multiple=false \
ro.telephony.iwlan_operation_mode=legacy \
ro.telephony.use_old_mnc_mcc_format=true \
persist.vendor.radio.jbims=1 \
persist.vendor.vt.supported=1 \
service.qti.ims.enabled=1 \
persist.radio.calls.on.ims=1 \
persist.radio.aosp_usr_pref_sel=true \
ro.telephony.default_network=22,22 \
vendor.service.qti.ims.enabled=1 \
persist.sys.fflag.override.settings_network_and_internet_v2=true

# SurfaceFlinger
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
ro.surface_flinger.protected_contents=true \
ro.surface_flinger.max_frame_buffer_acquired_buffers=2 \
ro.surface_flinger.force_hwc_copy_for_virtual_displays=true \
ro.surface_flinger.vsync_event_phase_offset_ns=2000000 \
ro.surface_flinger.vsync_sf_event_phase_offset_ns=6000000

PRODUCT_PROPERTY_OVERRIDES += \
debug.sf.early_phase_offset_ns=1500000 \
debug.sf.early_app_phase_offset_ns=1500000 \
debug.sf.early_gl_phase_offset_ns=3000000 \
debug.sf.early_gl_app_phase_offset_ns=15000000

# Time Services
PRODUCT_PROPERTY_OVERRIDES += \
persist.delta_time.enable=true \
persist.timed.enable=true

# Tcp
PRODUCT_PROPERTY_OVERRIDES += \
net.tcp.2g_init_rwnd=10

# Wifi
PRODUCT_PROPERTY_OVERRIDES += \
wifi.interface=wlan0

# UI
PRODUCT_PROPERTY_OVERRIDES += \
sys.use_fifo_ui=1
