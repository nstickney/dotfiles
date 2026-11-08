if ! DetectWSL; then # No GUI in WSL

	# AMD graphics support
	if DetectAMDGPU; then
		AddPackage amdgpu_top            # Tool that shows AMD GPU utilization
		AddPackage vulkan-radeon         # Radeon's Vulkan mesa driver
		AddPackage lib32-vulkan-radeon   # Radeon's Vulkan mesa driver
		AddPackage vulkan-tools          # Vulkan Utilities and Tools
		# AddPackage amdvlk                # AMD's standalone Vulkan driver
		# AddPackage lib32-amdvlk          # AMD's standalone Vulkan driver
		# AddPackage opencl-mesa           # OpenCL support for AMD/ATI Radeon mesa drivers
	fi

	# Intel graphics support
	if DetectIntelGPU; then
		AddPackage intel-media-driver   # Intel Media Driver for VAAPI — Broadwell+ iGPUs
		AddPackage vulkan-intel         # Open-source Vulkan driver for Intel GPUs
		AddPackage lib32-vulkan-intel   # Open-source Vulkan driver for Intel GPUs - 32-bit
	fi

	# Nvidia graphics support (PRIME render offload via prime-run)
	if DetectNvidiaGPU; then
		AddPackage nvidia-open           # NVIDIA open kernel modules
		AddPackage nvidia-open-lts       # NVIDIA open kernel modules (LTS)
		AddPackage nvidia-utils          # NVIDIA drivers utilities
		AddPackage lib32-nvidia-utils    # NVIDIA drivers utilities (32-bit)
		AddPackage nvidia-prime          # NVIDIA Prime Render Offload configuration and utilities

		# Required for Wayland on the dGPU; fbdev=1 keeps fbdev consumers happy
		cat >"$(CreateFile /etc/modprobe.d/nvidia.conf)" <<-EOF
			options nvidia_drm modeset=1 fbdev=1
		EOF

		# Dynamic Boost: negotiates the dGPU power budget with the firmware.
		# Without it the Precision 5470s' firmware cycles the A1000 between
		# 35/20/15 W every ~4 s, dropping to idle clocks mid-game.
		CreateLink /etc/systemd/system/multi-user.target.wants/nvidia-powerd.service /usr/lib/systemd/system/nvidia-powerd.service
	fi

	AddPackage brightnessctl           # Lightweight brightness control tool
	AddPackage grim                    # Screenshot utility that works under Wayland
	AddPackage qt5-wayland             # Provides APIs for Wayland
	AddPackage qt6-wayland             # Provides APIs for Wayland
	AddPackage slurp                   # Select a region in a Wayland compositor
	AddPackage waypipe                 # A proxy for Wayland protocol applications; like ssh -X
	AddPackage wdisplays               # Graphical application for configuring Wayland displays
	AddPackage wev                     # A tool for debugging wayland events on a Wayland window, analagous to the X11 tool xev
	AddPackage wlsunset                # Day/night gamma adjustments for Wayland compositors
	AddPackage --foreign wshowkeys-git # Displays keys being pressed on a Wayland session
	AddPackage --foreign wluma         # Automatic brightness adjustment based on screen contents and ALS
	AddPackage xdg-utils               # Command line tools that assist applications with a variety of desktop integration tasks
	AddPackage xorg-xauth              # X.Org authorization settings program (required for X11 forwarding in ssh)
	AddPackage xorg-xeyes              # Follow the mouse/SHAPE extension X demo

	CopyFile /etc/profile.d/wayland-env.sh
	CreateLink /etc/systemd/user/default.target.wants/xdg-user-dirs-update.service /usr/lib/systemd/user/xdg-user-dirs-update.service
fi
