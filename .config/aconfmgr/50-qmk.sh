# https://github.com/qmk/qmk_firmware

if ! DetectVM; then # No keyboards in VMs
	AddPackageGroup base-devel
	AddPackage arm-none-eabi-binutils
	AddPackage arm-none-eabi-gcc
	AddPackage arm-none-eabi-newlib
	AddPackage avr-binutils
	AddPackage avr-gcc # Requires 8.3.0-1, nothing newer
	AddPackage avr-libc
	AddPackage avrdude
	AddPackage clang
	AddPackage dfu-programmer
	AddPackage dfu-util
	AddPackage diffutils
	AddPackage gcc
	AddPackage git
	AddPackage python-appdirs
	AddPackage python-argcomplete
	AddPackage python-colorama
	AddPackage --foreign python-dotty-dict
	AddPackage python-hjson
	AddPackage python-jsonschema
	AddPackage python-milc
	AddPackage python-pygments
	AddPackage unzip
	AddPackage wget
	AddPackage zip
	CopyFile /etc/udev/rules.d/50-atmel-dfu.rules
fi
