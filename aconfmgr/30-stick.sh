AddPackage --foreign bitwarden-bin # A secure and free password manager for all of your devices.
AddPackage boinc # Berkeley Open Infrastructure for Network Computing for desktop
AddPackage --foreign exercism-cli # Command line client for exercism.io
AddPackage hugo # Fast and Flexible Static Site Generator in Go
AddPackage --foreign hydroxide-git # A third-party, open-source ProtonMail CardDAV, IMAP and SMTP bridge
# AddPackage --foreign lbry-app-bin # The LBRY app built using electron
AddPackage kbfs # The Keybase filesystem
AddPackage keybase # CLI tool for GPG with keybase.io
AddPackage keybase-gui # GUI frontend for GPG with keybase.io
AddPackage libreoffice-fresh # LibreOffice branch which contains new features and program enhancements
AddPackage coin-or-mp # libreoffice-fresh opt dep
AddPackage pstoedit # libreoffice-fresh opt dep
AddPackage ncdu # Disk usage analyzer with an ncurses interface
AddPackage pandoc # Conversion between markup formats
AddPackage pandoc-citeproc # Supports using pandoc with citeproc (pandoc opt dep)
AddPackage pandoc-crossref # Pandoc filter for cross-references (pandoc opt dep)
AddPackage texlive-core # pandoc opt dep
# AddPackage --foreign protonmail-bridge # Integrate ProtonMail paid account with any program that supports IMAP and SMTP
AddPackage rmlint # Tool to remove duplicates and other lint, being much faster than fdupes
AddPackage rmlint-shredder # Graphical user interface for rmlint
AddPackage thunderbird # Standalone mail and news reader from mozilla.org
AddPackage truecrypt # Free open-source cross-platform disk encryption software

# AddPackage --foreign fslint # A utility to find and clean various forms of lint on a filesystem
# AddPackage gramps # Genealogy program, which helps you track your family tree
# AddPackage gtkspell3 # opt dep for gramps
# AddPackage libgexiv2 # opt dep for gramps
# AddPackage osm-gps-map # opt dep for gramps
# AddPackage python-pyicu # opt dep for gramps
# AddPackage rcs # opt dep for gramps
# AddPackage --foreign zotero # Zotero Standalone, a free, easy-to-use tool to help you collect, organize, cite, and share your research sources
# AddPackage xpdf # opt dep for zotero

CreateLink /etc/systemd/system/multi-user.target.wants/boinc.service /usr/lib/systemd/system/boinc.service
