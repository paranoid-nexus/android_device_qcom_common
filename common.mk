#
# SPDX-FileCopyrightText: Paranoid Android
# SPDX-License-Identifier: Apache-2.0
#

QCOM_COMMON_PATH := device/qcom/common

# Include QCOM targets.
include hardware/qcom-caf/common/qcom_platform_defs.mk

# Include QCOM board utilities.
ifeq ($(TARGET_FWK_SUPPORTS_FULL_VALUEADDS),true)
include vendor/qcom/opensource/core-utils/build/utils.mk
endif

ifeq ($(call is-board-platform-in-list,$(UM_PLATFORMS)),true)
ifeq ($(TARGET_FWK_SUPPORTS_FULL_VALUEADDS),true)
# Compatibility matrix
DEVICE_MATRIX_FILE += \
    device/qcom/vendor-common/compatibility_matrix.xml

DEVICE_FRAMEWORK_COMPATIBILITY_MATRIX_FILE += \
    vendor/qcom/opensource/core-utils/vendor_framework_compatibility_matrix.xml

DEVICE_FRAMEWORK_MANIFEST_FILE += \
    device/qcom/qssi/framework_manifest.xml
endif

# Opt out of 16K alignment changes
PRODUCT_MAX_PAGE_SIZE_SUPPORTED ?= 4096

# Components
include $(QCOM_COMMON_PATH)/components.mk

# Filesystem
TARGET_FS_CONFIG_GEN += $(QCOM_COMMON_PATH)/config.fs

# GPS
PRODUCT_PACKAGES += \
    libcurl

# Media
TARGET_DYNAMIC_64_32_MEDIASERVER := true

# Partition source order for Product/Build properties pickup.
PRODUCT_SYSTEM_PROPERTIES += \
    ro.product.property_source_order=odm,vendor,product,system_ext,system

# Power
ifeq ($(filter perf,$(TARGET_COMMON_QTI_COMPONENTS)),perf)
$(call inherit-product-if-exists, vendor/qcom/opensource/power/power-vendor-product.mk)
endif

# Public Libraries
PRODUCT_COPY_FILES += \
    device/qcom/qssi/public.libraries.product-qti.txt:$(TARGET_COPY_OUT_PRODUCT)/etc/public.libraries-qti.txt \
    device/qcom/qssi/public.libraries.system_ext-qti.txt:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/public.libraries-qti.txt

# Permissions
PRODUCT_COPY_FILES += \
    device/qcom/qssi/privapp-permissions-qti.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/privapp-permissions-qti.xml \
    device/qcom/qssi/privapp-permissions-qti-system-ext.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/permissions/privapp-permissions-qti-system-ext.xml \
    device/qcom/qssi/qti_whitelist.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysconfig/qti_whitelist.xml \
    device/qcom/qssi/qti_whitelist_system_ext.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/qti_whitelist_system_ext.xml \
    device/qcom/qssi_64/qti_broadcast_whitelist.xml:$(TARGET_COPY_OUT_SYSTEM_EXT)/etc/sysconfig/qti_broadcast_whitelist.xml

# QSPA
PRODUCT_PACKAGES += \
    qspa_system.rc \
    qspa_default.rc

# usbudev service for usb ip assigment
PRODUCT_PACKAGES += \
    usbudev

# Vendor Service Manager
PRODUCT_PACKAGES += \
    vndservicemanager

# SoC
PRODUCT_VENDOR_PROPERTIES += \
    ro.soc.manufacturer=QTI

# System Enable QCOM enhanced feature
PRODUCT_SYSTEM_PROPERTIES += \
    ro.vendor.qti.va_aosp.support=1

endif # QCOM_BOARD_PLATFORMS
