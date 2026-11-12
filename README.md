# Device Tree for Multilaser M10 4G Pro (Android 10)

```
    Device: Multilaser M10 4G Pro
    Codename / Model: M10_4G_PRO / ML_SO0G_M10_4G_PRO_PLUS
    Platform / SoC: Unisoc SC9863A (sharkl3 / sp9863a_1h10)
    Architecture: ARM64 (arm64-v8a + armeabi-v7a)
    Kernel: Linux 4.14.133
    Android Version: 10 (Q - API 29)
```

---

## 📱 Hardware Specifications

| Component | Specification |
| :--- | :--- |
| **SoC** | Unisoc (Spreadtrum) SC9863A (sharkl3) |
| **CPU** | 8x ARM Cortex-A55 (4x 1.6 GHz + 4x 1.2 GHz) |
| **GPU** | PowerVR Rogue GE8322 (IMG) |
| **Display** | 10.1" IPS LCD, 1280x800 px (WXGA, 160 DPI) |
| **RAM** | 3 GB / 4 GB LPDDR4x |
| **Storage** | 32 GB / 64 GB eMMC 5.1 |
| **Touchscreen** | Silead GSLx680 (`init.gslX680.rc`) |
| **Sensors** | AMS TCS3430 light/color, Accelerometer |
| **Fingerprint** | Chipone (`chipone,fingerprint`) |
| **Connectivity** | Wi-Fi 802.11 a/b/g/n/ac Dual Band, Bluetooth 4.2/5.0, GPS/GLONASS (Marlin3) |
| **Modem** | 4G LTE Cat 4, VoLTE, VoWiFi |

---

## 🗂️ Partition Map & Super Details

This device utilizes Android 10 Dynamic Partitions (`super.img`):

* **Super Partition Size**: `4,299,161,600` bytes (4.29 GB)
* **Dynamic Partition Group**: `group_unisoc`
* **Dynamic Group Max Size**: `4,294,967,296` bytes
* **Dynamic Partitions**:
  * `system` (ext4)
  * `vendor` (ext4)
  * `product` (ext4)
* **Boot Image Header**: Version 2 (pagesize: 2048, ramdisk offset: `0x05400000`, tags offset: `0x00000100`)
* **Kernel Image**: `prebuilts/kernel` (Linux 4.14.133, Clang 9.0.3)
* **DTB / DTBO**: `prebuilts/dtb.img` and `prebuilts/dtbo.img`
* **AVB**: Android Verified Boot 2.0 (`vbmeta`, `vbmeta_system`, `vbmeta_vendor`)

---

## 📁 Repository Structure

```
device/multilaser/m10_4g_pro/
├── Android.bp
├── Android.mk
├── AndroidProducts.mk
├── BoardConfig.mk
├── device.mk
├── lineage_m10_4g_pro.mk
├── omni_m10_4g_pro.mk             # TWRP / OrangeFox target
├── extract-files.sh               # Bash vendor blob extractor
├── extract-files.py               # Python vendor blob extractor
├── setup-makefiles.sh
├── setup-makefiles.py
├── proprietary-files.txt          # List of 1100+ stock vendor blobs
├── system.prop
├── vendor.prop
├── product.prop
├── vendorsetup.sh
├── configs/
│   ├── audio/                     # Audio policy and effects XMLs
│   ├── idc/                       # Input device configuration
│   ├── keylayout/                 # Button and touchscreen keylayouts
│   ├── media/                     # Hardware codec profiles & configs
│   ├── permissions/               # Android feature permissions
│   ├── vintf/                     # HAL manifest & compatibility matrix
│   └── wifi/                      # wpa_supplicant config
├── overlay/                       # RRO framework configs & calibrations
├── prebuilts/
│   ├── kernel                     # Stock stock-verified kernel
│   ├── dtb.img                    # Device tree blob
│   ├── dtbo.img                   # Device tree overlay blob
│   └── kernel_config.txt          # Full extracted kernel .config (118KB)
├── recovery/
│   └── root/etc/recovery.fstab    # TWRP recovery partition table
└── rootdir/
    ├── bin/                       # Init helper shell scripts
    └── etc/                       # Init rc scripts, fstab, and ueventd
```

---

## 🚀 How to Build

### 1. Extract Proprietary Blobs
Before compiling, extract vendor blobs either from a connected device running stock firmware via ADB:
```bash
./extract-files.sh
```
Or from an extracted firmware dump directory:
```bash
./extract-files.sh /path/to/stock_dump/
```

### 2. Build LineageOS (Android 10 / 11)
```bash
# Initialize build environment
source build/envsetup.sh

# Lunch target
lunch lineage_m10_4g_pro-userdebug

# Start build
mka bacon -j$(nproc)
```

### 3. Build TWRP Recovery
```bash
# Initialize build environment
source build/envsetup.sh

# Lunch target
lunch omni_m10_4g_pro-eng

# Build recovery image
mka recoveryimage -j$(nproc)
```
