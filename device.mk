#
# Copyright (C) 2026 OrangeFox Recovery Project
# Device: Xiaomi myron (POCO F8 Ultra / Redmi K90 Pro Max)
# Branch: OrangeFox 14.1
# SoC   : Snapdragon 8 Elite Gen 5 (SM8850 / sun)
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/xiaomi/myron

# ─── Inheritance ──────────────────────────────────────────────────────────────
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression_with_xor.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, vendor/twrp/config/common.mk)

# ─── API level ────────────────────────────────────────────────────────────────
# Confirmed: ro.product.first_api_level=35, ro.board.first_api_level=35 (getprop)
BOARD_SHIPPING_API_LEVEL   := 34
PRODUCT_SHIPPING_API_LEVEL := 34

# ─── Dynamic partitions ───────────────────────────────────────────────────────
# Confirmed: ro.boot.dynamic_partitions=true, ro.virtual_ab.enabled=true (getprop)
PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_VIRTUAL_AB_OTA         := true

# ─── Fuse passthrough ─────────────────────────────────────────────────────────
# Confirmed: persist.sys.fuse.passthrough.enable=true (getprop)
PRODUCT_PROPERTY_OVERRIDES += persist.sys.fuse.passthrough.enable=true

# ─── Soong namespaces ─────────────────────────────────────────────────────────
PRODUCT_SOONG_NAMESPACES += $(DEVICE_PATH)

# ─── lptools ──────────────────────────────────────────────────────────────────
PRODUCT_PACKAGES += \
    lpflash \
    lpmake \
    lpunpack

# ─── Release key ──────────────────────────────────────────────────────────────
PRODUCT_EXTRA_RECOVERY_KEYS += \
    $(DEVICE_PATH)/security/releasekey

# ─── Required modules ─────────────────────────────────────────────────────────
TWRP_REQUIRED_MODULES += \
    prebuilt

# ─────────────────────────────────────────────────────────────────────────────
# Recovery root files — Vendor binaries
# Confirmed from adb shell (stock ROM TWRP ramdisk, same vendor partition sm8850)
# CRITICAL for Keymint / Gatekeeper / qseecomd decryption chain
# ─────────────────────────────────────────────────────────────────────────────

# Vendor init RC files
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/root/vendor/etc/init/android.hardware.boot-service.qti.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/android.hardware.boot-service.qti.rc \
    $(DEVICE_PATH)/recovery/root/vendor/etc/init/android.hardware.gatekeeper-service-qti.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/android.hardware.gatekeeper-service-qti.rc \
    $(DEVICE_PATH)/recovery/root/vendor/etc/init/android.hardware.health-service.qti.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/android.hardware.health-service.qti.rc \
    $(DEVICE_PATH)/recovery/root/vendor/etc/init/android.hardware.secure_element-service.qti.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/android.hardware.secure_element-service.qti.rc \
    $(DEVICE_PATH)/recovery/root/vendor/etc/init/android.hardware.security.keymint-service-qti.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/android.hardware.security.keymint-service-qti.rc \
    $(DEVICE_PATH)/recovery/root/vendor/etc/init/qseecomd.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/qseecomd.rc \
    $(DEVICE_PATH)/recovery/root/vendor/etc/init/ssgtzd.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/init/ssgtzd.rc

# Vendor VINTF manifests
# Confirmed keymint version=3 from odm vintf xml (adb shell)
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/root/vendor/etc/vintf/manifest.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest.xml \
    $(DEVICE_PATH)/recovery/root/vendor/etc/vintf/manifest_xiaomi_sm8850.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest_sun.xml \
    $(DEVICE_PATH)/recovery/root/vendor/etc/vintf/manifest/android.hardware.security.keymint-service-qti.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest/android.hardware.security.keymint-service-qti.xml \
    $(DEVICE_PATH)/recovery/root/vendor/etc/vintf/manifest/android.hardware.weaver-service.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest/android.hardware.weaver-service.xml \
    $(DEVICE_PATH)/recovery/root/vendor/etc/vintf/manifest/android.hardware.health-service.qti.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest/android.hardware.health-service.qti.xml \
    $(DEVICE_PATH)/recovery/root/vendor/etc/vintf/manifest/boot-service.qti.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest/boot-service.qti.xml \
    $(DEVICE_PATH)/recovery/root/vendor/etc/vintf/manifest/android.hardware.wifi.supplicant.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/vintf/manifest/android.hardware.wifi.supplicant.xml

