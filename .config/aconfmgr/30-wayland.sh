if ! DetectWSL; then # No GUI in WSL

	# AMD graphics support
	if DetectAMDGPU; then
		AddPackage amdgpu_top            # Tool that shows AMD GPU utilization
		AddPackage linux-firmware-amdgpu # Firmware files for Linux - Firmware for AMD Radeon GPUs
		AddPackage mesa-vdpau            # Mesa VDPAU drivers
		AddPackage vulkan-radeon         # Radeon's Vulkan mesa driver
		AddPackage lib32-vulkan-radeon   # Radeon's Vulkan mesa driver
		AddPackage vulkan-tools          # Vulkan Utilities and Tools
		# AddPackage amdvlk                # AMD's standalone Vulkan driver
		# AddPackage lib32-amdvlk          # AMD's standalone Vulkan driver
		# AddPackage opencl-mesa           # OpenCL support for AMD/ATI Radeon mesa drivers
	fi

	# Intel graphics support
	if DetectIntelGPU; then
		AddPackage linux-firmware-intel #  	Firmware files for Linux - Firmware for Intel devices
		AddPackage vulcan-intel         # Intel's Vulkan mesa driver
		AddPackage vulkan-tools         # Vulkan Utilities and Tools
	fi

	# Nvidia graphics support
	if DetectNvidia; then
		AddPackage linxu-firmware-nvidia # Firmware files for Linux - Firmware for NVIDIA GPUs and SoCs
		AddPackage egl-wayland
		AddPackage lib32-nvidia-utils
		AddPackage nvidia
		AddPackage nvidia-lts
		AddPackage nvidia-utils
		CopyFile /etc/modprobe.d/nvidia-wayland-gnome.conf
		CreateLink /etc/systemd/system/systemd-hibernate.service.wants/nvidia-hibernate.service /usr/lib/systemd/system/nvidia-hibernate.service
		CreateLink /etc/systemd/system/systemd-hibernate.service.wants/nvidia-resume.service /usr/lib/systemd/system/nvidia-resume.service
		CreateLink /etc/systemd/system/systemd-suspend.service.wants/nvidia-resume.service /usr/lib/systemd/system/nvidia-resume.service
		CreateLink /etc/systemd/system/systemd-suspend.service.wants/nvidia-suspend.service /usr/lib/systemd/system/nvidia-suspend.service
	fi

	AddPackage gdm                     # Display manager and login screen
	AddPackage grim                    # Screenshot utility that works under Wayland
	AddPackage qt5-wayland             # Provides APIs for Wayland
	AddPackage qt6-wayland             # Provides APIs for Wayland
	AddPackage slurp                   # Select a region in a Wayland compositor
	AddPackage waypipe                 # A proxy for Wayland protocol applications; like ssh -X
	AddPackage --foreign wev-git       # Print wayland events, like xev(1)
	AddPackage --foreign wlsunset-git  # Day/night gamma adjustments for Wayland
	AddPackage --foreign wshowkeys-git # Displays keys being pressed on a Wayland session
	AddPackage xdg-utils               # Command line tools that assist applications with a variety of desktop integration tasks
	AddPackage xorg-xauth              # X.Org authorization settings program (required for X11 forwarding in ssh)
	AddPackage xorg-xeyes              # Follow the mouse/SHAPE extension X demo

	CopyFile /etc/profile.d/wayland-env.sh
	CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service
fi
