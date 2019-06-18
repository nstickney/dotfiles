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
* `aurman`
* `bash`
* gdb
* git
* sway (with swaylock)
* `tmux`
* `vim` (including plugins as submodules)

Also includes a set of scripts and small executables used throughout the configuration (```./bin/`).

### Acknowledgements:

This repository's [logo](logo.png) has been shamelessly ~~stolen~~ borrowed from [Ícaro Medeiros](https://dotfiles.zeef.com/icaro.medeiros). Many other sources are linked throughout the configuration files.

## Install

* Clone repository to `$HOME`
* `./install` (**NOTE:** Existing configurations will be renamed `*.old`.)

The install script only links configuration files for software that is actually available in the `$PATH`.

### Dependencies

#### Required

The included sway configuration requires the following packages as dependencies (listings are for Arch Linux; YMMV):

* `sway` (window manager)
* `alacritty` (terminal emulator)
* `i3ipc-python` (used in scripts interacting with sway) ([AUR](https://aur.archlinux.org/packages/i3ipc-python))
* `i3status-rust` (information bar) ([AUR](https://aur.archlinux.org/packages/i3status-rust/))
* `otf-font-awesome` (used in info bar)
* `polkit-gnome` (PolicyKit integration)

#### Optional

* `adobe-source-code-pro-fonts` (default font)
* `libpulse` (volume control)
* `playerctl` (music player controls)
* `solaar` (Logitech Unifying Receiver control applet) ([AUR](https://aur.archlinux.org/packages/solaar/))

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
