AddPackage aria2 # Download utility that supports HTTP(S), FTP, BitTorrent, and Metalink
AddPackage avahi # Service Discovery for Linux using mDNS/DNS-SD -- compatible with Bonjour
AddPackage bind-tools # The ISC DNS tools
# AddPackage chromium # The open-source project behind Google Chrome, an attempt at creating a safer, faster, and more stable browser
AddPackage dhcpcd # RFC2131 compliant DHCP client daemon
AddPackage dnsmasq # Lightweight, easy to configure DNS forwarder and DHCP server
AddPackage fail2ban # Bans IPs after too many failed authentication attempts
# AddPackage icedtea-web # Free web browser plugin to run applets written in Java and an implementation of Java Web Start
AddPackage firefox # Standalone web browser from mozilla.org
AddPackage inetutils # A collection of common network programs
AddPackage iproute2 # IP Routing Utilities
AddPackage iputils # Network monitoring tools, including ping
AddPackage lynx # A text browser for the World Wide Web
AddPackage masscan # TCP port scanner, spews SYN packets asynchronously, scanning entire Internet in under 5 minutes
AddPackage netctl # Profile based systemd network management
AddPackage networkmanager # Network connection manager and user applications
AddPackage networkmanager-openvpn # NetworkManager VPN plugin for OpenVPN
AddPackage nftables # Netfilter tables userspace tools
AddPackage nss-mdns # glibc plugin providing host name resolution via mDNS
AddPackage openssh # Free version of the SSH connectivity tools
AddPackage openvpn # An easy-to-use, robust and highly configurable VPN (Virtual Private Network)
AddPackage privoxy # A web proxy with advanced filtering capabilities.
AddPackage python2-dbus # avahi optionally requires python2-dbus: avahi-discover
AddPackage qbittorrent # An advanced BitTorrent client programmed in C++, based on Qt toolkit and libtorrent-rasterbar
AddPackage sshfs # FUSE client based on the SSH File Transfer Protocol
AddPackage tcpdump # Powerful command-line packet analyzer
AddPackage tor # Anonymizing overlay network
AddPackage wget # A network utility to retrieve files from the Web

# AddPackage --foreign chromium-widevine # A browser plugin designed for the viewing of premium video content
AddPackage --foreign google-talkplugin # Video chat browser plug-in for Google Talk
AddPackage --foreign signal # Signal Private Messenger for the Desktop
# AddPackage --foreign skypeforlinux-bin # Skype for Linux WebRTC Beta
AddPackage --foreign zoom # Video Conferencing and Web Conferencing Service

CopyFile /etc/avahi/avahi-daemon.conf
CopyFile /etc/privoxy/config
CopyFile /etc/sysctl.d/51-net.conf

CreateLink /etc/systemd/system/dbus-org.freedesktop.Avahi.service /usr/lib/systemd/system/avahi-daemon.service
CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/multi-user.target.wants/avahi-daemon.service /usr/lib/systemd/system/avahi-daemon.service
CreateLink /etc/systemd/system/multi-user.target.wants/nftables.service /usr/lib/systemd/system/nftables.service
CreateLink /etc/systemd/system/sockets.target.wants/avahi-daemon.socket /usr/lib/systemd/system/avahi-daemon.socket
