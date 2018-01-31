# shellcheck disable=SC2148
if [[ "$HOSTNAME" == "elisha" || \
      "$HOSTNAME" == "eli" || \
      "$HOSTNAME" == "elim" ]]
then
    ### qemu
    AddPackage qemu # A generic and open source machine emulator and virtualizer

    ### VirtualBox
    AddPackage packer-io # tool for creating identical machine images for multiple platforms from a single source configuration
    AddPackage vagrant # Build and distribute virtualized development environments
    AddPackage virtualbox # Powerful x86 virtualization for enterprise as well as home use
    AddPackage virtualbox-ext-vnc # VirtualBox VNC extension pack
    AddPackage --foreign virtualbox-ext-oracle # Oracle VM VirtualBox Extension Pack
    AddPackage virtualbox-guest-iso # The official VirtualBox Guest Additions ISO image
fi

AddPackage ctags # atom opt dep
AddPackage shellcheck # atom opt dep
AddPackage trash-cli # atom opt dep
AddPackage git # the fast distributed version control system
AddPackage git-crypt # Transparent file encryption in Git
AddPackage gramps #
AddPackage gtkspell3 # opt dep for gramps
AddPackage libgexiv2 # opt dep for gramps
AddPackage osm-gps-map # opt dep for gramps
AddPackage python-pyicu # opt dep for gramps
AddPackage rcs # opt dep for gramps
AddPackage keepassxc # Cross-platform community-driven port of Keepass password manager
AddPackage redshift # Adjusts the color temperature of your screen according to your surroundings
AddPackage texlive-bin # opt dep for evince/vim/python
AddPackage truecrypt # Free open-source cross-platform disk encryption software
AddPackage --foreign vim-gnome # Vi Improved, a highly configurable, improved version of the vi text editor (with Gnome GUI)
AddPackage zsh # A very advanced and programmable command interpreter (shell) for UNIX

AddPackage --foreign fslint # A utility to find and clean various forms of lint on a filesystem
AddPackage --foreign lbry-app-bin # The LBRY app built using electron
# AddPackage --foreign zotero # Zotero Standalone, a free, easy-to-use tool to help you collect, organize, cite, and share your research sources
# AddPackage xpdf # opt dep for Zotero
