#!/bin/bash

#Hbase ports
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 60000 -j DNAT --to 10.0.1.110:60000
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 60010 -j DNAT --to 10.0.1.110:60010
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 60020 -j DNAT --to 10.0.1.110:60020
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 60030 -j DNAT --to 10.0.1.110:60030

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
