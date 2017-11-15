# dotfiles
`nstickney`'s config files.

[![unlicense](https://img.shields.io/badge/un-license-green.svg?style=flat)](http://unlicense.org) [![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg)](https://github.com/RichardLitt/standard-readme)

## Background
Includes configuration for:
* aria2
* Atom
* Bash
* Emacs
* i3
* LaTeX (submodule from Overleaf)
* rofi (Xresources)
* rxvt-unicode (Xresources)
* vim
* Xorg (inputrc, Xresources)

## Installation
* Clone repo to `$HOME`
* `./install` (Fair warning: this deletes current configurations)

The install script only links config files for software that is actually available in the `$PATH`.

The install script checks the list of installed atom packages against the list of desired packages (`atom/packages.list`), installs any new packages required, updates all installed packages to the most recent compatible version, and _overwrites the desired packages list_ without removing any packages. This means that to remove a package from atom, you must remove it manually from atom (using either the settings tab or `apm`), _then remove it from_ `atom/packages.list`; otherwise, the unwanted package will be re-installed the next time you run `./install`.

The i3wm configuration uses a per-host status bar configuration file located in the `./i3/bar` directory (for example, `./i3/bar/eli.toml`). You should rename one (`cp ./i3/bar/default.toml ./i3/bar/$HOSTNAME.toml`), then update it with the correct network and storage devices for your host. You should also update the file `./i3/config` with the correct lattitude and longitude for [redshift](http://jonls.dk/redshift/).

### Dependencies

#### Required
The included i3wm configuration requires the following packages as dependencies (listings are for Arch Linux; YMMV):
* compton (window transparency)
* feh (set desktop background)
* i3lock, imagemagick, and imlib2 (lock screen)
* i3status-rust (infomrmation bar) ([AUR](https://aur.archlinux.org/packages/i3status-rust/))
* libpulse (volume control)
* numlockx (turn on NumLock by default)
* playerctl (music player controls)
* polkit-gnome (PloicyKit integration)
* rofi (application launcher/switcher)
* rxvt-unicode (terminal emulator)
* ttf-font-awesome (used in info bar) ([AUR](https://aur.archlinux.org/packages/ttf-font-awesome/))
* xautolock (lock screen on timeout)

#### Optional
* blueman (Bluetooth applet)
* KeepassX2 (password manager)
* network-manager-applet (NetworkManager applet)
* redshift (automatically change screen color temperature for better sleep)
* solaar (Logitech Unifying Receiver control applet) ([AUR](https://aur.archlinux.org/packages/solaar/))
* ttf-inconsolata (default font)
* xrandr (control multi-screen setups)

## Usage
If you install new software on the list of included configurations, re-run the `install` script to link the required configuration files. The `install` script should also be run if you install or update atom packages, as it will automatically add/udpate them in the configuration.

The only configuration here which requires user interaction is the LaTeX configuration. It is housed in the `tex` directory and contains `common.tex`, a file which provides sane defaults for use with the `article`, `beamer`, and `letter` classes. Copy it to the same directory as your main `.tex` file and add the line `\input{common.tex}` to use it; it automatically detects which of the three supported classes is loaded.

## Contribute
[Contributor Covenant](http://contributor-covenant.org/version/1/3/0/)

## License
[Unlicense](LICENSE)
