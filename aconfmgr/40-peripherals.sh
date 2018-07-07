# shellcheck disable=SC2148
if [[ "$HOSTNAME" == "elisha" ]]
then
    AddPackage android-tools # Android platform tools
    AddPackage arduino-avr-core # Arduino AVR core with upstream avr-gcc and avrdude

    AddPackage --foreign android-sdk-platform-tools # Platform-Tools for Google Android SDK (adb and fastboot)
    AddPackage --foreign heimdall-git # A cross-platform open-source utility to flash firmware (aka ROMs) onto Samsung Galaxy S devices.
    AddPackage --foreign teensy-loader-cli # Command line loader for the teensy microprocessor boards
fi

if [[ "$HOSTNAME" == "elisha" || \
      "$HOSTNAME" == "elizabeth" ]]
then
    AddPackage blueman # GTK+ Bluetooth Manager
    AddPackage bluez-firmware # Firmwares for Broadcom BCM203x and STLC2300 Bluetooth chips
    AddPackage bluez-utils # Development and debugging utilities for the bluetooth protocol stack
    AddPackage ccid # A generic USB Chip/Smart Card Interface Devices driver
    AddPackage opensc # Tools and libraries for smart cards
    AddPackage pcsc-tools # PC/SC Architecture smartcard tools
    AddPackage pulseaudio-bluetooth # Bluetooth support for PulseAudio

    #CreateLink /etc/systemd/system/bluetooth.target.wants/bluetooth.service /usr/lib/systemd/system/bluetooth.service
    #CreateLink /etc/systemd/system/dbus-org.bluez.service /usr/lib/systemd/system/bluetooth.service
fi

if [[ "$HOSTNAME" == "elisha" || \
      "$HOSTNAME" == "elizabeth" || \
      "$HOSTNAME" == "elijah" || \
      "$HOSTNAME" == "eli" || \
      "$HOSTNAME" == "elisheba" || \
      "$HOSTNAME" == "elim" ]]
then
    AddPackage --foreign regionset # read/sets the region code of DVD drives
    AddPackage --foreign solaar # Device manager for Logitech's Unifying receiver peripherals
fi

AddPackage android-udev # Udev rules to connect Android devices to your linux box
AddPackage cups # The CUPS Printing System - daemon package
AddPackage cups-pdf # PDF printer for cups
AddPackage mtpfs # A FUSE filesystem that supports reading and writing from any MTP device
AddPackage --foreign brother-mfc-j480dw # LPR and CUPS driver for the Brother MFC-j480DW

# shellcheck disable=SC2148
#if [[ "$HOSTNAME" == "elisha" || \
#	"$HOSTNAME" == "elizabeth" || \
#	"$HOSTNAME" == "elijah" ]]
#then
#fi

CopyFile /etc/nsswitch.conf

CreateLink /etc/systemd/system/multi-user.target.wants/cups.path /usr/lib/systemd/system/cups.path
CreateLink /etc/systemd/system/multi-user.target.wants/org.cups.cupsd.path /usr/lib/systemd/system/org.cups.cupsd.path
CreateLink /etc/systemd/system/printer.target.wants/org.cups.cupsd.service /usr/lib/systemd/system/org.cups.cupsd.service
CreateLink /etc/systemd/system/sockets.target.wants/cups.socket /usr/lib/systemd/system/cups.socket
CreateLink /etc/systemd/system/sockets.target.wants/org.cups.cupsd.socket /usr/lib/systemd/system/org.cups.cupsd.socket
CreateLink /etc/systemd/system/sockets.target.wants/pcscd.socket /usr/lib/systemd/system/pcscd.socket
