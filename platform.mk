# Copyright (C) 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Platform Path
PLATFORM_COMMON_PATH := device/motorola/sm4250-common

# Platform
BENGAL := bengal
KERNEL_VERSION := 4.19
PRODUCT_PLATFORM_MOT := true
TARGET_BOARD_PLATFORM := $(BENGAL)

# Kernel Headers
PRODUCT_VENDOR_KERNEL_HEADERS := device/motorola/sm4250-common-kernel/kernel-headers

# Rootdir Path
MOTOROLA_ROOT := $(PLATFORM_COMMON_PATH)/rootdir

# Overlay
DEVICE_PACKAGE_OVERLAYS += \
    $(PLATFORM_COMMON_PATH)/overlay

# Camera
TARGET_USES_64BIT_CAMERA := true

# Keymaster
TARGET_KEYMASTER_V4_1 := true

# Vibrator
TARGET_VIBRATOR_V1_2 := true

# BT definitions for Qualcomm solution
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
TARGET_USE_QTI_BT_STACK := true
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(PLATFORM_COMMON_PATH)/bluetooth

# Dynamic Partitions: Enable DP
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# A/B support
AB_OTA_UPDATER := true
PRODUCT_SHIPPING_API_LEVEL := 29

# A/B OTA dexopt package
PRODUCT_PACKAGES += \
    otapreopt_script

# A/B OTA dexopt update_engine hookup
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# A/B related packages
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_client \
    update_engine_sideload \
    update_verifier \
    bootctrl.sm4250-common \
    bootctrl.sm4250-common.recovery

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    system \
    vendor \
    vbmeta \
    vbmeta_system

# Dynamic Partitions: build fastbootd
PRODUCT_PACKAGES += \
    fastbootd

# Treble
# Include vndk/vndk-sp/ll-ndk modules
PRODUCT_PACKAGES += \
    vndk_package

# Device Specific Permissions
PRODUCT_COPY_FILES += \
     frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.gyroscope.xml \
     frameworks/native/data/etc/android.hardware.sensor.barometer.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.barometer.xml \
     frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepcounter.xml \
     frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.sensor.stepdetector.xml

# Audio
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/etc/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml \
    $(MOTOROLA_ROOT)/vendor/etc/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(MOTOROLA_ROOT)/vendor/etc/audio_policy_configuration_bluetooth_legacy_hal.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration_bluetooth_legacy_hal.xml

# Media
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/etc/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    $(MOTOROLA_ROOT)/vendor/etc/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    $(MOTOROLA_ROOT)/vendor/etc/media_profiles_V1_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \
    $(MOTOROLA_ROOT)/vendor/etc/media_profiles_vendor.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_vendor.xml

# Qualcom WiFi Overlay
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/etc/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    $(MOTOROLA_ROOT)/vendor/etc/wifi/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf

# Qualcom WiFi Configuration
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/qca_cld/WCNSS_qcom_cfg.ini

# MSM IRQ Balancer configuration file
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/etc/msm_irqbalance.conf:$(TARGET_COPY_OUT_VENDOR)/etc/msm_irqbalance.conf

# Platform specific init
PRODUCT_PACKAGES += \
    ueventd

# Sensors
# hardware.ssc.so links against display mappers, of which
# the interface libraries are explicitly included here:
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.0-service.multihal \
    vendor.qti.hardware.display.mapper@1.1.vendor \
    vendor.qti.hardware.display.mapper@3.0.vendor

# Look for camera.qcom.so instead of camera.$(BOARD_TARGET_PLATFORM).so
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware.camera=qcom

# QCOM Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    persist.vendor.qcom.bluetooth.soc=cherokee

# Legacy BT property (will be removed in S)
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.qcom.bluetooth.soc=cherokee

# Audio - QCOM HAL
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.audio.feature.concurrent_capture.enable=true \
    vendor.audio.feature.compress_in.enable=true

# Audio - QCOM proprietary
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.audio.adm.buffering.ms=2

# USB controller setup
PRODUCT_PROPERTY_OVERRIDES += \
    sys.usb.controller=4e00000.dwc3 \
    sys.usb.rndis.func.name=gsi

# Display
PRODUCT_PROPERTY_OVERRIDES += \
    debug.sf.enable_advanced_sf_phase_offset=1 \
    debug.sf.high_fps_late_sf_phase_offset_ns=-5000000 \
    debug.sf.high_fps_early_phase_offset_ns=-5000000 \
    debug.sf.high_fps_early_gl_phase_offset_ns=-5000000

# Gatekeeper
PRODUCT_PROPERTY_OVERRIDES += \
    vendor.gatekeeper.disable_spu=true

# Init
PRODUCT_COPY_FILES += \
    device/qcom/common/vendor/init/bengal/bin/init.kernel.post_boot.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.kernel.post_boot.sh

PRODUCT_PACKAGES += \
    init.mmi.charge_only.rc \
    init.mmi.chipset.rc \
    init.mmi.overlay.rc \
    init.oem.fingerprint.sh \
    init.oem.fingerprint2.sh \
    init.target.rc \
    vendor_modprobe.sh

PRODUCT_SOONG_NAMESPACES += device/qcom/common/vendor/init

# vndservicemanager
PRODUCT_PACKAGES += \
    vndservicemanager

# FPSensor Gestures
PRODUCT_COPY_FILES += \
    $(MOTOROLA_ROOT)/vendor/usr/keylayout/uinput-fpc.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/uinput-fpc.kl \
    $(MOTOROLA_ROOT)/vendor/usr/idc/uinput-fpc.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/uinput-fpc.idc

$(call inherit-product, device/motorola/common/common.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
#$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)
$(call inherit-product, vendor/motorola/sm4250-common/sm4250-common-vendor.mk)
