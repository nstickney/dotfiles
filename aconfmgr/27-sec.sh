if [[ "$HOSTNAME" == "elisha" || "$HOSTNAME" == "eliab" ]]; then
	# Forensics
	AddPackage foremost # A console program to recover files based on their headers, footers, and internal data structures
	AddPackage sleuthkit # File system and media management forensic analysis tools
	AddPackage --foreign autopsy # The Autopsy Forensic Browser is a GUI for The Sleuth Kit.

	# Network/Scanning Tools
	AddPackage badtouch # Scriptable network authentication cracker
	AddPackage masscan # TCP port scanner, spews SYN packets asynchronously, scanning entire Internet in under 5 minutes
	AddPackage metasploit # Advanced open-source platform for developing, testing, and using exploit code
	AddPackage vulscan # A module which enhances nmap to a vulnerability scanner

	# Reverse Engineering
	# AddPackage --foreign bingrep # Small binary version of grep
	AddPackage radare2 # Open-source tools to disasm, debug, analyze and manipulate binary files
	AddPackage radare2-cutter # Qt and C++ GUI for radare2 reverse engineering framework

	# Security Checking
	AddPackage testssl.sh # Testing TLS/SSL encryption
fi

# Host Security
# AddPackage aide # A file integrity checker and intrusion detection program.
AddPackage fail2ban # Bans IPs after too many failed authentication attempts
AddPackage rkhunter # Checks machines for the presence of rootkits and other unwanted tools

# Log Management
# AddPackage filebeat # Sends log files to Logstash or directly to Elasticsearch
# CreateLink /etc/systemd/system/multi-user.target.wants/filebeat.service /usr/lib/systemd/system/filebeat.service

### OpenVAS
# AddPackage greenbone-security-assistant # Greenbone Security Assistant (gsa) - OpenVAS web frontend
# AddPackage openvas-cli # The OpenVAS Command-Line Interface
# AddPackage openvas-libraries # The OpenVAS libraries
# AddPackage openvas-manager # A layer between the OpenVAS Scanner and various client applications
# AddPackage openvas-scanner # The OpenVAS scanning Daemon

