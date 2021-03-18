if ! DetectVM || DetectWSL; then   # Install on workstations and WSL
	AddPackage bash-bats              # Bash Automated Testing System
	AddPackage --foreign exercism-bin # Command line client for exercism.io
	AddPackage python-pytest          # Simple powerful testing with Python
fi
