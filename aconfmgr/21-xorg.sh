# shellcheck disable=SC2148
if [[ "$HOSTNAME" == "elisha" ]]
then
    AddPackage mesa-demos # Mesa demos and tools
fi

AddPackage xf86-input-mouse # X.org mouse input driver
AddPackage xorg-server # Xorg X server
AddPackage xorg-xdpyinfo # Display information utility for X
AddPackage xorg-xev # Print contents of X events
AddPackage xorg-xfontsel # Point and click selection of X11 font names
AddPackage xorg-xinit # X.Org initialisation program
AddPackage xorg-xkill # Kill a client by its X resource
