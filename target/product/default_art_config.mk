#
# Copyright (C) 2020 The Android Open Source Project
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
#

# This file contains product config for the ART module that is common for
# platform and unbundled builds.

ifeq ($(ART_APEX_JARS),)
  $(error ART_APEX_JARS is empty; cannot initialize PRODUCT_BOOT_JARS variable)
endif

# Order of the jars on BOOTCLASSPATH follows:
# 1. ART APEX jars
# 2. System jars
# 3. System_ext jars
# 4. Non-updatable APEX jars
# 5. Updatable APEX jars
#
# ART APEX jars (1) are defined in ART_APEX_JARS. System and system_ext boot jars are defined below
# in PRODUCT_BOOT_JARS. All other non-art APEX boot jars are part of the PRODUCT_APEX_BOOT_JARS.
#
# The actual runtime ordering matching above is determined by derive_classpath service at runtime.
# See packages/modules/SdkExtensions/README.md for more details.

# The order of PRODUCT_BOOT_JARS matters for runtime class lookup performance.
PRODUCT_BOOT_JARS := \
    $(ART_APEX_JARS)

# List of jars to be included in the ART boot image for testing.
# DO NOT reorder this list. The order must match the one described above.
# Note: We use the host variant of "core-icu4j" and "conscrypt" for testing.
PRODUCT_TEST_ONLY_ART_BOOT_IMAGE_JARS := \
    $(ART_APEX_JARS) \
    platform:core-icu4j-host \
    platform:conscrypt-host \

# /system and /system_ext boot jars.
PRODUCT_BOOT_JARS += \
    framework-minus-apex \
    framework-graphics \
    ext \
    telephony-common \
    voip-common \
    ims-common

# APEX boot jars. Keep the list sorted by module names and then library names.
# Note: core-icu4j is moved back to PRODUCT_BOOT_JARS in product_config.mk at a later stage.
# Note: For modules available in Q, DO NOT add new entries here.
PRODUCT_APEX_BOOT_JARS := \
    com.android.adservices:framework-adservices \
    com.android.adservices:framework-sdksandbox \
    com.android.appsearch:framework-appsearch \
    com.android.btservices:framework-bluetooth \
    com.android.conscrypt:conscrypt \
    com.android.i18n:core-icu4j \
    com.android.ipsec:android.net.ipsec.ike \
    com.android.media:updatable-media \
    com.android.mediaprovider:framework-mediaprovider \
    com.android.ondevicepersonalization:framework-ondevicepersonalization \
    com.android.os.statsd:framework-statsd \
    com.android.permission:framework-permission \
    com.android.permission:framework-permission-s \
    com.android.scheduling:framework-scheduling \
    com.android.sdkext:framework-sdkextensions \
    com.android.tethering:framework-connectivity \
    com.android.tethering:framework-connectivity-t \
    com.android.tethering:framework-tethering \
    com.android.uwb:framework-uwb \
    com.android.virt:framework-virtualization \
    com.android.wifi:framework-wifi \

# List of system_server classpath jars delivered via apex.
# Keep the list sorted by module names and then library names.
# Note: For modules available in Q, DO NOT add new entries here.
PRODUCT_APEX_SYSTEM_SERVER_JARS := \
    com.android.adservices:service-adservices \
    com.android.adservices:service-sdksandbox \
    com.android.appsearch:service-appsearch \
    com.android.art:service-art \
    com.android.media:service-media-s \
    com.android.permission:service-permission \
    com.android.rkpd:service-rkp \

# Use $(wildcard) to avoid referencing the profile in thin manifests that don't have the
# art project.
ifneq (,$(wildcard art))
  PRODUCT_DEX_PREOPT_BOOT_IMAGE_PROFILE_LOCATION += art/build/boot/boot-image-profile.txt
endif

# List of jars on the platform that system_server loads dynamically using separate classloaders.
# Keep the list sorted library names.
PRODUCT_STANDALONE_SYSTEM_SERVER_JARS := \

# List of jars delivered via apex that system_server loads dynamically using separate classloaders.
# Keep the list sorted by module names and then library names.
# Note: For modules available in Q, DO NOT add new entries here.
PRODUCT_APEX_STANDALONE_SYSTEM_SERVER_JARS := \
    com.android.btservices:service-bluetooth \
    com.android.os.statsd:service-statsd \
    com.android.scheduling:service-scheduling \
    com.android.tethering:service-connectivity \
    com.android.threadnetwork:service-threadnetwork \
    com.android.uwb:service-uwb \
    com.android.wifi:service-wifi \

# Overrides the (apex, jar) pairs above when determining the on-device location. The format is:
# <old_apex>:<old_jar>:<new_apex>:<new_jar>
PRODUCT_CONFIGURED_JAR_LOCATION_OVERRIDES := \
    platform:framework-minus-apex:platform:framework \
    platform:core-icu4j-host:com.android.i18n:core-icu4j \
    platform:conscrypt-host:com.android.conscrypt:conscrypt \

# Minimal configuration for running dex2oat (default argument values).
# PRODUCT_USES_DEFAULT_ART_CONFIG must be true to enable boot image compilation.
PRODUCT_USES_DEFAULT_ART_CONFIG := true
PRODUCT_SYSTEM_PROPERTIES += \
    dalvik.vm.image-dex2oat-Xms=64m \
    dalvik.vm.image-dex2oat-Xmx=64m \
    dalvik.vm.dex2oat-Xms=64m \
    dalvik.vm.dex2oat-Xmx=512m \

PRODUCT_ENABLE_UFFD_GC := default
