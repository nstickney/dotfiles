#!/usr/bin/env bash

servers="x-hkp://pool.sks-keyservers.net pgp.mit.edu wwwkeys.ch.pgp.net"
for server in $servers; do
	gpg --keyserver $server --send-key B5B44C16A4537ACDAD12880DC0CB19EB0309B80D
done
