#!/bin/sh
# Copyright © 2012 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.
PGM="`basename $0`"

# Download and install a Craftbukkit Minecraft server on a
# Linux box.

CRAFTBUKKIT_URL="http://dl.bukkit.org/latest-rb/craftbukkit.jar"

# If you change these, be sure to change the corresponding
# definition in minecraft-server.rc .
SERVER_DIR=/usr/share/minecraft-server

if [ ! -f "./install-minecraft-server.sh" ]
then
    echo "$PGM: Please run from installation directory" >&2
    exit 1
fi

if [ -x "$SERVER_DIR" ]
then
    echo "$PGM: cowardly refusing since $SERVER_DIR exists." >&2
    exit 1
fi

MC_HOME="`bash -c \"echo ~minecrft\"`"
case "$MC_HOME" in
    '~minecrft')
	adduser --gecos 'Minecraft Server' --home "$SERVER_DIR" \
	  --disabled-password minecrft
	;;
    "$SERVER_DIR")
	;;
    *)
	usermod -d "$SERVER_DIR" minecrft
	;;
esac

[ ! -d "$SERVER_DIR" ] && mkdir "$SERVER_DIR"
chown minecrft "$SERVER_DIR"

cp minecraft-server.sh "$SERVER_DIR"/

sed "s#@SERVER_DIR@#$SERVER_DIR#g" \
    minecraft-server.rc >/etc/init.d/minecraft-server
chown root /etc/init.d/minecraft-server
chmod 755 /etc/init.d/minecraft-server
update-rc.d minecraft-server enable

cd "$SERVER_DIR"
mkdir .ssh
( cd .ssh &&
  chmod 700 . &&
  ssh-keygen -N '' -t rsa -b 2048 -f id-rsa-minecraft &&
  mv id-rsa-minecraft.pub authorized_keys &&
  chmod 600 authorized_keys &&
  mv id-rsa-minecraft .. )
chown -R minecrft.minecrft .
chown root minecraft-server.sh
chmod 755 minecraft-server.sh
wget -O craftbukkit.jar "$CRAFTBUKKIT_URL"
if [ $? -ne 0 ]
then
    echo "$PGM: Couldn't download $CRAFTBUKKIT_URL: stopping for now" >&2
    exit 1
fi

exit 0
