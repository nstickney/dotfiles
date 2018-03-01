#!/bin/bash

# Find the default interface with its IP address and netmask
the_interface="$(ip route | grep default | awk '{print $5}')"
the_network="$(ip addr | grep "$the_interface$" | awk '{print $2}')"

# Turn off everything in the public zone
firewall-cmd --permanent --zone=public --remove-service=dhcpv6-client
firewall-cmd --permanent --zone=public --remove-service=ssh

# Enable the internal zone
firewall-cmd --permanent --zone=internal --add-source="$the_network"

# Turn off everything (except ssh) in the internal zone
firewall-cmd --permanent --zone=internal --remove-service=dhcpv6-client
firewall-cmd --permanent --zone=internal --remove-service=mdns
firewall-cmd --permanent --zone=internal --remove-service=samba-client
#firewall-cmd --permanent --zone=internal --remove-service=ssh

# Reload the new configuration
firewall-cmd --reload
