#!/bin/bash
# (c) juhosyrjänen 2020
#This script will allow you to set an expiring iptables rule 

if ! [ $(id -u) = 0 ]; then
   echo "I am not root!"
   exit 1
fi

echo 
echo
echo -e "Enter IP, PROTOCOL & PORT to be opened in the Firewall"
echo 
echo -e "Enter IP and press [ENTER]"
read d_ip 
echo -e "Enter PROTOCOL (tcp/udp as string) and press [ENTER]"
read protocol
echo -e "Enter PORT and press [ENTER]"
read d_port

echo -e "-- -- --"
echo
echo -e "Is this correct?"
echo -e "IP $d_ip"
echo -e "Protocol: $protocol"
echo -e "Port $d_port"
echo
echo -e "-- -- --"

echo -e "y/n?"
read answer1

if  [ "$answer1" == "n" ]; then
    echo -e "Rerun script. Exiting.."
    exit 1
else
    echo -e "Saving to iptables.."
    echo
    echo -e "-- -- --"
    echo -e "iptables -I INPUT -p $protocol -s $d_ip --dport $d_port  -j ACCEPT"
    echo -e "-- -- --"
    echo
    echo -e "Set expire time in hours: "
    read expire
    echo -e "Setting rule to expire in $expire seconds."
    echo -e "Running DROP in $expire hour(s)."
    echo
    echo -e "-- -- --"
    echo -e "Running iptables commands now.."
    iptables -I INPUT -p $protocol -s $d_ip --dport $d_port  -j ACCEPT
    echo "iptables -D INPUT -s $d_ip -p $protocol --dport $d_port  -j ACCEPT" | at now +$expire hour
    echo -e "-- -- --"
    echo
    echo -e "Rule added, drop set in $expire hour(s), exiting.."
    exit 1
 fi

