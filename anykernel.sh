### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string=XTurbo Kernel by Xirudly
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=cepheus
device.name2=raphael
device.name3=raphaelin
device.name4=crux
supported.versions=11-16
'; } # end properties


### AnyKernel install
# boot shell variables
BLOCK=/dev/block/bootdevice/by-name/boot;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

# boot install
split_boot;

# patch dtb if using retrofit dynamic partitions
grep -q "logical" /vendor/etc/fstab.qcom;
if [ $? -eq 0 ]; then
    ui_print " " "Retrofit dynamic partitions detected. Patching dtb...";
    fdtput -r $AKHOME/dtb /firmware/android/vbmeta;
    fdtput -r $AKHOME/dtb /firmware/android/fstab;
else
    # patch dtb if using erofs on /vendor
    fs_type=$(mount | grep ' /vendor ' | awk '{print $5}');
    if [ "$fs_type" = "erofs" ]; then
        ui_print " " "EROFS filesystem type on /vendor detected. Patching dtb...";
        fdtput -ts $AKHOME/dtb /firmware/android/fstab/vendor type "erofs";
        fdtput -ts $AKHOME/dtb /firmware/android/fstab/vendor mnt_flags "ro";
    fi;
fi;
cat $AKHOME/Image.gz $AKHOME/dtb > $AKHOME/Image.gz-dtb;
rm -rf $AKHOME/Image.gz $AKHOME/dtb;

flash_boot;
## end boot install

android_sdk=""
mount -o ro,remount /system 2>/dev/null
mount -o ro /system 2>/dev/null
if [ -f /system/build.prop ]; then
  android_sdk=$(sed -n 's/^ro.build.version.sdk=//p' /system/build.prop 2>/dev/null)
fi
umount /system 2>/dev/null

android_sdk=${android_sdk:-36}

if [ "$android_sdk" -le 35 ]; then
  ui_print " " "Detected that the current Android version is Android15 or below, flashing the old dtbo.";
  cp -f "$AKHOME/dtbo_old.img" "$AKHOME/dtbo.img"
fi

flash_dtbo;
