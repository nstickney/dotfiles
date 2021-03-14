# WSL
if grep -q microsoft /proc/version; then
	IgnorePath '/ArchWSL.tar.gz'
	IgnorePath '/etc/hosts'
	IgnorePath '/etc/timezone'
	IgnorePath '/init'
	IgnorePath '/README'
	IgnorePath '/usr/bin/mount.drvfs'
	IgnorePath '/usr/bin/wslpath'
fi

IgnorePath '**.bak'
IgnorePath '**.pacnew'
IgnorePath '**/__pycache__/*'
IgnorePath '/boot/*'
IgnorePath '/etc/.*'
IgnorePath '/etc/adjtime'
IgnorePath '/etc/arch-release'
IgnorePath '/etc/brlapi.key'
IgnorePath '/etc/ca-certificates/*'
IgnorePath '/etc/conf.d/lm_sensors'
IgnorePath '/etc/crypttab'
IgnorePath '/etc/cups/*'
IgnorePath '/etc/dhcpcd*'
IgnorePath '/etc/docker/key.json'
IgnorePath '/etc/fstab'
IgnorePath '/etc/gconf/*'
IgnorePath '/etc/group'
IgnorePath '/etc/group-'
IgnorePath '/etc/gshadow'
IgnorePath '/etc/gshadow-'
IgnorePath '/etc/hostname'
IgnorePath '/etc/iptables/*'
IgnorePath '/etc/ld.so.cache'
IgnorePath '/etc/libvirt/nwfilter/*'
IgnorePath '/etc/libvirt/qemu/*.xml'
IgnorePath '/etc/libvirt/qemu/networks/default.xml'
IgnorePath '/etc/libvirt/secrets'
IgnorePath '/etc/libvirt/storage/*.xml'
IgnorePath '/etc/machine-id'
IgnorePath '/etc/mkinitcpio*'
IgnorePath '/etc/modules-load.d/*'
IgnorePath '/etc/NetworkManager/*'
IgnorePath '/etc/os-release'
IgnorePath '/etc/pacman.d/gnupg/*'
IgnorePath '/etc/passwd'
IgnorePath '/etc/passwd-'
IgnorePath '/etc/pacman.d/mirrorlist*'
IgnorePath '/etc/printcap'
IgnorePath '/etc/resolv.conf'
IgnorePath '/etc/shadow'
IgnorePath '/etc/shadow-'
IgnorePath '/etc/shells'
IgnorePath '/etc/ssh/moduli'
IgnorePath '/etc/ssh/ssh_host*'
IgnorePath '/etc/ssl/*'
IgnorePath '/etc/systemd/system/multi-user.target.wants/wg-quick*'
IgnorePath '/etc/sudoers'
IgnorePath '/etc/texmf/*'
IgnorePath '/etc/xml/*'
IgnorePath '/etc/wireguard/*'
IgnorePath '/lost+found'
IgnorePath '/opt/containerd/*'
IgnorePath '/opt/tome4/*'
IgnorePath '/usr/lib/**/*.cache'
IgnorePath '/usr/lib/ghc-*/package.conf.d/*.conf'
IgnorePath '/usr/lib/graphviz/config6'
IgnorePath '/usr/lib/jvm/default*'
IgnorePath '/usr/lib/libamd_comgr.so.*'
IgnorePath '/usr/lib/locale/locale-archive'
IgnorePath '/usr/lib/udev/hwdb.bin'
IgnorePath '/usr/lib/vlc/plugins/plugins.dat'
IgnorePath '/usr/lib/modules/*'
IgnorePath '/usr/lib32/gtk-2.0/2.10.0/immodules.cache'
IgnorePath '/usr/share/applications/mimeinfo.cache'
IgnorePath '/usr/share/fonts/**/fonts.dir'
IgnorePath '/usr/share/fonts/**/fonts.scale'
IgnorePath '/usr/share/hwdata/pci.ids.old'
IgnorePath '/usr/share/mime/*/*.xml'
IgnorePath '/usr/share/mime/aliases'
IgnorePath '/usr/share/mime/generic-icons'
IgnorePath '/usr/share/mime/globs'
IgnorePath '/usr/share/mime/globs2'
IgnorePath '/usr/share/mime/icons'
IgnorePath '/usr/share/mime/magic'
IgnorePath '/usr/share/mime/mime.cache'
IgnorePath '/usr/share/mime/subclasses'
IgnorePath '/usr/share/mime/treemagic'
IgnorePath '/usr/share/mime/types'
IgnorePath '/usr/share/mime/version'
IgnorePath '/usr/share/mime/XMLnamespaces'
IgnorePath '/usr/share/vim/vimfiles/doc/tags'
IgnorePath '/usr/share/glib-2.0/schemas/gschemas.compiled'
IgnorePath '/usr/share/icons/*/icon-theme.cache'
IgnorePath '/usr/share/info/dir'
IgnorePath '/usr/share/texmf*/ls-R'
IgnorePath '/var/*'
