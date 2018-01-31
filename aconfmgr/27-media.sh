# shellcheck disable=SC2148
if [[ "$HOSTNAME" == "elisha" || \
      "$HOSTNAME" == "elizabeth" || \
      "$HOSTNAME" == "eliab" || \
      "$HOSTNAME" == "eli" || \
      "$HOSTNAME" == "elisheba" || \
      "$HOSTNAME" == "elim" ]]
then
    AddPackage gimp # GNU Image Manipulation Program
    AddPackage handbrake # Multithreaded video transcoder
    AddPackage inkscape # Professional vector graphics editor
    AddPackage openshot # an open-source, non-linear video editor for Linux based on MLT framework
    AddPackage simplescreenrecorder # A feature-rich screen recorder that supports X11 and OpenGL.
    # AddPackage --foreign archlinux-artwork # Official logos, icons, CD labels and other artwork for Arch Linux
fi

AddPackage libdvdcss # Portable abstraction library for DVD decryption
AddPackage vlc # A multi-platform MPEG, VCD/DVD, and DivX player
AddPackage qt4 # vlc opt dep
