# dotfiles
`nstickney`'s config files.

[![unlicense](https://img.shields.io/badge/un-license-green.svg?style=flat)](http://unlicense.org) [![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg)](https://github.com/RichardLitt/standard-readme)

## Background
Includes configuration for:
* aconfmgr
* aria2
* Bash
* dconf (GNOME/GTK)
* Emacs
* i3
* LaTeX (submodule from Overleaf)
* rofi (Xresources)
* vim (including plugins as submodules)
* Xorg (inputrc, Xresources)

## Installation
* Clone repo to `$HOME`
* `./install.sh` (Fair warning: this deletes current configurations)

The install script only links config files for software that is actually available in the `$PATH`.

The i3wm configuration uses a per-host status bar configuration file located in the `./i3/bar` directory (for example, `./i3/bar/eli.toml`). You should rename one (`cp ./i3/bar/default.toml ./i3/bar/$HOSTNAME.toml`), then update it with the correct network and storage devices for your host.

### Dependencies

#### Required
The included i3wm configuration requires the following packages as dependencies (listings are for Arch Linux; YMMV):
* compton (window transparency)
* feh (set desktop background)
* gnome-terminal
* i3lock, imagemagick, and imlib2 (lock screen)
* i3status-rust (infomrmation bar) ([AUR](https://aur.archlinux.org/packages/i3status-rust/))
* libpulse (volume control)
* numlockx (turn on NumLock by default)
* playerctl (music player controls)
* polkit-gnome (PolicyKit integration)
* rofi (application launcher/switcher)
* ttf-font-awesome (used in info bar) ([AUR](https://aur.archlinux.org/packages/ttf-font-awesome/))
* xautolock (lock screen on timeout)

#### Optional
* blueman (Bluetooth applet)
* KeepassXC (password manager)
* network-manager-applet (NetworkManager applet)
* redshift-gtk (automatically change screen color temperature for better sleep)
* solaar (Logitech Unifying Receiver control applet) ([AUR](https://aur.archlinux.org/packages/solaar/))
* ttf-inconsolata (default font)
* xrandr (control multi-screen setups)

## Usage
If you install new software on the list of included configurations, re-run the `install.sh` script to link the required configuration files.

## Contribute
[Contributor Covenant](http://contributor-covenant.org/version/1/3/0/)

## License
[Unlicense](LICENSE)
