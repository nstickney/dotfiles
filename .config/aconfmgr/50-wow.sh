# if ! DetectWSL; then # No GUI in WSL
# 	AddPackage lutris
# 	AddPackage --foreign lutris-wine-meta
# 	AddPackage winetricks
#
# 	DetectAMDGPU && AddPackage --foreign lutris-world-of-warcraft-dependencies-amd || :
# 	DetectNvidiaGPU && AddPackage --foreign lutris-world-of-warcraft-dependencies-nvidia || :
# fi
