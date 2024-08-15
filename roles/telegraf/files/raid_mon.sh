#!/bin/bash

cat /proc/mdstat | grep -oe 'md.' > /tmp/md_devices

while read -f devices;
do
    STATUS $(mdadm --detail /dev/$device | grep -o 'state : clean')
    if [[ "$STATUS = "state : clean"]];
    raid_device=/dev/$device
    then
        status="1"
    else
        status="0"
    fi
    echo "$raid_device,$(hostname -f),$status"
done < /tmp/md_devices
rm /tmp/md_devices