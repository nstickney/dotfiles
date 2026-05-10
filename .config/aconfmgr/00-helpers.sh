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

# Fail if no encrypted devices are configured or active
function DetectCrypt() {
  lsblk -rno TYPE 2>/dev/null | grep -qx crypt && return 0
  [ -r /etc/crypttab ] && [ -s /etc/crypttab ] && grep -qv '^\s*\(#\|$\)' /etc/crypttab 2>/dev/null
}

# pciutils 3.15 only honors the last -d filter, so each class is its own call.
# Class codes: 0300 VGA, 0302 3D, 0380 Display-other; 0200 Ethernet,
# 0280 Network-other (Wi-Fi); 0401 Multimedia audio, 0403 HD audio.

# Fail if no AMD GPU is found
function DetectAMDGPU() {
  [[ -n "$(lspci -d 1002::0300; lspci -d 1002::0302; lspci -d 1002::0380)" ]]
}

# Fail if no Intel GPU is found
function DetectIntelGPU() {
  [[ -n "$(lspci -d 8086::0300; lspci -d 8086::0302; lspci -d 8086::0380)" ]]
}

# Fail if no Nvidia GPU is found
function DetectNvidiaGPU() {
  [[ -n "$(lspci -d 10de::0300; lspci -d 10de::0302; lspci -d 10de::0380)" ]]
}

# Fail if no Broadcom network devices exist
function DetectBroadcomNetwork() {
  [[ -n "$(lspci -d 14e4::0200; lspci -d 14e4::0280)" ]]
}

# Fail if no Intel network devices exist
function DetectIntelNetwork() {
  [[ -n "$(lspci -d 8086::0200; lspci -d 8086::0280)" ]]
}

# Fail if no Realtek network devices exist
function DetectRealtekNetwork() {
  [[ -n "$(lspci -d 10ec::0200; lspci -d 10ec::0280)" ]]
}

# Fail if no Realtek devices (network, smartcard, etc.) exist
function DetectRealtek() {
  [[ -n "$(lspci -d 10ec::)" ]]
}

# Fail if no Atheros network devices exist (Qualcomm Atheros: 168c, 1969)
function DetectAtherosNetwork() {
  [[ -n "$(lspci -d 168c::0200; lspci -d 168c::0280; \
           lspci -d 1969::0200; lspci -d 1969::0280)" ]]
}

# Fail if no MediaTek network devices exist (vendor IDs: 14c3, 0e8d)
function DetectMediaTekNetwork() {
  [[ -n "$(lspci -d 14c3::0200; lspci -d 14c3::0280; \
           lspci -d 0e8d::0200; lspci -d 0e8d::0280)" ]]
}

# Fail if no Cirrus Logic audio codec is present
function DetectCirrusAudio() {
  grep -qs 'Cirrus Logic' /proc/asound/card*/codec\#*
  return $?
}

# Fail if no Intel audio devices exist
function DetectIntelAudio() {
  [[ -n "$(lspci -d 8086::0403; lspci -d 8086::0401)" ]]
}

# Fail if not running on Dell hardware
function DetectDell() {
  grep -qi 'dell' /sys/class/dmi/id/sys_vendor 2>/dev/null
}

# Fail if no Intel IPU (Image Processing Unit, e.g. IPU6 on Tiger/Alder/Meteor Lake)
function DetectIPU6() {
  lspci -d 8086:: 2>/dev/null | grep -iqE 'imaging|\bipu[0-9]\b'
}
