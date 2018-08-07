#!/usr/bin/env bash

# https://gist.github.com/pfig/1808188#gistcomment-1667360
convert $1 -define icon:auto-resize=256,192,128,96,64,48,32,16 favicon.ico
