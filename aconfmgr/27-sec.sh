# Forensics
# AddPackage foremost # A console program to recover files based on their headers, footers, and internal data structures
# AddPackage sleuthkit # File system and media management forensic analysis tools
# AddPackage --foreign autopsy # The Autopsy Forensic Browser is a GUI for The Sleuth Kit.

# Host Security
# AddPackage aide # A file integrity checker and intrusion detection program.
AddPackage rkhunter # Checks machines for the presence of rootkits and other unwanted tools

# Log Management
# AddPackage filebeat # Sends log files to Logstash or directly to Elasticsearch
# CreateLink /etc/systemd/system/multi-user.target.wants/filebeat.service /usr/lib/systemd/system/filebeat.service

# Network/Scanning Tools
# AddPackage metasploit # Advanced open-source platform for developing, testing, and using exploit code
AddPackage vulscan # A module which enhances nmap to a vulnerability scanner

### OpenVAS
# AddPackage greenbone-security-assistant # Greenbone Security Assistant (gsa) - OpenVAS web frontend
# AddPackage openvas-cli # The OpenVAS Command-Line Interface
# AddPackage openvas-libraries # The OpenVAS libraries
# AddPackage openvas-manager # A layer between the OpenVAS Scanner and various client applications
# AddPackage openvas-scanner # The OpenVAS scanning Daemon

# Reverse Engineering
# AddPackage radare2 # Open-source tools to disasm, debug, analyze and manipulate binary files
# AddPackage radare2-cutter # Qt and C++ GUI for radare2 reverse engineering framework
