# shellcheck disable=SC2148
if [[ "$HOSTNAME" == "elisha" || \
	  "$HOSTNAME" == "elizabeth" || \
	  "$HOSTNAME" == "elijah" ]]
then
	AddPackage boinc # Berkeley Open Infrastructure for Network Computing for desktop
	CreateLink /etc/systemd/system/multi-user.target.wants/boinc.service /usr/lib/systemd/system/boinc.service
fi

if [[ "$HOSTNAME" == "elisha" || \
	  "$HOSTNAME" == "elizabeth" || \
	  "$HOSTNAME" == "eli" || \
	  "$HOSTNAME" == "elisheba" ]]
then
	AddPackage coin-or-mp # C-API library that supports most of the functionality of CLP (Coin LP), CBC (Coin Branch-and-Cut), and CGL (Cut Generation Library) projects
	AddPackage libmspack # A library for Microsoft compression formats
	AddPackage libmythes # a simple thesaurus
	AddPackage libreoffice-fresh # LibreOffice branch which contains new features and program enhancements
	AddPackage pstoedit # Translates PostScript and PDF graphics into other vector formats
fi
