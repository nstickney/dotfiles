# shellcheck disable=SC2148

if [[ "$HOSTNAME" == "elisha" || \
      "$HOSTNAME" == "elizabeth" ]]
then
    CopyFile /etc/modprobe.d/blacklist.conf
fi

if [[ "$HOSTNAME" == "eli" || \
      "$HOSTNAME" == "elisheba" ]]
then
    AddPackage bbswitch # Kernel module allowing to switch dedicated graphics card on Optimus laptops
    AddPackage bumblebee # NVIDIA Optimus support for Linux through VirtualGL
    AddPackage primus # Faster OpenGL offloading for Bumblebee
    AddPackage xf86-input-synaptics # Synaptics driver for notebook touchpads
    CreateLink /etc/systemd/system/graphical.target.wants/bumblebeed.service /usr/lib/systemd/system/bumblebeed.service
fi

if [[ "$HOSTNAME" == "eli" || \
      "$HOSTNAME" == "elisheba" ]]
then
    AddPackage intel-ucode # Microcode update files for Intel CPUs
    AddPackage xf86-video-intel # X.org Intel i810/i830/i915/945G/G965+ video drivers
fi


if [[ "$HOSTNAME" == "elisha" || \
      "$HOSTNAME" == "elizabeth" || \
      "$HOSTNAME" == "eli" || \
      "$HOSTNAME" == "elisheba" ]]
then
    AddPackage nvidia # NVIDIA drivers for linux
fi

if [[ "$HOSTNAME" == "elijah" ]]
then
    AddPackage grub # GNU GRand Unified Bootloader (2)
    AddPackage nvidia-340xx # NVIDIA drivers for linux, 340xx legacy branch
fi

if [[ "$HOSTNAME" == "eliab" ]]
then
    AddPackage virtualbox-guest-modules-arch # Virtualbox guest kernel modules for Arch Kernel
    AddPackage virtualbox-guest-utils # VirtualBox Guest userspace utilities
    CopyFile /etc/gdm/custom.conf
    CreateLink /etc/systemd/system/multi-user.target.wants/vboxservice.service /usr/lib/systemd/system/vboxservice.service
fi

if [[ "$HOSTNAME" == "elisha" || \
      "$HOSTNAME" == "elizabeth" || \
      "$HOSTNAME" == "elijah" || \
      "$HOSTNAME" == "eli" || \
      "$HOSTNAME" == "elisheba" ]]
then
    AddPackage lm_sensors # Opt dep for i3status-rust-git
    CreateLink /etc/systemd/system/multi-user.target.wants/lm_sensors.service /usr/lib/systemd/system/lm_sensors.service
fi

if [[ "$HOSTNAME" == "elisha" || \
      "$HOSTNAME" == "elizabeth" || \
      "$HOSTNAME" == "eli" || \
      "$HOSTNAME" == "elisheba" || \
      "$HOSTNAME" == "eliab" ]]
then
    AddPackage efibootmgr
fi

CopyFile /etc/locale.conf

CreateLink /etc/localtime /usr/share/zoneinfo/US/Eastern
CreateLink /etc/systemd/system/dbus-org.freedesktop.NetworkManager.service /usr/lib/systemd/system/NetworkManager.service
CreateLink /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service /usr/lib/systemd/system/NetworkManager-dispatcher.service
CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/gdm.service
CreateLink /etc/systemd/system/getty.target.wants/getty@tty1.service /usr/lib/systemd/system/getty@.service
CreateLink /etc/systemd/system/multi-user.target.wants/remote-fs.target /usr/lib/systemd/system/remote-fs.target
CreateLink /etc/systemd/system/sysinit.target.wants/systemd-timesyncd.service /usr/lib/systemd/system/systemd-timesyncd.service
CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service
