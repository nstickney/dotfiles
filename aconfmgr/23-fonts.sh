# Matthew Butterick's Practical Typography https://practicaltypography.com/free-fonts.html
AddPackage adobe-source-code-pro-fonts # Monospaced font family for user interface and coding environments
AddPackage adobe-source-serif-pro-fonts # Serif typeface for setting text. Designed to complement Source Sans Pro
AddPackage otf-fira-mono # Mozilla's monospace typeface designed for Firefox OS
AddPackage otf-fira-sans # Mozilla's sans-serif typeface designed for Firefox OS
AddPackage --foreign otf-bitstream-charter # Bitstream charter fonts
AddPackage --foreign otf-cooper-hewitt # Cooper Hewitt font
AddPackage --foreign otf-ibm-plex # IBM Plex Mono, Sans, and Serif typefaces in otf format

# Should be listed in Practical Typography, but aren't
AddPackage adobe-source-sans-pro-fonts # Sans serif font family for user interface environments

# Emoji
AddPackage noto-fonts-emoji # Google Noto emoji fonts
AddPackage noto-fonts-extra # Google Noto TTF fonts - additional variants

# Icons
AddPackage otf-font-awesome # Iconic font designed for Bootstrap

# Powerline
AddPackage powerline-fonts # patched fonts for powerline

# Unicode coverage
if [ "$USER" == 'nstickney' ]; then
	AddPackage adobe-source-han-sans-cn-fonts # Simplified Chinese OpenType/CFF fonts
	AddPackage adobe-source-han-sans-jp-fonts # Japanese OpenType/CFF fonts
	AddPackage adobe-source-han-sans-kr-fonts # Korean OpenType/CFF fonts
	AddPackage adobe-source-han-sans-otc-fonts # Pan-CJK OpenType/CFF Collection fonts
	AddPackage adobe-source-han-sans-tw-fonts # Traditional Chinese OpenType/CFF fonts
	AddPackage adobe-source-han-serif-cn-fonts # Simplified Chinese OpenType/CFF fonts
	AddPackage adobe-source-han-serif-jp-fonts # Japanese OpenType/CFF fonts
	AddPackage adobe-source-han-serif-kr-fonts # Korean OpenType/CFF fonts
	AddPackage adobe-source-han-serif-otc-fonts # Pan-CJK OpenType/CFF Collection fonts
	AddPackage adobe-source-han-serif-tw-fonts # Traditional Chinese OpenType/CFF fonts
fi
