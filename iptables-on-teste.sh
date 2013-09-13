#!/bin/bash

sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X
sudo iptables -P INPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -L

sudo iptables -t nat -A POSTROUTING -o vboxnet1 -j MASQUERADE
sudo iptables -A FORWARD -i vboxnet1 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i eth0 -o vboxnet1 -j ACCEPT

sudo iptables -t nat -A PREROUTING -p tcp -d 10.0.0.24 --dport 60000 -j DNAT --to 10.0.1.110:60000
sudo iptables -A OUTPUT -o eth0 -p tcp --sport 60000 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -i eth0 -p tcp --dport 60000 -m state --state NEW,ESTABLISHED -j ACCEPT

sudo iptables -t nat -A PREROUTING -p tcp -d 10.0.0.24 --dport 60010 -j DNAT --to 10.0.1.110:60010
sudo iptables -A OUTPUT -o eth0 -p tcp --sport 60010 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -i eth0 -p tcp --dport 60010 -m state --state NEW,ESTABLISHED -j ACCEPT

sudo iptables -t nat -A PREROUTING -p tcp -d 10.0.0.24 --dport 60020 -j DNAT --to 10.0.1.110:60020
sudo iptables -A OUTPUT -o eth0 -p tcp --sport 60020 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -i eth0 -p tcp --dport 60020 -m state --state NEW,ESTABLISHED -j ACCEPT

sudo iptables -t nat -A PREROUTING -p tcp -d 10.0.0.24 --dport 60030 -j DNAT --to 10.0.1.110:60030
sudo iptables -A OUTPUT -o eth0 -p tcp --sport 60030 -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -i eth0 -p tcp --dport 60030 -m state --state NEW,ESTABLISHED -j ACCEPT