# Vendor misc configs
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/root/vendor/etc/charger_fw_fstab.qti:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/charger_fw_fstab.qti \
    $(DEVICE_PATH)/recovery/root/vendor/etc/gpfspath_oem_config.xml:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/gpfspath_oem_config.xml \
    $(DEVICE_PATH)/recovery/root/vendor/etc/ssg/ta_config.json:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/ssg/ta_config.json \
    $(DEVICE_PATH)/recovery/root/vendor/etc/ueventd.rc:$(TARGET_COPY_OUT_RECOVERY)/root/vendor/etc/ueventd.rc

# WiFi ko loader script
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/root/system/bin/cp-wifi-ko.sh:$(TARGET_COPY_OUT_RECOVERY)/root/system/bin/cp-wifi-ko.sh

# System VINTF framework manifest
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery/root/system/etc/vintf/manifest.xml:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/vintf/manifest.xml

# ─────────────────────────────────────────────────────────────────────────────
# Recovery root files — ODM binaries
# Confirmed from adb shell:
#   /odm/bin/hw/ contains keymint-strongbox, weaver-service, vibratorfeature
#   /odm/lib64/ contains ese_weaver_thales.so, libjc_keymint*.so, libaachaptics.so
#   init.svc.odm.weaver-service=running, odm.keymint-strongbox=running (getprop)
# ─────────────────────────────────────────────────────────────────────────────

# ODM HAL binaries
# FIX: dùng TARGET_COPY_OUT_ODM thay vì TARGET_COPY_OUT_RECOVERY/root/odm/
# OFox 14.1 rsync tạo symlink root/odm→/odm sau build — nếu root/odm là
# thư mục thực (có file) thì rsync fail "cannot delete non-empty directory"
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/odm/bin/hw/android.hardware.security.keymint-service.strongbox:$(TARGET_COPY_OUT_ODM)/bin/hw/android.hardware.security.keymint-service.strongbox \
    $(DEVICE_PATH)/odm/bin/hw/android.hardware.weaver-service:$(TARGET_COPY_OUT_ODM)/bin/hw/android.hardware.weaver-service \
    $(DEVICE_PATH)/odm/bin/hw/vendor.xiaomi.hardware.vibratorfeature.service:$(TARGET_COPY_OUT_ODM)/bin/hw/vendor.xiaomi.hardware.vibratorfeature.service

# ODM libs (NXP JavaCard transport + weaver + haptics)
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/odm/lib64/ese_weaver_thales.so:$(TARGET_COPY_OUT_ODM)/lib64/ese_weaver_thales.so \
    $(DEVICE_PATH)/odm/lib64/libjc_keymint-thales.so:$(TARGET_COPY_OUT_ODM)/lib64/libjc_keymint-thales.so \
    $(DEVICE_PATH)/odm/lib64/libjc_keymint_transport-thales.so:$(TARGET_COPY_OUT_ODM)/lib64/libjc_keymint_transport-thales.so \
    $(DEVICE_PATH)/odm/lib64/libaachaptics.so:$(TARGET_COPY_OUT_ODM)/lib64/libaachaptics.so

# ODM scripts and misc bins
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/odm/bin/prepdecrypt.sh:$(TARGET_COPY_OUT_ODM)/bin/prepdecrypt.sh \
    $(DEVICE_PATH)/odm/bin/variant-script.sh:$(TARGET_COPY_OUT_ODM)/bin/variant-script.sh \
    $(DEVICE_PATH)/odm/bin/se_omapi:$(TARGET_COPY_OUT_ODM)/bin/se_omapi \
    $(DEVICE_PATH)/odm/bin/touch_report:$(TARGET_COPY_OUT_ODM)/bin/touch_report \
    $(DEVICE_PATH)/odm/bin/init.kernel.post_boot-sun_default_6_2.sh:$(TARGET_COPY_OUT_ODM)/bin/init.kernel.post_boot-sun_default_6_2.sh

