# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=XTurbo-Kernel
do.devicecheck=1
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=cepheus
device.name2=raphael
supported.versions=11-14
'; } # end properties

# shell variables
block=auto;
is_slot_device=auto;
ramdisk_compression=auto;


## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. tools/ak3-core.sh;


## AnyKernel install
split_boot;

mv $home/rd-new.cpio $home/ramdisk-new.cpio


flash_boot;

flash_dtbo;
## end install
