#!/bin/sh
# Copyright © 2012 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.
cd "$HOME"/.minecraft &&
exec @JAVA@ -Xmx1024M -Xms512M \
  -cp @CLIENT_DIR@/minecraft.jar \
  net.minecraft.LauncherFrame
