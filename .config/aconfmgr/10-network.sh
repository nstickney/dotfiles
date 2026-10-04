if ! DetectWSL; then # Networking already handled (?) in WSL (?)

  if DetectIntelNetwork; then
    DetectRealtekNetwork && CopyFile /etc/udev/rules.d/81-realtek-hci.rules
  fi

  # Firewall
  AddPackage nftables # Netfilter tables userspace tools
  CreateLink /etc/systemd/system/multi-user.target.wants/nftables.service /usr/lib/systemd/system/nftables.service
  CopyFile /etc/nftables.conf

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
sed -i "s/localhost/localhost $HOSTNAME/g" "$(GetPackageOriginalFile filesystem /etc/hosts)"

# SSH
AddPackage mosh  # Mobile shell, surviving disconnects with local echo and line editing
AddPackage sshfs # FUSE client based on the SSH File Transfer Protocol
CreateLink /etc/systemd/system/multi-user.target.wants/sshd.service /usr/lib/systemd/system/sshd.service
CreateLink /etc/systemd/user/sockets.target.wants/gcr-ssh-agent.socket /usr/lib/systemd/user/gcr-ssh-agent.socket

## SSH server configuration hardening
## Drop-in (first value wins; 50- sorts before Arch's 99-archlinux.conf)
cat >"$(CreateFile /etc/ssh/sshd_config.d/50-hardening.conf)" <<-EOF
	LoginGraceTime 30s
	PermitRootLogin no
	MaxAuthTries 3
	MaxSessions 5
	PasswordAuthentication no
	KbdInteractiveAuthentication no
	AllowAgentForwarding no
EOF
