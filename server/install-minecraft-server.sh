#!/bin/sh
# Copyright © 2012 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.

# Download and install a Craftbukkit Minecraft server on a
# Linux box.

# If you change this, be sure to change the corresponding
# definition in minecraft-server.sh .
SERVER_DIR=/usr/local/opt/minecraft-server

PGM="`basename $0`"

if [ -x "$SERVER_DIR" ]
then
    echo "$PGM: cowardly refusing since $SERVER_DIR exists." >&2
    exit 1
fi
mkdir "$SERVER_DIR"
cd "$SERVER_DIR"

wget "http://dl.bukkit.org/latest-rb/craftbukkit.jar"

