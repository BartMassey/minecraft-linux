#!/bin/sh
for s in 256 192 160 128 96 72 64 48 36 32 24 22 16
do
    FN=minecraft-icon-$s.png
    rm -f $FN
    inkscape -e $FN -w $s -h $s minecraft-icon.svg
done
