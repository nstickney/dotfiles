# shellcheck disable=SC2148
AddPackage afpfs-ng # A client for the Apple Filing Protocol (AFP)
#AddPackage antergos-keyring # Antergos PGP keyring
AddPackage arch-audit # An utility like pkg-audit based on Arch CVE Monitoring Team data
AddPackage autoconf # A GNU tool for automatically configuring source code
AddPackage automake # A GNU tool for automatically creating Makefiles
AddPackage bash # The GNU Bourne Again shell
AddPackage bash-completion # Programmable completion for the bash shell
AddPackage binutils # A set of programs to assemble and manipulate binary and object files
AddPackage bison # The GNU general-purpose parser generator
AddPackage btrfs-progs # Btrfs filesystem utilities
AddPackage bzip2 # A high-quality data compression program
AddPackage colordiff # A Perl script wrapper for 'diff' that produces the same output but with pretty 'syntax' highlighting
AddPackage coreutils # The basic file, shell and text manipulation utilities of the GNU operating system
AddPackage cryptsetup # Userspace setup tool for transparent encryption of block devices using dm-crypt
AddPackage device-mapper # Device mapper userspace library and tools
AddPackage diffutils # Utility programs used for creating patch files
AddPackage dos2unix # Text file format converter
AddPackage dosfstools # DOS filesystem utilities
AddPackage e2fsprogs # Ext2/3/4 filesystem utilities
AddPackage exfat-utils # Utilities for exFAT file system
AddPackage fakeroot # Tool for simulating superuser privileges
AddPackage f2fs-tools #
AddPackage file # File type identification utility
AddPackage filesystem # Base filesystem
AddPackage findutils # GNU utilities to locate files
AddPackage flex # A tool for generating text-scanning programs
AddPackage gawk # GNU version of awk
AddPackage gcc-libs # Runtime libraries shipped by GCC
AddPackage gcc # The GNU Compiler Collection - C and C++ frontends
AddPackage gettext # GNU internationalization library
AddPackage glibc # GNU C Library
AddPackage gpart # Partition table rescue/guessing tool
AddPackage grep # A string search utility
AddPackage groff # GNU troff text-formatting system
AddPackage gzip # GNU compression utility
AddPackage htop # Interactive process viewer
AddPackage jfsutils # JFS filesystem utilities
AddPackage less # A terminal based program for viewing text files
AddPackage lesspipe # an input filter for the pager less
AddPackage libtool # A generic library support script
AddPackage licenses # The standard licenses distribution package
AddPackage linux # The Linux kernel and modules
AddPackage logrotate # Rotates system logs automatically
AddPackage lsof # Lists open files for running Unix processes
AddPackage lvm2 # Logical Volume Manager 2 utilities
AddPackage m4 # The GNU macro processor
AddPackage make # GNU make utility to maintain groups of programs
AddPackage man-db # A utility for reading man pages
AddPackage man-pages # Linux man pages
AddPackage mdadm # A tool for managing/monitoring Linux md device arrays, also known as Software RAID
AddPackage mlocate # Merging locate/updatedb implementation
AddPackage mtools # A collection of utilities to access MS-DOS disks	A collection of utilities to access MS-DOS disks
AddPackage net-tools # Configuration tools for Linux networking
AddPackage neofetch # A CLI system information tool written in BASH that supports displaying images.
AddPackage nilfs-utils # A log-structured file system supporting continuous snapshotting (userspace utils)
AddPackage ntfs-3g # NTFS filesystem driver and utilities
AddPackage openntpd # Free, easy to use implementation of the Network Time Protocol
AddPackage pacman # A library-based package manager with dependency support
AddPackage patch # A utility to apply patch files to original sources
AddPackage pciutils # PCI bus configuration space access library and tools
AddPackage perl # A highly capable, feature-rich programming language
AddPackage pkgconf # Package compiler and linker metadata toolkit
AddPackage pkgfile # a pacman .files metadata explorer
AddPackage powerpill # Pacman wrapper for faster downloads.
AddPackage procps-ng # Utilities for monitoring your system and its processes
AddPackage psmisc # Miscellaneous procfs tools
AddPackage reflector # A Python 3 module and script to retrieve and filter the latest Pacman mirror list.
AddPackage reiserfsprogs # Reiserfs utilities
AddPackage screen # Full-screen window manager that multiplexes a physical terminal
AddPackage sed # GNU stream editor
AddPackage shadow # Password and account management tool suite with support for shadow files and PAM
AddPackage source-highlight # Convert source code to syntax highlighted document
AddPackage sudo # Give certain users the ability to run some commands as root
AddPackage sysfsutils # System Utilities Based on Sysfs
AddPackage systemd-sysvcompat # sysvinit compat for systemd
AddPackage s-nail # Mail processing system with a command syntax reminiscent of ed
AddPackage tar # Utility used to store, backup, and transport files
AddPackage texinfo # GNU documentation system for on-line information and printed output
AddPackage usbutils # USB Device Utilities
AddPackage util-linux # Miscellaneous system utilities for Linux
AddPackage which # A utility to show the full path of commands
AddPackage xfsprogs # XFS filesystem utilities

AddPackage --foreign aconfmgr-git # A configuration manager for Arch Linux
AddPackage augeas # aconfmgr opt dep
AddPackage --foreign aurman # AUR helper with almost pacman syntax
AddPackage --foreign aurvote # Vote for your favorite AUR packages
AddPackage --foreign find-the-command # Interactive command-not-found hook for bash and zsh using the power of pacman

CopyFile /etc/bash.bashrc
CopyFile /etc/makepkg.conf
CopyFile /etc/motd
CopyFile /etc/ntpd.conf
CopyFile /etc/pacman.conf
CopyFile /etc/pacman.d/hooks/mirrorupgrade.hook
CopyFile /etc/profile.d/powerpill.sh

CreateLink /etc/systemd/system/multi-user.target.wants/openntpd.service /usr/lib/systemd/system/openntpd.service
CreateLink /etc/systemd/user/sockets.target.wants/dirmngr.socket /usr/lib/systemd/user/dirmngr.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-browser.socket /usr/lib/systemd/user/gpg-agent-browser.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-extra.socket /usr/lib/systemd/user/gpg-agent-extra.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent-ssh.socket /usr/lib/systemd/user/gpg-agent-ssh.socket
CreateLink /etc/systemd/user/sockets.target.wants/gpg-agent.socket /usr/lib/systemd/user/gpg-agent.socket
