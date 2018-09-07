# dotfiles

[![unlicense](https://img.shields.io/badge/un-license-green.svg?style=flat)](http://unlicense.org) [![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg)](https://github.com/RichardLitt/standard-readme)

> @nstickney's configuration files

## Background
Includes configuration for:
* aconfmgr
* Bash
* dconf (GNOME/GTK)
* i3
* rofi (Xresources)
* Vim (including plugins as submodules)
* Xorg (inputrc, Xresources)

## Installation
* Clone repository to `$HOME`
* `./install.sh` (**WARNING**: this deletes current configurations)

The install script only links configuration files for software that is actually available in the `$PATH`.

The i3wm configuration uses a per-host status bar configuration file located in the `./i3/bar` directory (for example, `./i3/bar/eli.toml`). You should rename one (`cp ./i3/bar/default.toml ./i3/bar/$HOSTNAME.toml`), then update it with the correct network and storage devices for your host.

### Dependencies

#### Required
The included i3wm configuration requires the following packages as dependencies (listings are for Arch Linux; YMMV):
* compton (window transparency)
* feh (set desktop background)
* gnome-terminal
* i3lock, imagemagick, and imlib2 (lock screen)
* i3status-rust (information bar) ([AUR](https://aur.archlinux.org/packages/i3status-rust/))
* libpulse (volume control)
* numlockx (turn NumLock on by default)
* playerctl (music player controls)
* polkit-gnome (PolicyKit integration)
* rofi (application launcher/switcher)
* ttf-font-awesome (used in info bar) ([AUR](https://aur.archlinux.org/packages/ttf-font-awesome/))
* xautolock (lock screen on timeout)

#### Optional
* blueman (Bluetooth applet)
* KeepassXC (password manager)
* network-manager-applet (NetworkManager applet)
* solaar (Logitech Unifying Receiver control applet) ([AUR](https://aur.archlinux.org/packages/solaar/))
* ttf-inconsolata (default font)
* xrandr (control multi-screen setups)

## Usage
If you install new software on the list of included configurations, re-run the `install.sh` script to link the required configuration files.

## Contribute
[Contributor Covenant](http://contributor-covenant.org/version/1/3/0/)

## License
[Unlicense](LICENSE)
