#!/bin/sh
# by seba3567
# for linux

cores="-j13" # defines cores for build
allowbuild="1" # whats devices build?
#setup 1
codename1="evert" # codename1 first define
buildtype1="userdebug" # define userdebug build or eng , user
# setup2 
codename2="sofiar" # codename2 second define
buildtype2="userdebug" # define userdebug build or eng

rom="kangos" # set rom makefiles like lineage or omni (it mandatory for lunch devices example lunch lineage_evert-userdebug)
kernelzip="obj/KERNEL_OBJ/arch/arm64/boot/" # kernel directory

DTB="Image.gz-dtb" # kernel image with dtb
GZ="Image.gz" # kernel image without dtb

outfolders="/home/seba_3567/Escritorio/kangos/out/target/product/"
home="/home/seba_3567/Escritorio/kangos/"

echo "sync last build"
repo sync --force-sync $cores

cd build && source envsetup.sh
cd ..

if lunch1 "$allowbuild" = "1" then
   echo "launch for 1 devices"
    lunch "$rom"_$codename1-$buildtype1
    m bacon $cores
else not detect two devices
fi 

if lunch2 "$allowbuild" = "2" then
   echo "launch for two devices"   
    lunch "$rom"_$codename1-$buildtype1
    m  $cores
    lunch "$rom"_$codename2-$buildtype2
    m bacon $cores
else echo "not detect dual devices support"
fi

# create folders scripts
rm -r -f android-tree-folders
mkdir android-tree-folders
cd $outfolders/$codename/$kernelzip


if [ -f "$DTB" ]; then
    echo "$DTB exists."
    dtb=1
    else dtb=0
fi

if create [[(dtb=1) || ("$allowbuild" ="1")]] then
   cp $outfolders/$codename1/$kernelzip/$DTB -f $home/android-tree-folders/$codename1
   else echo "run dual build dtb stuff"
fi

if create2 [[(dtb=1) || ("$allowbuild" ="2")]] then
   cp $outfolders/$codename1/$kernelzip/$DTB -f $home/android-tree-folders/$codename1
   cp $outfolders/$codename2/$kernelzip/$DTB -f $home/android-tree-folders/$codename2
   else echo "you run for one script?"
fi

if create [[(dtb=0) || ("$allowbuild" ="1")]] then
   cp $outfolders/$codename1/$kernelzip/$GZ -f $home/android-tree-folders/$codename1
   else echo "run .gz for dual lunch devices"
fi
if create [[(dtb=0) || ("$allowbuild" ="2")]] then
   cp $outfolders/$codename1/$kernelzip/$GZ -f $home/android-tree-folders/$codename1
   cp $outfolders/$codename2/$kernelzip/$GZ -f $home/android-tree-folders/$codename2
   else echo "no detect .gz for dual devices"
fi

#cd $home
#cd android-tree-folders
#echo "detect this devices"
#if zip1 "$allowbuild" = "1" then
#   $codename1
exit