# ODM init RC files
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/odm/etc/init/android.hardware.security.keymint-service.strongbox.rc:$(TARGET_COPY_OUT_ODM)/etc/init/android.hardware.security.keymint-service.strongbox.rc \
    $(DEVICE_PATH)/odm/etc/init/android.hardware.weaver-service.rc:$(TARGET_COPY_OUT_ODM)/etc/init/android.hardware.weaver-service.rc \
    $(DEVICE_PATH)/odm/etc/init/se_omapi.rc:$(TARGET_COPY_OUT_ODM)/etc/init/se_omapi.rc \
    $(DEVICE_PATH)/odm/etc/init/prepdecrypt.rc:$(TARGET_COPY_OUT_ODM)/etc/init/prepdecrypt.rc \
    $(DEVICE_PATH)/odm/etc/init/variant-script.rc:$(TARGET_COPY_OUT_ODM)/etc/init/variant-script.rc \
    $(DEVICE_PATH)/odm/etc/init/init.kernel.post_boot-sun.rc:$(TARGET_COPY_OUT_ODM)/etc/init/init.kernel.post_boot-sun.rc \
    $(DEVICE_PATH)/odm/etc/init/touch_report.rc:$(TARGET_COPY_OUT_ODM)/etc/init/touch_report.rc \
    $(DEVICE_PATH)/odm/etc/init/vendor.xiaomi.hardware.vibratorfeature.service.rc:$(TARGET_COPY_OUT_ODM)/etc/init/vendor.xiaomi.hardware.vibratorfeature.service.rc

# ODM VINTF manifests
# AOSP 14 cấm PRODUCT_COPY_FILES cho odm/etc/vintf/ — dùng ODM_MANIFEST_FILES
ODM_MANIFEST_FILES += \
    $(DEVICE_PATH)/odm/etc/vintf/manifest.xml

ODM_MANIFEST_SKUS += myron
ODM_MANIFEST_MYRON_FILES := \
    $(DEVICE_PATH)/odm/etc/vintf/manifest/android.hardware.security.keymint-service.strongbox.xml \
    $(DEVICE_PATH)/odm/etc/vintf/manifest/android.hardware.security.sharedsecret-service.strongbox.xml \
    $(DEVICE_PATH)/odm/etc/vintf/manifest/se_omapi.xml \
    $(DEVICE_PATH)/odm/etc/vintf/manifest/vendor.xiaomi.hardware.vibratorfeature.service.xml

# ODM ueventd rules
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/odm/etc/ueventd.rc:$(TARGET_COPY_OUT_ODM)/etc/ueventd.rc

# Haptics firmware (cs40l26)
# Confirmed: ro.odm.mm.vibrator.device_type=agm, resonant_frequency=170 (getprop)
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/prebuilt/lib/firmware/cs40l26.bin:$(TARGET_COPY_OUT_RECOVERY)/root/lib/firmware/cs40l26.bin \
    $(DEVICE_PATH)/prebuilt/lib/firmware/cs40l26.wmfw:$(TARGET_COPY_OUT_RECOVERY)/root/lib/firmware/cs40l26.wmfw \
    $(DEVICE_PATH)/prebuilt/lib/firmware/cs40l26-calib.bin:$(TARGET_COPY_OUT_RECOVERY)/root/lib/firmware/cs40l26-calib.bin \
    $(DEVICE_PATH)/prebuilt/lib/firmware/cs40l26-calib.wmfw:$(TARGET_COPY_OUT_RECOVERY)/root/lib/firmware/cs40l26-calib.wmfw \
    $(DEVICE_PATH)/prebuilt/lib/firmware/cs40l26-a2h.bin:$(TARGET_COPY_OUT_RECOVERY)/root/lib/firmware/cs40l26-a2h.bin \
    $(DEVICE_PATH)/prebuilt/lib/firmware/cs40l26-a2h1.bin:$(TARGET_COPY_OUT_RECOVERY)/root/lib/firmware/cs40l26-a2h1.bin \
    $(DEVICE_PATH)/prebuilt/lib/firmware/cs40l26-dbc.bin:$(TARGET_COPY_OUT_RECOVERY)/root/lib/firmware/cs40l26-dbc.bin \
    $(DEVICE_PATH)/prebuilt/lib/firmware/cs40l26-dvl.bin:$(TARGET_COPY_OUT_RECOVERY)/root/lib/firmware/cs40l26-dvl.bin \
    $(DEVICE_PATH)/prebuilt/lib/firmware/cs40l26-svc.bin:$(TARGET_COPY_OUT_RECOVERY)/root/lib/firmware/cs40l26-svc.bin
