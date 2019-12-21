#!/usr/bin/env bash

# shellcheck disable=1090
case "$-" in
	*i*) [ -f "$HOME/.bashrc" ] && source "$HOME/.bashrc";;
esac
