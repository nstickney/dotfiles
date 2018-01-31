#!/bin/sh

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

if [ -x "$(command -v aria2c)" ]; then
    printf '%s\n' "  aria2..."
    if [ ! -d "$HOME"/.config ]; then
        mkdir "$HOME"/.config
    fi
    if [ -d "$HOME"/.config/aria2 ]; then
        rm -r "$HOME"/.config/aria2
    fi
    ln -s "$HOME"/dotfiles/aria2 "$HOME"/.config/aria2
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
    if [ -d "$HOME"/.config/autostart ]; then
        rm -r "$HOME"/.config/autostart
    fi
    ln -s "$HOME"/dotfiles/autostart "$HOME"/.config/autostart
    if [ -d "$HOME"/.config/dconf ]; then
        rm -r "$HOME"/.config/dconf
    fi
    ln -s "$HOME"/dotfiles/dconf "$HOME"/.config/dconf
    if [ -d "$HOME"/.config/gtk-3.0 ]; then
        rm -r "$HOME"/.config/gtk-3.0
    fi
    ln -s "$HOME"/dotfiles/gtk-3.0 "$HOME"/.config/gtk-3.0
    if [ -d "$HOME"/.config/gtk-4.0 ]; then
        rm -r "$HOME"/.config/gtk-4.0
    fi
    ln -s "$HOME"/dotfiles/gtk-4.0 "$HOME"/.config/gtk-4.0
fi

if [ -x "$(command -v emacs)" ]; then
    printf '%s\n' "  emacs..."
    if [ -d "$HOME"/.emacs ]; then
        rm "$HOME"/.emacs
    fi
    ln -s "$HOME"/dotfiles/i3 "$HOME"/.emacs
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
    if [ -d "$HOME"/.i3 ]; then
        rm -r "$HOME"/.i3
    fi
    ln -s "$HOME"/dotfiles/i3 "$HOME"/.i3
fi

if [ -x "$(command -v vim)" ]; then
    printf '%s\n' "  vim..."
    if [ -e "$HOME"/.vimrc ]; then
        rm "$HOME"/.vimrc
    fi
    if [ -d "$HOME"/.vim ]; then
        rm -r "$HOME"/.vim
    fi
    ln -s "$HOME"/dotfiles/vim "$HOME"/.vim
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
