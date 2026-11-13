#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),ML_SO0G_M10_4G_PRO_PLUS)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
