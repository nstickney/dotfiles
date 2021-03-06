if ! DetectWSL; then # No GUI in WSL

	# AMD graphics support
	if DetectAMDGPU; then
		AddPackage libva-mesa-driver # VA-API implementation for gallium
		AddPackage mesa-vdpau        # Mesa VDPAU drivers
		AddPackage opencl-mesa       # OpenCL support for AMD/ATI Radeon mesa drivers
		AddPackage vulkan-radeon     # Radeon's Vulkan mesa driver
	fi

	# Intel graphics support
	if DetectIntelGPU; then
		AddPackage vulcan-intel # Intel's Vulkan mesa driver
	fi

	AddPackage gdm                    # Display manager and login screen
	AddPackage glfw-wayland           # A free, open source, portable framework for graphical application development (wayland)
	AddPackage grim                   # Screenshot utility that works under Wayland
	AddPackage qt5-wayland            # Provides APIs for Wayland
	AddPackage slurp                  # Select a region in a Wayland compositor
	AddPackage --foreign wev-git      # Print wayland events, like xev(1)
	AddPackage --foreign wlsunset-git # Day/night gamma adjustments for Wayland
	AddPackage xdg-utils              # Command line tools that assist applications with a variety of desktop integration tasks

	CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service
fi
