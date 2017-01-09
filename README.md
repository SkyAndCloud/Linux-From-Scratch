# SinOS


## First of all
This is a mini-linux customized from Cent OS 6.8, which is a work like [LFS](http://www.linuxfromscratch.org/lfs/). It's based on kernel version 4.7.4 and my own initrd. By the way, this OS just was customized for my Lenovo G410 due to the kernel I have compiled.

## Description
- linux kernel customized from version 4.7.4
- initrd customized from Cent OS 6.8
- grub 2

## Features
- mount windows **FAT/NTFS** file system
- ethernet eth2 support with DHCP
- ssh/sshd support
- multi-user login support
- mentohust support

## Bugs
1. Can not type in sometimes.

## ps
1. 先使用`make defconfig`生成默认配置，再`make localmodconfig` 添加必须要添加的驱动，`make menuconfig`中删除不必要的网卡驱动可以大幅减小体积
2. 关掉所有的`Kernel hacking`可以减小约0.7M的内核体积，Security option也可以全部关掉
3. 尽量将设备驱动编译成为模块，查看选项的HELP，其中会有提示建议选择y还是n, 当然也要依情况而定，如果自己真的是对应于那个选项的情况
   肯定还是要打开的，我之前就有一个`AHCI`相关的选项，内核建议关掉，可是我的设备就是应该打开才能跑
4. `udevd` 的运行需要网络相关的支持，不要将关键性的非驱动网络选项编译为模块，否则udevd 将无法开启
5. 期间各个命令若不能运行请用`strace` 查看执行过程中是否缺失某些命令
6. 如果需要`DHCP`的支持，必须将原来系统（此处指Cent OS6.8)的某些命令或配置(如`dhclient`)添加进小系统
   比如对于`udevd`的配置，建议在根目录下执行 `find . -name "*udevd*"`
7. 在小系统中拷贝命令依赖的库文件时，注意有些库仍依赖于其他的库，如果命令不能运行参见Tips 5
8. `LVM，NTFS-3g, Grub install` 请尽量参考下面的链接
9. **最重要**的一点!!! 请务必使用`git`做好版本控制
10. `gunzip < /boot/initrd.img | cpio -i --make-directories` extract initrd.img    
    `find . | cpio -H newc -o | gzip > /boot/initrd.img` compress initrd.img
11. 应尽量安装grub2, 详见Arch wiki中关于grub的章节,进入grub shell后可能需要`root`的值如`(hd0,msdos1)`,这样才可以找到文件

## Helpful Links
- [Linux from scratch](http://www.linuxfromscratch.org/blfs/view/svn/longindex.html#kernel-config-index)
- [Arch wiki](https://wiki.archlinux.org/)
- [Gentoo wiki](https://wiki.gentoo.org/wiki/LVM#Kernel)
- [Linux kernel config manual](http://forum.ubuntu.org.cn/viewtopic.php?f=56&t=149260)
- [Linux kernel config reference](http://www.linuxtopia.org/online_books/linux_kernel/kernel_configuration/ch09s05.html)

