#!/bin/sh

# Use powerpill instead of pacman when available
[ -x "$(command -v powerpill)" ] && export PACMAN=$(command -v powerpill)
