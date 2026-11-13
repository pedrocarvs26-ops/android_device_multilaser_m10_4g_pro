#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Enable updating of APEXes
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# API levels
PRODUCT_SHIPPING_API_LEVEL := 29

# fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service

# Wi-Fi (AOSP HAL talks to vendor wpa_supplicant)
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service

# Overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay
PRODUCT_ENFORCE_RRO_TARGETS := *

# Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Product characteristics
PRODUCT_CHARACTERISTICS := tablet

# Rootdir
PRODUCT_PACKAGES += \
    log_to_csv.sh \
    loading.sh \
    para.sh \
    total.sh \

PRODUCT_PACKAGES += \
    fstab.s9863a1h10 \
    init.cali.rc \
    init.common.rc \
    init.factorytest.rc \
    init.ram.rc \
    init.s9863a1h10.rc \
    init.s9863a1h10.usb.rc \
    init.storage.rc \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/fstab.s9863a1h10:$(TARGET_COPY_OUT_RAMDISK)/fstab.s9863a1h10

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit the proprietary files
$(call inherit-product, vendor/multilaser/ML_SO0G_M10_4G_PRO_PLUS/ML_SO0G_M10_4G_PRO_PLUS-vendor.mk)
