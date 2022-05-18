if ! DetectWSL; then # No GUI in WSL

	# AMD graphics support
	if DetectAMDGPU; then
		AddPackage amdvlk            # AMD's standalone Vulkan driver
		AddPackage lib32-amdvlk      # AMD's standalone Vulkan driver
		AddPackage libva-mesa-driver # VA-API implementation for gallium
		AddPackage mesa-vdpau        # Mesa VDPAU drivers
		AddPackage opencl-mesa       # OpenCL support for AMD/ATI Radeon mesa drivers
		AddPackage vulkan-radeon     # Radeon's Vulkan mesa driver
	fi

	# Intel graphics support
	if DetectIntelGPU; then
		AddPackage vulcan-intel # Intel's Vulkan mesa driver
	fi

	# Nvidia graphics support
	if DetectNvidia; then
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
	AddPackage glfw-wayland            # A free, open source, portable framework for graphical application development (wayland)
	AddPackage grim                    # Screenshot utility that works under Wayland
	AddPackage qt5-wayland             # Provides APIs for Wayland
	AddPackage slurp                   # Select a region in a Wayland compositor
	AddPackage --foreign wev-git       # Print wayland events, like xev(1)
	AddPackage --foreign wlsunset-git  # Day/night gamma adjustments for Wayland
	AddPackage --foreign wshowkeys-git # Displays keys being pressed on a Wayland session
	AddPackage xdg-utils               # Command line tools that assist applications with a variety of desktop integration tasks
	AddPackage xorg-xauth              # X.Org authorization settings program (required for X11 forwarding in ssh)
	AddPackage xorg-xeyes              # Follow the mouse/SHAPE extension X demo

	CopyFile /etc/profile.d/wayland-env.sh
	CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service
fi
