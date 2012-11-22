#!/bin/sh
# Copyright © 2012 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.
PGM="`basename $0`"

# Download and install a stock Minecraft client on a Linux
# box.

# XXX Be a little careful with these variables. They're kind
# of tangly.

PREFIX=/usr
BIN=$PREFIX/bin
SHARE=$PREFIX/share

JAVA=$BIN/java
MINECRAFT_URL='http://www.minecraft.net/download/minecraft.jar'

CLIENT_DIR=$SHARE/minecraft-client
DESKTOP_DIR=$SHARE/applications

# If you change this, be sure to change the corresponding
# line in minecraft.desktop .
ICON_DIR=$SHARE/icons/hicolor

if [ -d "$CLIENT_DIR" ] || mkdir "$CLIENT_DIR"
then
    :
else
    echo "No client directory $CLIENT_DIR, and cannot create." >&2
    exit 1
fi

if [ ! -f "./install-minecraft-client.sh" ]
then
    echo "$PGM: Please run from installation directory" >&2
    exit 1
fi

cp minecraft.desktop "$DESKTOP_DIR/"

( cd icon && sh ./install-minecraft-icon.sh "$ICON_DIR" )

if [ -f $BIN/minecraft ]
then
    echo "$PGM: not replacing existing $BIN/minecraft" >&2
else
    sed -e "s#@JAVA@#$JAVA#g" \
        -e "s#@CLIENT_DIR@#$CLIENT_DIR#g" \
        minecraft.sh >$BIN/minecraft
    chmod +x $BIN/minecraft
fi

cd "$CLIENT_DIR"
if [ -f minecraft.jar ]
then
    echo "$PGM: using existing minecraft.jar" >&2
else
    wget -O minecraft.jar "$MINECRAFT_URL"
    if [ $? -ne 0 ]
    then
        echo "$PGM: couldn't download $MINECRAFT_URL right now" >&2
        exit 1
    fi
fi

exit 0
