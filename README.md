# dotfiles

[![license](https://img.shields.io/github/license/nstickney/dotfiles.svg)](LICENSE)
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> @nstickney's configuration files

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Background

Includes configuration for:
* `aconfmgr`
* `alacritty`
* `bash`
* `dconf` (GNOME/GTK)
* `i3` (`i3-gaps`)
* `rofi` (Xresources)
* `tmux`
* `vim` (including plugins as submodules)
* `xorg` (inputrc, Xresources)

### Acknowledgements:

This repository's [logo](logo.png) has been shamelessly ~~stolen~~ borrowed from [Ícaro Medeiros](https://dotfiles.zeef.com/icaro.medeiros). Many other sources are linked throughout the configuration files.


## Install

* Clone repository to `$HOME`
* `./install` (**NOTE:** Existing configurations will be renamed `*.old`.)

The install script only links configuration files for software that is actually available in the `$PATH`.

The i3wm configuration uses a per-host status bar configuration file located in the `./i3/bar` directory (for example, `./i3/bar/eli.toml`). You should rename one (`cp ./i3/bar/elisha.toml ./i3/bar/$HOSTNAME.toml`), then update it with the correct network and storage devices for your host.

### Dependencies

#### Required

The included i3wm configuration requires the following packages as dependencies (listings are for Arch Linux; YMMV):
* `i3-gaps` (window manager)
* `alacritty` or `rxvt-unicode` (terminal emulator)
* `compton` (window transparency)
* `feh` (set desktop background)
* `i3lock`, `imagemagick`, and `imlib2` (lock screen)
* `i3status-rust` (information bar) ([AUR](https://aur.archlinux.org/packages/i3status-rust/))
* `otf-font-awesome` (used in info bar)
* `polkit-gnome` (PolicyKit integration)
* `rofi` (application launcher/switcher)
* `xautolock` (lock screen on timeout)

#### Optional

* `adobe-source-code-pro-fonts` (default font)
* `blueman` (Bluetooth applet)
* `KeepassXC` (password manager)
* `libpulse` (volume control)
* `network-manager-applet` (NetworkManager applet)
* `numlockx` (turn NumLock on by default)
* `playerctl` (music player controls)
* `solaar` (Logitech Unifying Receiver control applet) ([AUR](https://aur.archlinux.org/packages/solaar/))
* `xrandr` (control multi-screen setups)

## Usage

If you install new software on the list of included configurations, re-run the `install` script to link the required configuration files.

I typically use `gdm` to handle workstation login; it is included in the `aconfmgr` configuration.

## Contributing

> Contributors to this project adhere to the [Code of Conduct](CONDUCT.md).

I welcome [issues](https://gitlab.com/nstickney/dotfiles/issues "Issues"), but I prefer [pull requests](https://gitlab.com/nstickney/dotfiles/merge_requests "Pull requests")!
We follow the [trunk-based development](https://trunkbaseddevelopment.com/) model (where your fork is a "feature branch").
Contributions should [use git with discipline](https://drewdevault.com/2019/02/25/Using-git-with-discipline.html).

## LICENSE

Copyright &copy; 2017-2019 @nstickney.
Where not otherwise specified, this repository is licensed under the [Mozilla Public License 2.0](LICENSE).