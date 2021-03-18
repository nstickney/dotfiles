if ! DetectVM; then        # No audio needed in VMs
	AddPackage pipewire       # Low-latency audio/video router and processor
	AddPackage pipewire-pulse # Low-latency audio/video router and processor - PulseAudio replacement

	CreateLink /etc/systemd/user/pipewire.service.wants/pipewire-media-session.service /usr/lib/systemd/user/pipewire-media-session.service
	CreateLink /etc/systemd/user/sockets.target.wants/pipewire.socket /usr/lib/systemd/user/pipewire.socket
	CreateLink /etc/systemd/user/sockets.target.wants/pipewire-pulse.socket /usr/lib/systemd/user/pipewire-pulse.socket
fi
