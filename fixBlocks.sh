#!/bin/bash

#info @ EOF
#Скриптец проходится по ошибкам на диске и затирает их ddшкой.
#ACHTUNG! данные на диске могут быть утеряны!
#Написано для диска sdba с одним разделом sdb1 на весь диск

DISK="/dev/sda"

block=$(sudo smartctl --all $DISK | grep 'Short offline' | head -1 | awk '{print $10}')

[ -z $block ] && print 'no bad blocks!' && exit 0

echo "Fixing: " $block

sudo hdparm --read-sector $block $DISK 
sudo hdparm --repair-sector $block --yes-i-know-what-i-am-doing $DISK 
sudo hdparm --read-sector $block $DISK

sudo smartctl -t short $DISK -q errorsonly
date
while `sudo smartctl -a $DISK | grep -q 'Self_test_in_progress'`
do
	sleep 1
done

sleep 20
echo "New badblock: "
sudo smartctl --all $DISK | grep 'Short offline' | grep '# 1' | awk '{print $10}'

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
