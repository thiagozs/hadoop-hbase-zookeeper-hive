#!/bin/bash

#Config para sua vm ficar transprente a maquina ponte.
sudo iptables -t nat -A POSTROUTING -o vboxnet1 -j MASQUERADE
sudo iptables -A FORWARD -i vboxnet1 -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i eth0 -o vboxnet1 -j ACCEPT

#Hbase ports
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 60000 -j DNAT --to 10.0.1.110:60000
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 60010 -j DNAT --to 10.0.1.110:60010
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 60030 -j DNAT --to 10.0.1.110:60030
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 60020 -j DNAT --to 10.0.1.111:60020

#Hadoop ports
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 50030 -j DNAT --to 10.0.1.110:50030
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 50070 -j DNAT --to 10.0.1.110:50070
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 50075 -j DNAT --to 10.0.1.110:50075

#Thrift
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 9090 -j DNAT --to 10.0.1.110:9090

#ZooKeeper
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 2181 -j DNAT --to 10.0.1.110:2181

#Save =)
sudo iptables-save
