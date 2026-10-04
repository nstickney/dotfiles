if ! DetectVM || DetectWSL; then # Install on workstations and WSL
	AddPackage ansible   # Official assortment of Ansible collections
	AddPackage sshpass   # OPTIONAL DEPENDENCY (ansible)
	AddPackage terraform # HashiCorp tool for building and updating infrastructure as code idempotently
fi
