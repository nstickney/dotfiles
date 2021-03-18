if ! DetectVM; then # No peripherals on virtual machines

	# Android Phones
	AddPackage android-udev # Udev rules to connect Android devices to your linux box
	AddPackage gvfs-mtp     # Virtual filesystem implementation for GIO (MTP backend; Android, media player)

	# Bluetooth
	CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service /usr/lib/systemd/system/bluetooth.service
	CreateLink /etc/systemd/system/dbus-org.bluez.service /usr/lib/systemd/system/bluetooth.service

	# CAC
	AddPackage ccid   # A generic USB Chip/Smart Card Interface Devices driver
	AddPackage opensc # Tools and libraries for smart cards
	CreateLink /etc/systemd/system/sockets.target.wants/pcscd.socket /usr/lib/systemd/system/pcscd.socket

	# CD/DVD
	AddPackage brasero             # CD/DVD mastering tool
	AddPackage libdvdcss           # Portable abstraction library for DVD decryption
	AddPackage --foreign regionset # read/sets the region code of DVD drives

	# Printing
	## https://wiki.archlinux.org/index.php/CUPS#Network
	## https://wiki.archlinux.org/index.php/Avahi#Hostname_resolution
	AddPackage avahi    # # Service Discovery for Linux using mDNS/DNS-SD -- compatible with Bonjour
	AddPackage cups     # The CUPS Printing System - daemon package
	AddPackage cups-pdf # PDF printer for cups
	AddPackage nss-mdns # glibc plugin providing host name resolution via mDNS
	mdns_conf="$(GetPackageOriginalFile filesystem /etc/nsswitch.conf)"
	sed -i 's/resolve/mdns_minimal [NOTFOUND=return] resolve/g' "$mdns_conf"
	CreateLink /etc/systemd/system/dbus-org.freedesktop.Avahi.service /usr/lib/systemd/system/avahi-daemon.service
	CreateLink /etc/systemd/system/multi-user.target.wants/avahi-daemon.service /usr/lib/systemd/system/avahi-daemon.service
	CreateLink /etc/systemd/system/sockets.target.wants/avahi-daemon.socket /usr/lib/systemd/system/avahi-daemon.socket
	# https://wiki.archlinux.org/index.php/CUPS#Socket_activation
	CreateLink /etc/systemd/system/sockets.target.wants/cups.socket /usr/lib/systemd/system/cups.socket

	AddPackage --foreign brother-mfc-j480dw    # CUPS and LPR drivers for the Brother MFC-J480DW printer
	AddPackage --foreign xerox-workcentre-6515 # CUPS driver for the Xerox WorkCentre 6515

fi
