#!/bin/bash
tac ./listmod | while read mod
do
    insmod "$mod"
done
