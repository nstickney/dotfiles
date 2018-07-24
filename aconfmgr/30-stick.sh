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

AddPackage git # the fast distributed version control system
AddPackage git-crypt # Transparent file encryption in Git
AddPackage gramps #
AddPackage gtkspell3 # opt dep for gramps
AddPackage libgexiv2 # opt dep for gramps
AddPackage osm-gps-map # opt dep for gramps
AddPackage python-pyicu # opt dep for gramps
AddPackage rcs # opt dep for gramps
AddPackage keepassxc # Cross-platform community-driven port of Keepass password manage
AddPackage ripgrep # A search tool that combines the usability of ag with the raw speed of grep
AddPackage rkhunter # Checks machines for the presence of rootkits and other unwanted tools
AddPackage rmlint # Tool to remove duplicates and other lint, being much faster than fdupes
AddPackage rmlint-shredder # Graphical user interface for rmlint
AddPackage shellcheck # Shell script analysis tool
AddPackage texlive-bin # opt dep for evince/vim/python
AddPackage thunderbird # Standalone mail and news reader from mozilla.org
AddPackage truecrypt # Free open-source cross-platform disk encryption software
# AddPackage zsh # A very advanced and programmable command interpreter (shell) for UNIX

AddPackage --foreign fslint # A utility to find and clean various forms of lint on a filesystem
AddPackage --foreign lbry-app-bin # The LBRY app built using electron
AddPackage --foreign protonmail-bridge # Application to use IMAP/SMTP with your paid ProtonMail account
AddPackage --foreign python-proselint # A linter for prose
# AddPackage --foreign python-vint # VimL Linter
AddPackage --foreign redpen # A document checker. RedPen is a proofreading tool to help writers or programmers.
AddPackage --foreign vim-gnome # Vi Improved, a highly configurable, improved version of the vi text editor (with Gnome GUI)
AddPackage vim-spell-en # Language files for Vim spell checking
AddPackage --foreign zotero # Zotero Standalone, a free, easy-to-use tool to help you collect, organize, cite, and share your research sources
# AddPackage xpdf # opt dep for Zotero
