if ! DetectWSL; then # No GUI in WSL
	AddPackage lutris
	AddPackage --foreign lutris-battlenet-meta
	AddPackage --foreign lutris-wine-meta
	AddPackage winetricks

	DetectAMDGPU && AddPackage --foreign lutris-world-of-warcraft-dependencies-amd || :
	DetectNvidia && AddPackage --foreign lutris-world-of-warcraft-dependencies-nvidia || :
fi
