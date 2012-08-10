# Minecraft Kit For Linux
Copyright &copy; 2012 Bart Massey

*This work and this site are not in any way affiliated with
Mojang, Inc., makers of the game
Minecraft<sup>&reg;</sup>. This work has been produced
independently.*

*This work is released under the MIT License. Please see the
file COPYING in this distribution for license terms.*

This kit contains a bunch of auxiliary shell scripts and
instructions for helping to set up Mojang's game
[Minecraft](http://minecraft.net) under Linux. This stuff
has been tested only under Debian unstable; as always, YMMV.

The directory `server` contains instructions, scripts and
init.d files for hosting a [CraftBukkit](http://bukkit.org)
Minecraft server on Linux. The server setup uses `screen` to
enable text console administration of the running server. The
server runs as user `minecrft`.

The directory `client` contains instructions and scripts for
setting up a Linux Minecraft client in a reasonable fashion.
The central install script here was inspired by a script by
Willington Vega, which I found on [GitHub
Gist](https://gist.github.com/728367). Ultimately, though, I
wrote it from scratch.

See you in the mines.

Bart Massey
2012-08-09
