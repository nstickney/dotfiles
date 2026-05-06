set -o pipefail

# Fail if not in Windows Subsystem for Linux
function DetectWSL() {
	grep -i -q microsoft /proc/version
	return $?
}

# Fail if not in a container / virtual machine / WSL
function DetectVM() {
	# https://www.freedesktop.org/software/systemd/man/systemd-detect-virt.html
	systemd-detect-virt --quiet
	return $?
}

# Fail if not in VirtualBox
function DetectVirtualBox() {
	systemd-detect-virt | grep -i -q oracle
	return $?
}

# Fail if not on an AMD processor
function DetectAMDCPU() {
	grep -q '^vendor_id\s*:\s*AuthenticAMD' /proc/cpuinfo
	return $?
}

# Fail if not on an Intel processor
function DetectIntelCPU() {
	grep -q '^vendor_id\s*:\s*GenuineIntel' /proc/cpuinfo
	return $?
}

# Fail if no NVMe drives are found
function DetectNVMe() {
	compgen -G '/dev/nvme*' >/dev/null
	return $?
}

# Fail if no encrypted devices are configured
function DetectCrypt() {
	[ -s /etc/crypttab ] && sudo -n grep -qv '^\s*\(#\|$\)' /etc/crypttab 2>/dev/null
	return $?
}

# Fail if no AMD GPU is found
function DetectAMDGPU() {
	lspci -v | grep -iE 'amd/ati|advanced micro devices' | grep -iqE 'vga|3d|display'
	return $?
}

# Fail if no Intel GPU is found
function DetectIntelGPU() {
	lspci -v | grep -i 'intel' | grep -iqE 'vga|3d|display'
	return $?
}

# Fail if no Nvidia GPU is found
function DetectNvidiaGPU() {
	lspci -v | grep -i 'nvidia' | grep -iqE 'vga|3d|display'
	return $?
}

# Fail if no Broadcom network devices exist
function DetectBroadcomNetwork() {
	lspci -k | grep -i 'broadcom' | grep -iqE 'network|ethernet'
	return $?
}

# Fail if no Intel network devices exist
function DetectIntelNetwork() {
	lspci -k | grep -i 'intel' | grep -iqE 'network|ethernet'
	return $?
}

# Fail if no Realtek network devices exist
function DetectRealtekNetwork() {
	lspci -k | grep -i 'realtek' | grep -iqE 'network|ethernet'
	return $?
}

# Fail if no Atheros network devices exist
function DetectAtherosNetwork() {
	lspci -k | grep -i 'atheros' | grep -iqE 'network|ethernet'
	return $?
}

# Fail if no MediaTek network devices exist
function DetectMediaTekNetwork() {
	lspci -k | grep -i 'mediatek' | grep -iqE 'network|ethernet'
	return $?
}

# Fail if no Cirrus Logic audio codec is present
function DetectCirrusAudio() {
	grep -qs 'Cirrus Logic' /proc/asound/card*/codec\#*
	return $?
}

# Fail if no Intel audio devices exist
function DetectIntelAudio() {
	lspci | grep -i 'intel' | grep -iqE 'audio|sound'
	return $?
}
