#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# API levels
PRODUCT_SHIPPING_API_LEVEL := 29

# Dynamic partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := tablet

# Overlays
DEVICE_PACKAGE_OVERLAYS += \
    $(LOCAL_PATH)/overlay

PRODUCT_ENFORCE_RRO_TARGETS := *

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd

# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# Audio
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/audio,$(TARGET_COPY_OUT_VENDOR)/etc)

# Media
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/media,$(TARGET_COPY_OUT_VENDOR)/etc)

# Permissions
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,$(LOCAL_PATH)/configs/permissions,$(TARGET_COPY_OUT_VENDOR)/etc/permissions)

# Wi-Fi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wifi/wpa_supplicant.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant.conf

# Input (Keylayout & IDC)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/keylayout/adaptive_ts.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/adaptive_ts.kl \
    $(LOCAL_PATH)/configs/keylayout/gpio-keys.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/configs/keylayout/gslX680_ts.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/gslX680_ts.kl \
    $(LOCAL_PATH)/configs/idc/adaptive_ts.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/adaptive_ts.idc

# Rootdir init scripts & fstab
PRODUCT_PACKAGES += \
    fstab.s9863a1h10 \
    fstab.enableswap \
    init.cali.rc \
    init.common.rc \
    init.factorytest.rc \
    init.gslX680.rc \
    init.leddrv.rc \
    init.ram.rc \
    init.s9863a1h10.rc \
    init.s9863a1h10.usb.rc \
    init.sprd_flash.rc \
    init.storage.rc \
    init.tcs3430.rc \
    init.vibdrv.rc \
    init_expand.rc \
    ueventd.s9863a1h10.rc

PRODUCT_PACKAGES += \
    loading.sh \
    log_to_csv.sh \
    para.sh \
    total.sh

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.s9863a1h10:$(TARGET_COPY_OUT_RAMDISK)/fstab.s9863a1h10 \
    $(LOCAL_PATH)/rootdir/etc/fstab.s9863a1h10:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.s9863a1h10 \
    $(LOCAL_PATH)/rootdir/etc/ueventd.s9863a1h10.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc

# Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery.fstab:recovery/root/system/etc/recovery.fstab

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit proprietary vendor makefile if available
$(call inherit-product-if-exists, vendor/multilaser/m10_4g_pro/m10_4g_pro-vendor.mk)
