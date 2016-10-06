#!/bin/bash
if [ $# -ne 1 ]; then
	echo "Usage: $0 image_name"
	exit 1
fi

make -j9
cp ./arch/x86/boot/bzImage "/media/yongshan/$1"
chmod +x "/media/yongshan/$1"
make modules_install
rm -rf /media/yongshan/sin_init/lib/modules/4*
cp -r /lib/modules/4* /media/yongshan/sin_init/lib/modules/
cd /media/yongshan/sin_init
. ./gen_img.sh
cd -
du -h ./arch/x86/boot/bzImage
mount /dev/sdc1 /media/yongshan/yong
cp /media/yongshan/kernel_sin /media/yongshan/sin_init.img /media/yongshan/yong
