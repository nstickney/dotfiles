#!/usr/bin/env bash

printf '%s\n' "Initializing and updating submodules..."

git submodule init && git submodule update --recursive --remote

printf '%s\n' "Linking configuration files/directories for..."

if [ -x "$(command -v aconfmgr)" ]; then
	printf '%s\n' "  aconfmgr..."
	if [ ! -d "$HOME"/.config ]; then
		mkdir "$HOME"/.config
	fi
	if [ -e "$HOME"/.config/aconfmgr ]; then
		rm -r "$HOME"/.config/aconfmgr
	fi
	ln -s "$HOME"/dotfiles/aconfmgr "$HOME"/.config/aconfmgr
fi

if [ -x "$(command -v bash)" ]; then
	printf '%s\n' "  bash (and readline)..."
	if [ -e "$HOME"/.bashrc ]; then
		rm "$HOME"/.bashrc
	fi
	if [ -e "$HOME"/.bash_profile ]; then
		rm "$HOME"/.bash_profile
	fi
	if [ -e "$HOME"/.inputrc ]; then
		rm "$HOME"/.inputrc
	fi
	ln -s "$HOME"/dotfiles/bashrc "$HOME"/.bashrc
	ln -s "$HOME"/dotfiles/bash_profile "$HOME"/.bash_profile
	ln -s "$HOME"/dotfiles/inputrc "$HOME"/.inputrc
fi

if [ -x "$(command -v dconf)" ]; then
	printf '%s\n' "  dconf (GNOME and GTK)..."
	if [ -e "$HOME"/.config/autostart ]; then
		rm -r "$HOME"/.config/autostart
	fi
	ln -s "$HOME"/dotfiles/autostart "$HOME"/.config/autostart
	if [ -e "$HOME"/.config/dconf ]; then
		rm -r "$HOME"/.config/dconf
	fi
	ln -s "$HOME"/dotfiles/dconf "$HOME"/.config/dconf
	if [ -e "$HOME"/.config/gtk-3.0 ]; then
		rm -r "$HOME"/.config/gtk-3.0
	fi
	ln -s "$HOME"/dotfiles/gtk-3.0 "$HOME"/.config/gtk-3.0
	if [ -e "$HOME"/.config/gtk-4.0 ]; then
		rm -r "$HOME"/.config/gtk-4.0
	fi
	ln -s "$HOME"/dotfiles/gtk-4.0 "$HOME"/.config/gtk-4.0
fi

if [ "nstickney" = "$USER" ] || [ "stickneyn" = "$USER" ]; then
	if [ -x "$(command -v git)" ]; then
		printf '%s\n' "  git..."
		if [ -e "$HOME"/.gitconfig ]; then
			rm "$HOME"/.gitconfig
		fi
		ln -s "$HOME"/dotfiles/gitconfig "$HOME"/.gitconfig
	fi
fi

if [ -x "$(command -v i3)" ]; then
	printf '%s\n' "  i3wm..."
	if [ -e "$HOME"/.i3 ]; then
		rm -r "$HOME"/.i3
	fi
	ln -s "$HOME"/dotfiles/i3 "$HOME"/.i3
fi

if [ -x "$(command -v vim)" ]; then
	printf '%s' "  vim..."
	if [ -e "$HOME"/.vimrc ]; then
		rm "$HOME"/.vimrc
	fi
	if [ -e "$HOME"/.vim ]; then
		rm -r "$HOME"/.vim
	fi
	ln -s "$HOME"/dotfiles/vim "$HOME"/.vim

	if [ "nstickney" = "$USER" ] && [ -x "$(command -v sudo)" ]; then
		printf '%s' " and linking for root..."
		sudo [ -e /root/.vim ] && sudo rm -rf /root/.vim
		sudo ln -s "$HOME"/.vim /root/.vim
	fi
	printf '\n'
fi

if [ -x "$(command -v xrdb)" ] && [ -x "$(command -v rofi)" ]; then
	printf '%s\n' "  X.Org (rofi)..."
	if [ -e "$HOME"/.Xresources ]
	then
		rm "$HOME"/.Xresources
	fi
	ln -s "$HOME"/dotfiles/Xresources "$HOME"/.Xresources
	xrdb "$HOME"/.Xresources
fi
printf '%s\n' "    ...Complete!"

if [ -x "$(command -v sudo)" ]; then
	if [ -x "$(command -v firewall-cmd)" ]; then
		while true; do
			read -r -p "Install firewalld configuration? [y/N]:" -n 1 yn
			echo
			case $yn in
				[Yy]* ) sudo "$HOME"/dotfiles/bin/fw-cmd-init; break;;
				[Nn]* ) break;;
				"" ) break;;
			esac
		done
	fi

	if [ -x "$(command -v iptables)" ]; then
		while true; do
			read -r -p "Install iptables configuration? [y/N]: " -n 1 yn
			echo
			case $yn in
				[Yy]* ) sudo "$HOME"/dotfiles/bin/iptables-init; break;;
				[Nn]* ) break;;
				"" ) break;;
			esac
		done
	fi

	if [ -x "$(command -v nft)" ]; then
		while true; do
			read -r -p "Install nftables configuration? [y/N]: " -n 1 yn
			echo
			case $yn in
				[Yy]* ) sudo "$HOME"/dotfiles/bin/nftables-init; break;;
				[Nn]* ) break;;
				"" ) break;;
			esac
		done
	fi
fi
