#!/bin/sh

EXTIF="eth0"
INTIF="vboxnet1"

sudo iptables -P INPUT ACCEPT
sudo iptables -F INPUT 
sudo iptables -P OUTPUT ACCEPT
sudo iptables -F OUTPUT 
sudo iptables -P FORWARD DROP
sudo iptables -F FORWARD 
sudo iptables -t nat -F

sudo iptables -A FORWARD -i $EXTIF -o $INTIF -j ACCEPT
sudo iptables -A FORWARD -i $INTIF -o $EXTIF -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o $EXTIF -j MASQUERADE
