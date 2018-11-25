# shellcheck disable=SC2148
#AddPackage --foreign all-repository-fonts # Meta package for all fonts in the official repositories
#AddPackage --foreign ephifonts # A collection of free fonts including Helvetica, Futura and Gotham (ephifonts.com)
#AddPackage --foreign league-fonts # A package depending on all the fonts from The League Of The Moveable Type
#AddPackage --foreign otf-bitstream-charter # Bitstream charter fonts
#AddPackage --foreign ttf-sil-fonts # A collection of OFL-licensed fonts from SIL (Abyssinica, Andika, Annapurna, Apparatus, Charis and more)

AddPackage adobe-source-code-pro-fonts # MONOSPACE
AddPackage otf-font-awesome # Iconic font designed for Bootstrap
AddPackage --foreign noto-fonts-all # COVERAGE

#CopyFile /etc/fonts/conf.d/20-no-embedded.conf # Don't use bitmaps
