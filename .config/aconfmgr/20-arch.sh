AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage augeas                 # aconfmgr opt dep
AddPackage arch-audit             # An utility like pkg-audit based on Arch CVE Monitoring Team data
AddPackage arch-install-scripts   # Scripts to aid in installing Arch Linux
AddPackage --foreign aurvote      # Vote for your favorite AUR packages
AddPackage autoconf               # A GNU tool for automatically configuring source code
AddPackage automake               # A GNU tool for automatically creating Makefiles
AddPackage bash-completion        # Programmable completion for the bash shell
AddPackage bat                    # Cat clone with syntax highlighting and git integration
AddPackage binutils               # A set of programs to assemble and manipulate binary and object files
AddPackage bison                  # The GNU general-purpose parser generator
AddPackage colordiff              # A Perl script wrapper for 'diff' that produces the same output but with pretty 'syntax' highlighting
AddPackage cryptsetup             # Userspace setup tool for transparent encryption of block devices using dm-crypt
AddPackage device-mapper          # Device mapper userspace library and tools
AddPackage diffutils              # Utility programs used for creating patch files
AddPackage dos2unix               # Text file format converter
AddPackage exa                    # ls replacement
AddPackage fakeroot               # Tool for simulating superuser privileges
AddPackage flex                   # A tool for generating text-scanning programs
AddPackage gcc-libs               # Runtime libraries shipped by GCC
AddPackage gcc                    # The GNU Compiler Collection - C and C++ frontends
AddPackage gettext                # GNU internationalization library
AddPackage groff                  # GNU troff text-formatting system
AddPackage htop                   # Interactive process viewer
AddPackage less                   # A terminal based program for viewing text files
AddPackage lesspipe               # an input filter for the pager less
AddPackage rpmextract             # lesspipe opt dep
AddPackage libtool                # A generic library support script
AddPackage logrotate              # Rotates system logs automatically
AddPackage lsof                   # Lists open files for running Unix processes
AddPackage m4                     # The GNU macro processor
AddPackage make                   # GNU make utility to maintain groups of programs
AddPackage man-db                 # A utility for reading man pages
AddPackage man-pages              # Linux man pages
AddPackage mdadm                  # A tool for managing/monitoring Linux md device arrays, also known as Software RAID
AddPackage mlocate                # Merging locate/updatedb implementation
AddPackage mtools                 # A collection of utilities to access MS-DOS disks	A collection of utilities to access MS-DOS disks
AddPackage net-tools              # Configuration tools for Linux networking
AddPackage neofetch               # A CLI system information tool written in BASH that supports displaying images.
AddPackage --foreign paru         # AUR helper based on yay
AddPackage patch                  # A utility to apply patch files to original sources
AddPackage pciutils               # PCI bus configuration space access library and tools
AddPackage perl                   # A highly capable, feature-rich programming language
AddPackage pkgconf                # Package compiler and linker metadata toolkit
AddPackage pkgfile                # a pacman .files metadata explorer
AddPackage --foreign powerpill    # Pacman wrapper for faster downloads.
AddPackage reflector              # A Python 3 module and script to retrieve and filter the latest Pacman mirror list.
AddPackage source-highlight       # Convert source code to syntax highlighted document
AddPackage sudo                   # Give certain users the ability to run some commands as root
AddPackage texinfo                # GNU documentation system for on-line information and printed output
AddPackage usbutils               # USB Device Utilities
AddPackage which                  # A utility to show the full path of commands

CopyFile /etc/makepkg.conf
CopyFile /etc/pacman.conf
CopyFile /etc/pacman.d/hooks/arch-audit.hook
CopyFile /etc/pacman.d/hooks/mirrorupgrade.hook
CopyFile /etc/profile.d/powerpill.sh

CreateLink /etc/systemd/user/sockets.target.wants/dirmngr.socket /usr/lib/systemd/user/dirmngr.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-browser.socket /usr/lib/systemd/user/gpg-agent-browser.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-extra.socket /usr/lib/systemd/user/gpg-agent-extra.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-ssh.socket /usr/lib/systemd/user/gpg-agent-ssh.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent.socket /usr/lib/systemd/user/gpg-agent.socket
