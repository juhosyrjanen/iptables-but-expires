#!/bin/bash
#This script will allow you to set an expiring iptables rule 

#if [ "$EUID" -ne 0 ]
#  then echo "Run as root, exiting.."
#  exit
#fi

echo -e "Enter IP, PROTOCOL & PORT to be opened in the Firewall"
echo -e "Enter IP and press [ENTER]"
read d_ip 
echo -e "Enter PROTOCOL (tcp/udp as string) and press [ENTER]"
read protocol
echo -e "Enter PORT and press [ENTER]"
read d_port

echo -e "-- -- --"
echo -e "Is this correct?"
echo -e "IP $d_ip"
echo -e "Protocol $protocol"
echo -e "Port $d_port"
echo -e "-- -- --"

echo -e "y/n?"
read answer1

if  [ "$answer1" == "n" ]; then
    echo -e "Rerun script. Exiting.."
    exit 1
else
    echo -e "Saving to iptables.."
    echo -e "-- -- --"
    echo -e "iptables -I INPUT -p $protocol -s $d_ip --dport $d_port  -j ACCEPT"
    echo -e "-- -- --"
    echo -e "Set expire time in hours: "
    read expire
    echo -e "Setting rule to expire in $expire seconds."
    iptables -I INPUT -p $protocol -s $d_ip --dport $d_port  -j ACCEPT
    echo "iptables -I INPUT -p $protocol -s $d_ip --dport $d_port  -j DROP" | at now +$expire hour
    exit 1
 fi

 #else ["$answer1" == "y"]; then