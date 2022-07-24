#!/bin/bash

# Well, I got the back bone of the script from a random post on the Internet but can no longer
# find it. The funny thing is the same thing happened to poster online and they got it from somewhere
# else, so it's fair I guess.


# Now what this script does is it keeps on checking whether OpenVPN is on or not.

PATH_TO_OPENVPN_CONFIG=$1
PRIVATE_IP=${2:-10.8.0.1}

while true; do
        sleep 30
        target=$PRIVATE_IP # The IP we're checking

        # Just because the ping got refused once doesn't mean OpenVPN is not connected,
        # as sometimes it just happens. What we will do is ping it once as a time and
        # if all fails, then we can confidently conclude that the VPN is actually off.
        count=$( ping -w 30 -c 1 $target | grep icmp* | wc -l )

        if [ $count -eq 0 ]
        then

        echo "Restarting VPN"
        killall openvpn
        sleep 5
        systemctl restart openvpn
        sleep5
        openvpn --config $PATH_TO_OPENVPN_CONFIG &
        sleep5

        else

        echo "VPN is Running"

        fi
done
