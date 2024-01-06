# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
kernel.string=MI9-Kernel
do.devicecheck=0
do.modules=0
do.systemless=0
do.cleanup=1
do.cleanuponabort=0
device.name1=cepheus
device.name2=Cepheus
device.name3=cepheus-user
device.name4=Mi 9
device.name5=Mi9
supported.versions=11-14
supported.patchlevels=
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

case "$ZIPFILE" in
  *66fps*|*66hz*)
    ui_print "  • Setting 66 Hz refresh rate"
    patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=1"
    ;;
  *69fps*|*69hz*)
    ui_print "  • Setting 69 Hz refresh rate"
    patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=2"
    ;;
  *72fps*|*72hz*)
    ui_print "  • Setting 72 Hz refresh rate"
    patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=3"
    ;;
  *75fps*|*75hz*)
    ui_print "  • Setting 75 Hz refresh rate"
    patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=4"
    ;;
   *81fps*|*81hz*)
    ui_print "  • Setting 81 Hz refresh rate"
    patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=5"
    ;;
   *84fps*|*84hz*)
    ui_print "  • Setting 84 Hz refresh rate"
    patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=6"
    ;; 
   *90fps*|*90hz*)
    ui_print "  • Setting 90 Hz refresh rate"
    patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=7"
    ;; 
  *)
    patch_cmdline "msm_drm.framerate_override" ""
    fr=$(cat /sdcard/framerate_override | tr -cd "[0-8]");
    [ $fr -eq 66 ] && ui_print "  • Setting 66 Hz refresh rate" && patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=1"
    [ $fr -eq 69 ] && ui_print "  • Setting 69 Hz refresh rate" && patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=2"
    [ $fr -eq 72 ] && ui_print "  • Setting 72 Hz refresh rate" && patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=3"
    [ $fr -eq 75 ] && ui_print "  • Setting 75 Hz refresh rate" && patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=4"
    [ $fr -eq 81 ] && ui_print "  • Setting 81 Hz refresh rate" && patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=5"
    [ $fr -eq 84 ] && ui_print "  • Setting 84 Hz refresh rate" && patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=6"
    [ $fr -eq 90 ] && ui_print "  • Setting 90 Hz refresh rate" && patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=7"
    [ $fr -eq 93 ] && ui_print "  • Setting 93 Hz refresh rate" && patch_cmdline "msm_drm.framerate_override" "msm_drm.framerate_override=8"
    ;;
esac

flash_boot;

flash_dtbo;
## end install
