#!/bin/bash

#info @ EOF

block=$(smartctl --all /dev/sda | grep 'Short offline' | grep '# 1' | awk '{print $10}')
echo "Fixing: " $block

calcForm="(($block-2048)*512)/4096"

ddblock=$(echo $calcForm | bc)

#echo '(($block-2048)*512)/4096'

echo "for dd: " $ddblock
dd if=/dev/random of=/dev/sda1 bs=4096 count=1 seek=$block
echo ""

let ddblock+=1
echo "for dd: " $ddblock
dd if=/dev/random of=/dev/sda1 bs=4096 count=1 seek=$block
echo ""

let ddblock-=2
echo "for dd: " $ddblock
dd if=/dev/random of=/dev/sda1 bs=4096 count=1 seek=$block
echo ""

smartctl -t short /dev/sda -q errorsonly
sleep 10
echo "New badblock: "
smartctl --all /dev/sda | grep 'Short offline' | grep '# 1' | awk '{print $10}'

exit 0

#######

SRC: https://linoxide.com/linux-how-to/how-to-fix-repair-bad-blocks-in-linux/

bc 1.07.1
Copyright 1991-1994, 1997, 1998, 2000, 2004, 2006, 2008, 2012-2017 Free Software Foundation, Inc.
This is free software with ABSOLUTELY NO WARRANTY.
For details type `warranty'. 
L=99846
(standard_in) 1: syntax error
l=99846
s=2048
b=4096
(l-s)*512
50072576
50072576/b
12224
l=109614
((l-s)*512)/b
13445
l=128153
((l-s)*512)/b
15763
l=484030
((l-s)*512)/b
60247
