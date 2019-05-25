# shellcheck disable=SC2148

AddPackage chrony # Lightweight NTP client and server
CopyFile /etc/locale.gen
CopyFile /etc/modprobe.d/blacklist.conf

# Virtual Machine (any type)
if sudo dmesg | grep -q "Hypervisor detected" && [ -d /etc/gdm ]; then
	CopyFile /etc/gdm/custom.conf
fi

# VirtualBox
if systemd-detect-virt | grep -i -q oracle; then
	AddPackage virtualbox-guest-modules-arch # Virtualbox guest kernel modules for Arch Kernel
	AddPackage virtualbox-guest-utils # VirtualBox Guest userspace utilities
	CreateLink /etc/systemd/system/multi-user.target.wants/vboxservice.service /usr/lib/systemd/system/vboxservice.service
else
	AddPackage lm_sensors # Opt dep for i3status-rust-git
	CreateLink /etc/systemd/system/multi-user.target.wants/lm_sensors.service /usr/lib/systemd/system/lm_sensors.service
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
