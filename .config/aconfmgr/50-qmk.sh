# https://github.com/qmk/qmk_firmware

if ! DetectVM; then # No keyboards in VMs
	AddPackage qmk
	AddPackage clang         # qmk opt dep
	AddPackage diffutils     # qmk opt dep
	AddPackage gcc           # qmk opt dep
	AddPackage libffi        # qmk opt dep
	AddPackage libusb-compat # qmk opt dep
	AddPackage wget          # qmk opt dep
	AddPackage zip           # qmk opt dep
	CopyFile /etc/udev/rules.d/50-qmk.rules
fi
