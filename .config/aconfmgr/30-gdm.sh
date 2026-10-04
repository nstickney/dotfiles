if ! DetectWSL; then # No GUI in WSL
	AddPackage gdm # Display manager and login screen
	CreateLink /etc/systemd/system/display-manager.service /usr/lib/systemd/system/gdm.service
fi
