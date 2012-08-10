#!/bin/sh
# Copyright © 2012 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.
PGM="`basename $0`"
USAGE="$PGM: usage: $PGM <icon-target-directory>"

# Install Minecraft icon and its variants.

if [ $# -ne 1 ]
then
    echo "$USAGE" >&2
    exit 1
fi

if [ ! -f "./minecraft-icon.svg" ]
then
    echo "$PGM: Please run from installation directory" >&2
    exit 1
fi

ICON_DIR="$1"
cp minecraft-icon.svg "$ICON_DIR/scalable/apps/minecraft.svg"
for s in 256 192 160 128 96 72 64 48 36 32 24 22 16
do
    NxN="${s}x${s}"
    ID="$ICON_DIR/$NxN"
    if [ ! -d "$ID" ]
    then
        echo "$PGM: skipping $NxN" >&2
        continue
    fi
    FN=minecraft-icon-$s.png
    if [ ! -f $FN ]
    then
        inkscape -e $FN -w $s -h $s minecraft-icon.svg
        if [ $? -ne 0 ]
        then
            echo "$PGM: icon conversion failed" >&2
            exit 1
        fi
    fi
    cp $FN "$ID/apps/minecraft.png"
done
