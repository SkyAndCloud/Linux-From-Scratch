#!/bin/bash
find . | cpio -H newc -o | gzip > /boot/sin_init.img
file /boot/sin_init.img
