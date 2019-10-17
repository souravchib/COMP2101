#!/bin/bash
#
# this script displays some host identification information for a simple Linux machine
#
# Sample output:
#   Hostname        : hostname
#   LAN Address     : 192.168.2.2
#   LAN Hostname    : host-name-from-hosts-file
#   External IP     : 1.2.3.4
#   External Name   : some.name.from.our.isp
#   lan_hostname=$(getent hosts $(ip a s $(ip a |awk '/: e/{gsub(/:/,"");print $2}'))|awk '/inet /{gsub(/\/.*/,"");print $2}' | awk '{print $2}')


# Task 1: Add a section to the script to define variables which hold the output data for
#         each output item and move the commands which generate the data to that section so that
#         the output command only outputs the labels and single variables.

# Task 2: Add output items for the default router's name and IP address,
#         adding a name to your /etc/hosts file as needed.
# e.g.
#   Router Address  : 192.168.2.1
#   Router Hostname : router-name-from-hosts-file

# Task 3: Add output items for the network's name and IP address, adding a name to your /etc/networks file as needed.
# e.g.
#   Network Number. : 192.168.2.0
#   Network Name    : network-name-from-networks-file

# we use the hostname command to get our system name
# the LAN name is looked up using the LAN address in case it is different from the system name
# finding external information relies on curl being installed and relies on live internet connection
# awk is used to extract only the data we want displayed from the commands which produce extra data
# this command is ugly done this way, so generating the output data into variables is recommended to make the script more readable.
# e.g.
#   interface_name=$(ip a |awk '/: e/{gsub(/:/,"");print $2}')
my_hostname=$(hostname)
interface_name=$(ip a |awk '/: e/{gsub(/:/,"");print $2}')
lan_address=$(ip a s $interface_name|awk '/inet /{gsub(/\/.*/,"");print $2}')
lan_hostname=$(getent hosts $lan_address | awk '{print $2}')
router_address=$(route -n | grep 'UG[ \t]' | awk '{print $2}')
external_ip=$(curl -s icanhazip.com)
network_name=$(cat /etc/networks | awk 'NR==3{print $1; exit}')
router_hostname=$(route | grep "default" | awk '{print $2}')
network_number=$(cat /etc/networks | awk 'NR==3{print $2; exit}')
external_name=$(getent hosts $external_ip | awk '{print $2}')

cat <<EOF
Hostname        : $my_hostname
LAN Address     : $lan_address
LAN Hostname    : $lan_hostname
External IP     : $external_ip
External Name   : $external_name
Router Address  : $router_address
Router Hostname : $router_hostname
Network Number  : $network_number
Network Name    : $network_name
EOF
