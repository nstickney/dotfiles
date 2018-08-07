# shellcheck disable=SC2148
if [[ "$HOSTNAME" == "elisha" || \
    "$HOSTNAME" == "elias" ]]
then
    ### qemu
    # AddPackage qemu # A generic and open source machine emulator and virtualizer

    ### VirtualBox
    # AddPackage packer-io # tool for creating identical machine images for multiple platforms from a single source configuration
    # AddPackage vagrant # Build and distribute virtualized development environments
    AddPackage virtualbox # Powerful x86 virtualization for enterprise as well as home use
    AddPackage virtualbox-ext-vnc # VirtualBox VNC extension pack
    AddPackage --foreign virtualbox-ext-oracle # Oracle VM VirtualBox Extension Pack
    AddPackage virtualbox-guest-iso # The official VirtualBox Guest Additions ISO image
fi
