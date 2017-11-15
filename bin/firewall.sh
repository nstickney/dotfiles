#!/bin/sh

LOOPBACK_IF="lo"
LOOPBACK_ADDR="127.0.0.1"
#INTRANET="" # Intranet
CLASS_A="10.0.0.0/8" # Class A private networks
CLASS_B="172.16.0.0/12" # Class B private networks
CLASS_C="192.168.0.0/16" # Class C private networks
CLASS_D="224.0.0.0/4" # Class D multicast addresses
CLASS_E="240.0.0.0/5" # Class E reserved addresses

# Clear initial rules and set default policy (DROP)
iptables -F
iptables -P INPUT DROP
iptables -P OUTPUT ACCEPT # Really want to make this DROP
iptables -P FORWARD DROP

# Allow loopback in and out
iptables -A INPUT -i $LOOPBACK_IF -j ACCEPT

# Allow established connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow services from within intranet ONLY
#iptables -A INPUT -p tcp -s $INTRANET --dport 22 $NEW -j ACCEPT # SSH

# Bad addresses (including source address spoofing) and bad packets
# Only uncomment these if you are going to allow some services below.
#iptables -A INPUT -m state --state INVALID -j DROP # Invalid connections
#iptables -A INPUT -s $LOOPBACK_ADDR -j DROP # Loopback spoofing
#iptables -A INPUT -s $IP_ADDR -j DROP # Host spoofing
#iptables -A INPUT -s $CLASS_A -j DROP # Class A
#iptables -A INPUT -s $CLASS_B -j DROP # Class B
#iptables -A INPUT -s $CLASS_C -j DROP # Class C
#iptables -A INPUT -s $CLASS_D -j DROP # Class D
#iptables -A INPUT -s $CLASS_E -j DROP # Class E

# Protocol-specific servers (uncomment lines for needed services)
#iptables -A INPUT -p tcp --dport 53 $NEW -j ACCEPT # DNS (TCP)
#iptables -A INPUT -p udp --dport 53 $NEW -j ACCEPT # DNS (UDP)
#iptables -A INPUT -p udp --dport 67 $NEW -j ACCEPT # DHCP
#iptables -A INPUT -p udp --dport 68 $NEW -j ACCEPT # DHCP
#iptables -A INPUT -p tcp --dport 21 $NEW -j ACCEPT # FTP
#iptables -A INPUT -p tcp --dport 989 $NEW -j ACCEPT # FTP (TLS/SSL)
#iptables -A INPUT -p tcp --dport 900 $NEW -j ACCEPT # FTP (TLS/SSL)
#iptables -A INPUT -p tcp --dport 80 $NEW -j ACCEPT # HTTP
#iptables -A INPUT -p tcp --dport 443 $NEW -j ACCEPT # HTTPS
#iptables -A INPUT -p tcp --dport 143 $NEW -j ACCEPT # IMAP
#iptables -A INPUT -p tcp --dport 88 $NEW -j ACCEPT # Kerberos (TCP)
#iptables -A INPUT -p udp --dport 88 $NEW -j ACCEPT # Kerberos (UDP)
#iptables -A INPUT -p tcp --dport 389 $NEW -j ACCEPT # LDAP
#iptables -A INPUT -i #INTERNET_IF -p tcp --dport 3268 $NEW -j ACCEPT # LDAP GC
#iptables -A INPUT -p tcp --dport 636 $NEW -j ACCEPT # LDAP SSL
#iptables -A INPUT -i #INTERNET_IF -p tcp --dport 3269 $NEW -j ACCEPT # LDAP SSL GC
#iptables -A INPUT -p tcp --dport 123 $NEW -j ACCEPT # NTP
#iptables -A INPUT -p tcp --dport 110 $NEW -j ACCEPT # POP
#iptables -A INPUT -p tcp --dport 445 $NEW -j ACCEPT # SMB/CIFS (TCP)
#iptables -A INPUT -p udp --dport 445 $NEW -j ACCEPT # SMB/CIFS (UDP)
#iptables -A INPUT -p tcp --dport 24 $NEW -j ACCEPT # SMTP
#iptables -A INPUT -p tcp --dport 1433 $NEW -j ACCEPT # SQL
