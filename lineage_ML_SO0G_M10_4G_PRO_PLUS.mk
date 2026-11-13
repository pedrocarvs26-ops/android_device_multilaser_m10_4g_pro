#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from ML_SO0G_M10_4G_PRO_PLUS device
$(call inherit-product, device/multilaser/ML_SO0G_M10_4G_PRO_PLUS/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_DEVICE := ML_SO0G_M10_4G_PRO_PLUS
PRODUCT_NAME := lineage_ML_SO0G_M10_4G_PRO_PLUS
PRODUCT_BRAND := Multilaser
PRODUCT_MODEL := M10_4G_PRO
PRODUCT_MANUFACTURER := multilaser

PRODUCT_GMS_CLIENTID_BASE := android-multilaser

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="sf960asa_1h10_ac-user 10 V16_20221110 16 release-keys" \
    BuildFingerprint=Multilaser/M10_4G_PRO/ML_SO0G_M10_4G_PRO_PLUS:10/V16_20221110/16:user/release-keys
