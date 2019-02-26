# shellcheck disable=SC2148

AddPackage chrony # Lightweight NTP client and server

# Virtual Machine (any type)
if sudo dmesg | grep -q "Hypervisor detected"; then
	CopyFile /etc/gdm/custom.conf
fi

# VirtualBox
if systemd-detect-virt | grep -q oracle; then
	AddPackage virtualbox-guest-modules-arch # Virtualbox guest kernel modules for Arch Kernel
	AddPackage virtualbox-guest-utils # VirtualBox Guest userspace utilities
	CreateLink /etc/systemd/system/multi-user.target.wants/vboxservice.service /usr/lib/systemd/system/vboxservice.service
else
	AddPackage lm_sensors # Opt dep for i3status-rust-git
	CreateLink /etc/systemd/system/multi-user.target.wants/lm_sensors.service /usr/lib/systemd/system/lm_sensors.service
fi

# AMD CPU
if grep -q AMD /proc/cpuinfo 2>/dev/null; then
	AddPackage amd-ucode # Microcode update files for AMD CPUs
fi

# Intel CPU/Video
if grep -q Intel /proc/cpuinfo 2>/dev/null; then
	AddPackage intel-ucode # Microcode update files for Intel CPUs
	AddPackage xf86-video-intel # X.org Intel i810/i830/i915/945G/G965+ video drivers
fi

if [[ "$HOSTNAME" == "elisha" || \
	  "$HOSTNAME" == "elizabeth" ]]
then
	CopyFile /etc/modprobe.d/blacklist.conf
fi

# Nvidia
if [[ "$HOSTNAME" == "elisha" || \
	"$HOSTNAME" == "elizabeth" || \
	"$HOSTNAME" == "eli" || \
	"$HOSTNAME" == "elisheba" ]]
then
	AddPackage nvidia # NVIDIA drivers for linux
fi

# Nvidia with bumblebee/primus (Optimus)
if [[ "$HOSTNAME" == "eli" || \
	  "$HOSTNAME" == "elisheba" ]]
then
	AddPackage bbswitch # Kernel module allowing to switch dedicated graphics card on Optimus laptops
	AddPackage bumblebee # NVIDIA Optimus support for Linux through VirtualGL
	AddPackage primus # Faster OpenGL offloading for Bumblebee
	AddPackage xf86-input-synaptics # Synaptics driver for notebook touchpads
	CreateLink /etc/systemd/system/graphical.target.wants/bumblebeed.service /usr/lib/systemd/system/bumblebeed.service
fi

# Nvidia old
if [[ "$HOSTNAME" == "elijah" ]]
then
	AddPackage nvidia-340xx # NVIDIA drivers for linux, 340xx legacy branch
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

# Specify locales
f="$(GetPackageOriginalFile glibc /etc/locale.gen)"
sed -i 's/^#\(en_US.UTF-8\)/\1/g' "$f"

CopyFile /etc/chrony.conf
CopyFile /etc/locale.conf
CreateLink /etc/localtime /usr/share/zoneinfo/US/Eastern
CreateLink /etc/systemd/system/dbus-org.freedesktop.NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service /usr/lib/systemd/system/NetworkManager-dispatcher.service
CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/gdm.service
CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
CreateLink /etc/systemd/system/multi-user.target.wants/chronyd.service /usr/lib/systemd/system/chronyd.service
CreateLink /etc/systemd/system/multi-user.target.wants/remote-fs.target /usr/lib/systemd/system/remote-fs.target
CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service
