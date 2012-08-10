#!/bin/sh
# Copyright © 2012 Bart Massey
# [This program is licensed under the "MIT License"]
# Please see the file COPYING in the source
# distribution of this software for license terms.
SERVER_DIR=/usr/local/opt/minecraft-server
cd $SERVER_DIR
case $1 in
start)
    if ssh -i id-rsa-minecrft minecrft@localhost 'screen -ls' 2>/dev/null |
       egrep '[0-9] [sS]ocket' >/dev/null
    then
        echo "already running."
        exit 1
    fi
    echo "screen -d -S minecraft \
          -m /usr/bin/java -Xmx2048M -Xms2048M \
          -jar craftbukkit.jar nogui" | su minecrft
    Q=$?
    if [ $Q -ne 0 ]
    then
        echo "failed with status $Q."
        exit 1
    fi
    echo "started."
    exit 0
    ;;
stop)
    if ssh -i id-rsa-minecrft minecrft@localhost 'screen -ls' 2>/dev/null |
       egrep '[Nn]o [Ss]ocket' >/dev/null
    then
        echo "not running."
        exit 1
    fi
    ssh -i id-rsa-minecrft minecrft@localhost \
      'screen -X -r minecraft register 1 "stop\n"' 2>/dev/null
    ssh -i id-rsa-minecrft minecrft@localhost \
      'screen -X -r minecraft paste 1' 2>/dev/null
    sleep 5
    if ssh -i id-rsa-minecrft minecrft@localhost \
       'screen -ls' 2>/dev/null |
       egrep '[0-9] [sS]ocket' >/dev/null
    then
        echo "still running."
        exit 1
    fi
    echo "stopped."
    exit 0
    ;;
connect)
    # Connect to the running minecraft server.
    # Use ^A^D to get out.
    ssh -t -i id-rsa-minecrft minecrft@localhost 'screen -r minecraft'
    ;;
esac
