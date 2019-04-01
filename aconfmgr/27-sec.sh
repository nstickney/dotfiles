if [[ "$HOSTNAME" == "elisha" || "$HOSTNAME" == "elias" ]]; then
	# Cracking
	# AddPackage hashcat # Multithreaded advanced password recovery utility
	# AddPackage hashcat-utils # Set of small utilities that are useful in advanced password cracking
	# AddPackage hcxkeys # Set of tools to generate plainmasterkeys (rainbowtables) and hashes for hashcat and John the Ripper
	# AddPackage hcxtools # Portable solution for capturing wlan traffic and conversion to hashcat and John the Ripper formats

	# Forensics
	AddPackage --foreign autopsy # The Autopsy Forensic Browser is a GUI for The Sleuth Kit.
	AddPackage extundelete # Utility for recovering deleted files from ext2, ext3 or ext4 partitions by parsing the journal
	AddPackage foremost # A console program to recover files based on their headers, footers, and internal data structures
	AddPackage sleuthkit # File system and media management forensic analysis tools

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
	AddPackage --foreign burpsuite # An integrated platform for performing security testing of web applications (free edition).
	AddPackage testssl.sh # Testing TLS/SSL encryption

	# Signal analysis
	AddPackage --foreign inspectrum # SDR signal analyzer
fi

# Host Security
# AddPackage aide # A file integrity checker and intrusion detection program.
AddPackage fail2ban # Bans IPs after too many failed authentication attempts
AddPackage lynis # Security and system auditing tool to harden Unix/Linux systems
AddPackage rkhunter # Checks machines for the presence of rootkits and other unwanted tools

# Log Management
# AddPackage --foreign bro-aux # Small auxiliary tools for Bro.
# AddPackage filebeat # Sends log files to Logstash or directly to Elasticsearch
# CreateLink /etc/systemd/system/multi-user.target.wants/filebeat.service /usr/lib/systemd/system/filebeat.service

### OpenVAS
# AddPackage greenbone-security-assistant # Greenbone Security Assistant (gsa) - OpenVAS web frontend
# AddPackage openvas-cli # The OpenVAS Command-Line Interface
# AddPackage openvas-libraries # The OpenVAS libraries
# AddPackage openvas-manager # A layer between the OpenVAS Scanner and various client applications
# AddPackage openvas-scanner # The OpenVAS scanning Daemon
