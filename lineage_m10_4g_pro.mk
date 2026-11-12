#
# Copyright (C) 2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_tablet_wifionly.mk)

# Inherit from m10_4g_pro device
$(call inherit-product, device/multilaser/m10_4g_pro/device.mk)

PRODUCT_DEVICE := m10_4g_pro
PRODUCT_NAME := lineage_m10_4g_pro
PRODUCT_BRAND := Multilaser
PRODUCT_MODEL := M10_4G_PRO
PRODUCT_MANUFACTURER := Multilaser

PRODUCT_GMS_CLIENTID_BASE := android-multilaser

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=M10_4G_PRO \
    TARGET_DEVICE=m10_4g_pro \
    PRIVATE_BUILD_DESC="sf960asa_1h10_ac-user 10 V16_20221110 16 release-keys"

BUILD_FINGERPRINT := Multilaser/M10_4G_PRO/ML_SO0G_M10_4G_PRO_PLUS:10/V16_20221110/16:user/release-keys
