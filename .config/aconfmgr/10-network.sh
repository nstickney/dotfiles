if ! DetectWSL; then # Networking already handled (?) in WSL (?)

	# Firewall
	AddPackage iptables-nft # Linux kernel packet control tool (using nft interface)
	CreateLink /etc/systemd/system/multi-user.target.wants/iptables.service /usr/lib/systemd/system/iptables.service

	# NetworkManager
	AddPackage networkmanager             # Network connection manager and user applications
	AddPackage networkmanager-openconnect # NetworkManager VPN plugin for OpenConnect
	AddPackage networkmanager-openvpn     # NetworkManager VPN plugin for OpenVPN
	CreateLink /etc/systemd/system/dbus-org.freedesktop.NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
	CreateLink /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service /usr/lib/systemd/system/NetworkManager-dispatcher.service
	CreateLink /etc/systemd/system/multi-user.target.wants/NetworkManager.service /usr/lib/systemd/system/NetworkManager.service

	# Tools
	AddPackage iproute2        # IP Routing Utilities
	AddPackage zerotier-one    # Creates virtual Ethernet networks of almost unlimited size.
	AddPackage wireguard-tools # next generation secure network tunnel - tools for configuration

	# Wireless only when not in VMs
	if ! DetectVM; then
		AddPackage iw # nl80211 based CLI configuration utility for wireless devices
	fi
fi

# Hosts file
cat >>"$(GetPackageOriginalFile filesystem /etc/hosts)" <<-EOF
	127.0.0.1 localhost $HOSTNAME
	::1       localhost $HOSTNAME
EOF

# SSH
AddPackage mosh  # Mobile shell, surviving disconnects with local echo and line editing
AddPackage sshfs # FUSE client based on the SSH File Transfer Protocol
CreateLink /etc/systemd/system/multi-user.target.wants/sshd.service /usr/lib/systemd/system/sshd.service
CreateLink /etc/systemd/user/sockets.target.wants/gcr-ssh-agent.socket /usr/lib/systemd/user/gcr-ssh-agent.socket

## SSH server configuration hardening
sshd_conf="$(GetPackageOriginalFile openssh /etc/ssh/sshd_config)"
sed -i 's/^#LoginGraceTime.*$/LoginGraceTime 30s/g' "$sshd_conf"
sed -i 's/^#PermitRootLogin.*$/PermitRootLogin no/g' "$sshd_conf"
sed -i 's/^MaxAuthTries.*$/MaxAuthTries 3/g' "$sshd_conf"
sed -i 's/^MaxSessions.*$/MaxSessions 5/g' "$sshd_conf"
sed -i 's/^#PasswordAuthentication.*$/PasswordAuthentication no/g' "$sshd_conf"
sed -i 's/^KbdInteractiveAuthentication.*$/KbdInteractiveAuthentication no/g' "$sshd_conf"
sed -i 's/^AllowAgentForwarding.*$/AllowAgentForwarding no/g' "$sshd_conf"
