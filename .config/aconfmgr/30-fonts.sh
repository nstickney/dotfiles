# Reference https://practicaltypography.com/free-fonts.html

if ! DetectWSL; then # No GUI in WSL
	# Basics
	AddPackage adobe-source-code-pro-fonts  # Monospaced font family for user interface and coding environments
	AddPackage adobe-source-sans-pro-fonts  # Sans-serif font family for user interface environments
	AddPackage adobe-source-serif-pro-fonts # Serif typeface designed to complement Source Sans

	# Extras
	AddPackage noto-fonts-cjk   # Google Noto CJK fonts
	AddPackage noto-fonts-emoji # Google Noto emoji fonts
	AddPackage noto-fonts-extra # Google Noto TTF fonts - additional variants
fi
