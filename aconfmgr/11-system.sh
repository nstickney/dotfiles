# shellcheck disable=SC2148

AddPackage chrony # Lightweight NTP client and server
CopyFile /etc/locale.gen
CopyFile /etc/modprobe.d/blacklist.conf
CopyFile /etc/systemd/system.conf

# Virtual machine
if sudo dmesg | grep -q "Hypervisor detected"; then
	CopyFile /etc/gdm/custom.conf

	# VirtualBox
	if systemd-detect-virt | grep -i -q oracle; then
		AddPackage virtualbox-guest-modules-arch # Virtualbox guest kernel modules for Arch Kernel
		AddPackage virtualbox-guest-utils # VirtualBox Guest userspace utilities
		CreateLink /etc/systemd/system/multi-user.target.wants/vboxservice.service /usr/lib/systemd/system/vboxservice.service
	fi

# Not a virtual machine
else
	if [ "$USER" == 'stick' ]; then
		# Bluetooth
		AddPackage blueman # GTK+ Bluetooth Manager
		AddPackage --foreign bluez-firmware # Firmwares for Broadcom BCM203x and STLC2300 Bluetooth chips
		AddPackage bluez-utils # Development and debugging utilities for the bluetooth protocol stack
		AddPackage pulseaudio-bluetooth # Bluetooth support for PulseAudio
		CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service /usr/lib/systemd/system/bluetooth.service
		CreateLink /etc/systemd/system/dbus-org.bluez.service /usr/lib/systemd/system/bluetooth.service

		# DVD drives
		AddPackage --foreign regionset # read/sets the region code of DVD drives

		# Printer
		AddPackage --foreign brother-mfc-j480dw # LPR and CUPS driver for the Brother MFC-j480DW
	fi

	AddPackage android-udev # Udev rules to connect Android devices to your linux box
	AddPackage arduino # Arduino prototyping platform SDK
	AddPackage arduino-avr-core # Arduino AVR core with upstream avr-gcc and avrdude
	AddPackage ccid # A generic USB Chip/Smart Card Interface Devices driver
	AddPackage cups # The CUPS Printing System - daemon package
	AddPackage cups-pdf # PDF printer for cups
	AddPackage lm_sensors # Opt dep for i3status-rust-git
	AddPackage mtpfs # A FUSE filesystem that supports reading and writing from any MTP device
	AddPackage opensc # Tools and libraries for smart cards
	AddPackage pcsc-tools # PC/SC Architecture smartcard tools
	AddPackage solaar # Device manager for Logitech's Unifying receiver peripherals
	AddPackage teensy-loader-cli # Command line loader for the teensy microprocessor boards
	AddPackage usb_modeswitch # Activating switchable USB devices on Linux.
	CreateLink /etc/systemd/system/multi-user.target.wants/cups.path /usr/lib/systemd/system/cups.path
	CreateLink /etc/systemd/system/multi-user.target.wants/org.cups.cupsd.path /usr/lib/systemd/system/org.cups.cupsd.path
	CreateLink /etc/systemd/system/multi-user.target.wants/lm_sensors.service /usr/lib/systemd/system/lm_sensors.service
	CreateLink /etc/systemd/system/printer.target.wants/org.cups.cupsd.service /usr/lib/systemd/system/org.cups.cupsd.service
	CreateLink /etc/systemd/system/sockets.target.wants/cups.socket /usr/lib/systemd/system/cups.socket
	CreateLink /etc/systemd/system/sockets.target.wants/pcscd.socket /usr/lib/systemd/system/pcscd.socket
	CreateLink /etc/systemd/system/sockets.target.wants/org.cups.cupsd.socket /usr/lib/systemd/system/org.cups.cupsd.socket
	CopyFile /etc/nsswitch.conf

	### KVM/QEMU
	AddPackage bridge-utils # Utilities for configuring the Linux ethernet bridge
	AddPackage dmidecode # Desktop Management Interface table related utilities
	AddPackage ebtables # Ethernet bridge filtering utilities
	AddPackage libvirt # API for controlling virtualization engines (openvz,kvm,qemu,virtualbox,xen,etc)
	AddPackage qemu # A generic and open source machine emulator and virtualizer
	AddPackage virt-manager # Desktop user interface for managing virtual machines
	AddPackage virt-viewer # A lightweight interface for interacting with the graphical display of virtualized guest OS.
	CreateLink /etc/systemd/system/multi-user.target.wants/libvirtd.service /usr/lib/systemd/system/libvirtd.service
	CreateLink /etc/systemd/system/sockets.target.wants/virtlockd.socket /usr/lib/systemd/system/virtlockd.socket
	CreateLink /etc/systemd/system/sockets.target.wants/virtlogd.socket /usr/lib/systemd/system/virtlogd.socket

	### VirtualBox
	# AddPackage packer-io # tool for creating identical machine images for multiple platforms from a single source configuration
	# AddPackage vagrant # Build and distribute virtualized development environments
	# AddPackage virtualbox # Powerful x86 virtualization for enterprise as well as home use
	# AddPackage virtualbox-ext-vnc # VirtualBox VNC extension pack
	# AddPackage --foreign virtualbox-ext-oracle # Oracle VM VirtualBox Extension Pack
	# AddPackage virtualbox-guest-iso # The official VirtualBox Guest Additions ISO image

	### VMWare
	AddPackage --foreign vmware-workstation # The industry standard for running multiple operating systems as virtual machines on a single Linux PC.
fi

# AMD CPU
if grep -i -q AMD /proc/cpuinfo 2>/dev/null; then
	AddPackage amd-ucode # Microcode update files for AMD CPUs
fi

# Intel CPU/Video
if grep -i -q Intel /proc/cpuinfo 2>/dev/null; then
	AddPackage intel-ucode # Microcode update files for Intel CPUs
	AddPackage xf86-video-intel # X.org Intel i810/i830/i915/945G/G965+ video drivers
fi

# Nvidia (Nouveau)
if lspci -v | grep -i -q nvidia; then
	AddPackage xf86-video-nouveau # Open Source 3D acceleration driver for nVidia cards
fi

# https://wiki.archlinux.org/index.php/Getty#Have_boot_messages_stay_on_tty1
cat > "$(CreateFile /etc/systemd/system/getty@tty1.service.d/noclear.conf)" <<EOF
[Service]
TTYVTDisallocate=no
EOF

# Enable Magic SysRq
echo "kernel.sysrq = 1" > "$(CreateFile /etc/sysctl.d/99-sysrq.conf)"

# Reduce timeouts to sane variables
cat >> "$(GetPackageOriginalFile systemd /etc/systemd/system.conf)" <<EOF
RuntimeWatchdogSec=10min
ShutdownWatchdogSec=10min
DefaultTimeoutStartSec=30s
DefaultTimeoutStopSec=30s
EOF

CopyFile /etc/chrony.conf
CopyFile /etc/locale.conf
CreateLink /etc/localtime /usr/share/zoneinfo/US/Eastern
CreateLink /etc/systemd/system/dbus-org.freedesktop.NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service /usr/lib/systemd/system/NetworkManager-dispatcher.service
CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
CreateLink /etc/systemd/system/multi-user.target.wants/chronyd.service /usr/lib/systemd/system/chronyd.service
CreateLink /etc/systemd/system/multi-user.target.wants/remote-fs.target /usr/lib/systemd/system/remote-fs.target
CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service
