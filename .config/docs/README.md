# dotfiles

[![license](https://img.shields.io/github/license/nstickney/dotfiles.svg)](LICENSE)
[![standard-readme compliant](https://img.shields.io/badge/readme%20style-standard-brightgreen.svg)](https://github.com/RichardLitt/standard-readme)

> [stick's configuration files](https://git.sr.ht/~stick/dotfiles)

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Background

Includes configuration for:

- `aconfmgr`
- `alacritty`
- `aurman`
- `bash`
- `gdb`
- `git`
- `sway` (with `swaylock` )
- `tmux`
- `vim` (including plugins as submodules)
- `waybar`

Also includes a set of scripts and small executables used throughout the configuration (`./bin/`).
Many sources are linked throughout the configuration files.

## Install

My dotfiles are kept in a bare repo on `$HOME`, as [suggested](https://news.ycombinator.com/item?id=11071754) by [StreakyCobra](https://github.com/streakycobra) and [written up](https://www.atlassian.com/git/tutorials/dotfiles) by [durdn](https://bitbucket.org/durdn) (hat tip [@sir@cmpwn.com](https://cmpwn.com/@sir/103116101528227790)).

1. Clone as a bare repository to `$HOME/.dotfiles`.
1. Create the `dots` alias to interact with the repository.
1. Install submodules (vim plugins, [gitstatus](https://github.com/romkatv/gitstatus), etc)

```bash
$ git clone --bare https://git.sr.ht/~stick/dotfiles $HOME/.dotfiles
$ alias dots='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
$ dots submodule update --init --recursive --remote
```

**NOTE:** Performing the checkout will likely fail due to files already in place (`.bashrc`, `.tmux.conf`, `.vim`, etc).
You should (back up and) remove the offending files and simply re-run the checkout.

### Dependencies

#### Required

The included sway configuration requires the following packages as dependencies (listings are for Arch Linux; YMMV):

- `adobe-source-code-pro-fonts` (default font)
- `alacritty` (terminal emulator; also used for launcher)
- `otf-font-awesome` (used in info bar)
- `polkit-gnome` (PolicyKit integration in `gdm` and `sway`)
- `python-i3ipc` (Python library to control `sway`)
- `sway` (window manager)
- `waybar` (status bar and system tray)

#### Optional

- `libpulse` (volume control)
- `playerctl` (music player controls)

## Usage

Use the `dots` alias (made permanent in `.bashrc`) to interact with the repository.

**NOTE:** The `.gitignore` has a `*` rule which matches _everything_, so you must use `-f` or `--force` when adding files or submodules.

I typically use `gdm` to handle workstation login; it is included in the `aconfmgr` configuration.

## Contributing

> Contributors to this project adhere to the [Code of Conduct](CONDUCT.md).

I welcome [issues](https://gitlab.com/nstickney/dotfiles/issues "Issues"), but I prefer [pull requests](https://gitlab.com/nstickney/dotfiles/merge_requests "Pull requests")!
Please follow the [trunk-based development](https://trunkbaseddevelopment.com/) model (where your fork is a "feature branch").
Contributions should [use git with discipline](https://drewdevault.com/2019/02/25/Using-git-with-discipline.html).

## LICENSE

Copyright &copy; 2017-2020 stick.
Where not otherwise specified, this repository is licensed under the [Mozilla Public License 2.0](LICENSE).
