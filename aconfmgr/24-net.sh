AddPackage --foreign aerc # Email Client for your Terminal
AddPackage aria2 # Download utility that supports HTTP(S), FTP, BitTorrent, and Metalink
AddPackage avahi # Service Discovery for Linux using mDNS/DNS-SD -- compatible with Bonjour
AddPackage bind-tools # The ISC DNS tools
AddPackage geoip-database-extra # bind-tools opt dep
AddPackage chromium # A web browser built for speed, simplicity, and security
AddPackage dhcpcd # RFC2131 compliant DHCP client daemon
AddPackage dnsmasq # Lightweight, easy to configure DNS forwarder and DHCP server
AddPackage firefox # Standalone web browser from mozilla.org
AddPackage --foreign google-talkplugin # Video chat browser plug-in for Google Talk
AddPackage inetutils # A collection of common network programs
AddPackage iproute2 # IP Routing Utilities
AddPackage iputils # Network monitoring tools, including ping
AddPackage irssi # Modular text mode IRC client with Perl scripting
AddPackage lynx # A text browser for the World Wide Web
AddPackage mosh # Mobile shell, surviving disconnects with local echo and line editing
AddPackage mtr # Combines the functionality of traceroute and ping into one tool (CLI version)
AddPackage networkmanager # Network connection manager and user applications
AddPackage networkmanager-openconnect # NetworkManager VPN plugin for OpenConnect
AddPackage networkmanager-openvpn # NetworkManager VPN plugin for OpenVPN
AddPackage --foreign networkmanager-wireguard-git # NetworkManager VPN plugin for WireGuard - git
AddPackage ngrep # A grep-like utility that allows you to search for network packets on an interface.
AddPackage nss-mdns # glibc plugin providing host name resolution via mDNS
AddPackage obs-studio # Free, open source software for live streaming and recording
AddPackage openssh # Free version of the SSH connectivity tools
AddPackage openvpn # An easy-to-use, robust and highly configurable VPN (Virtual Private Network)
AddPackage python2-dbus # avahi optionally requires python2-dbus: avahi-discover
AddPackage --foreign signal-desktop-bin # Private messaging from your desktop
AddPackage sniffglue # Secure multithreaded packet sniffer
AddPackage sshfs # FUSE client based on the SSH File Transfer Protocol
AddPackage tcpdump # Powerful command-line packet analyzer
AddPackage traceroute # Tracks the route taken by packets over an IP network
AddPackage wget # A network utility to retrieve files from the Web
AddPackage whois # Intelligent WHOIS client
AddPackage wireguard-arch # Wireguard module for Arch Kernel
AddPackage youtube-dl # A small command-line program to download videos from YouTube.com and a few more sites
AddPackage --foreign zoom # Video Conferencing and Web Conferencing Service

# AddPackage --foreign chromium-widevine # A browser plugin designed for the viewing of premium video content
# AddPackage privoxy # A web proxy with advanced filtering capabilities.
# CopyFile /etc/privoxy/config
# AddPackage tor # Anonymizing overlay network

CopyFile /etc/avahi/avahi-daemon.conf
CopyFile /etc/sysctl.d/51-net.conf
CreateLink /etc/systemd/system/dbus-org.freedesktop.Avahi.service /usr/lib/systemd/system/avahi-daemon.service
CreateLink /etc/systemd/system/multi-user.target.wants/avahi-daemon.service /usr/lib/systemd/system/avahi-daemon.service
CreateLink /etc/systemd/system/multi-user.target.wants/iptables.service /usr/lib/systemd/system/iptables.service
CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/sockets.target.wants/avahi-daemon.socket /usr/lib/systemd/system/avahi-daemon.socket
