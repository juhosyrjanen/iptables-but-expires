#!/bin/bash
#This will clear added rules and return orig. state

if ! [ $(id -u) = 0 ]; then
   echo "I am not root!"
   exit 1
fi
echo
echo -e "Clear iptables and revert changes?"
echo 
echo -e "y/n?"
read answer1

if  [ "$answer1" == "n" ]; then
    echo -e "Exiting.."
    exit 1
else
   netfilter-persistent reload
   echo 
   echo "Reloaded persistent rules."
   echo "exiting.."