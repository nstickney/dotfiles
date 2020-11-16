AddPackage aerc                        # Email Client for your Terminal
AddPackage dante                       # aerc opt dep
AddPackage w3m                         # aerc opt dep
AddPackage amfora                      # Terminal browser for the Gemini protocol
AddPackage aria2                       # Download utility that supports HTTP(S), FTP, BitTorrent, and Metalink
AddPackage avahi                       # Service Discovery for Linux using mDNS/DNS-SD -- compatible with Bonjour
AddPackage bind                        # A complete, highly portable implementation of the DNS protocol
AddPackage bmon                        # Portable bandwidth monitor and rate estimator
AddPackage discord                     # All-in-one voice and text chat for gamers that's free and secure.
AddPackage geoip-database-extra        # bind-tools opt dep
AddPackage chromium                    # A web browser built for speed, simplicity, and security
AddPackage --foreign chromium-widevine # A browser plugin designed for the viewing of premium video content
AddPackage dhcpcd                      # RFC2131 compliant DHCP client daemon
AddPackage dnsmasq                     # Lightweight, easy to configure DNS forwarder and DHCP server
AddPackage firefox                     # Standalone web browser from mozilla.org
AddPackage --foreign gmni-git          # A Gemini client
AddPackage inetutils                   # A collection of common network programs
AddPackage iproute2                    # IP Routing Utilities
AddPackage iputils                     # Network monitoring tools, including ping
AddPackage irssi                       # Modular text mode IRC client with Perl scripting
AddPackage lynx                        # A text browser for the World Wide Web
AddPackage mosh                        # Mobile shell, surviving disconnects with local echo and line editing
AddPackage mtr                         # Combines the functionality of traceroute and ping into one tool (CLI version)
AddPackage networkmanager              # Network connection manager and user applications
AddPackage network-manager-applet      # Applet for managing network connections
AddPackage networkmanager-openconnect  # NetworkManager VPN plugin for OpenConnect
AddPackage networkmanager-openvpn      # NetworkManager VPN plugin for OpenVPN
AddPackage ngrep                       # A grep-like utility that allows you to search for network packets on an interface.
AddPackage nm-connection-editor        # NetworkManager GUI connection editor and widgets
AddPackage nss-mdns                    # glibc plugin providing host name resolution via mDNS
AddPackage obs-studio                  # Free, open source software for live streaming and recording
AddPackage openssh                     # Free version of the SSH connectivity tools
AddPackage openvpn                     # An easy-to-use, robust and highly configurable VPN (Virtual Private Network)
AddPackage python2-dbus                # avahi optionally requires python2-dbus: avahi-discover
AddPackage remmina                     # remote desktop client written in GTK+
AddPackage libvncserver                # remmina opt dep
AddPackage signal-desktop              # Electron application that links with Signal on mobile
AddPackage --foreign slack-desktop     # Slack Desktop (Beta) for Linux
AddPackage sshfs                       # FUSE client based on the SSH File Transfer Protocol
AddPackage tcpdump                     # Powerful command-line packet analyzer
AddPackage --foreign teams             # Microsoft Teams for Linux is your chat-centered workspace in Office 365
AddPackage traceroute                  # Tracks the route taken by packets over an IP network
AddPackage wget                        # A network utility to retrieve files from the Web
AddPackage whois                       # Intelligent WHOIS client
AddPackage wireguard-tools             # next generation secure network tunnel
AddPackage openresolv                  # wireguard opt dep
AddPackage youtube-dl                  # A small command-line program to download videos from YouTube.com and a few more sites
AddPackage zerotier-one                # Creates virtual Ethernet networks of almost unlimited size.

# AddPackage --foreign chromium-widevine # A browser plugin designed for the viewing of premium video content
# AddPackage --foreign lbry-app-bin      # The LBRY app built using electron
# AddPackage --foreign networkmanager-wireguard-git # NetworkManager VPN plugin for WireGuard - git
# AddPackage privoxy # A web proxy with advanced filtering capabilities.
# AddPackage tor # Anonymizing overlay network
# AddPackage --foreign teams         # Microsoft Teams for Linux is your chat-centered workspace in Office 365
# AddPackage --foreign zoom          # Video Conferencing and Web Conferencing Service

sed "s|%SLACK_URL%|$SLACK_URL|g" <<-'EOF' >"$(CreateFile /etc/ssh/sshrc)"
	#!/bin/sh

	ip="$(echo "$SSH_CONNECTION" | cut -d " " -f 1)"
	host="$(uname -n)"
	curl -X POST -H 'Content-type: application/json' --data '{"text":"'$host': new login ('$USER') from '$ip'"}' https://hooks.slack.com/services/%SLACK_URL% > /dev/null 2>&1
EOF

CopyFile /etc/avahi/avahi-daemon.conf
# CopyFile /etc/privoxy/config
CopyFile /etc/sysctl.d/51-net.conf
CreateLink /etc/systemd/system/dbus-org.freedesktop.Avahi.service /usr/lib/systemd/system/avahi-daemon.service
CreateLink /etc/systemd/system/multi-user.target.wants/avahi-daemon.service /usr/lib/systemd/system/avahi-daemon.service
CreateLink /etc/systemd/system/multi-user.target.wants/iptables.service /usr/lib/systemd/system/iptables.service
CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/multi-user.target.wants/sshd.service /usr/lib/systemd/system/sshd.service
CreateLink /etc/systemd/system/sockets.target.wants/avahi-daemon.socket /usr/lib/systemd/system/avahi-daemon.socket
