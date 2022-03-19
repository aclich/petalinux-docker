#!/bin/bash
docker run \
    -ti \
    -e DISPLAY=$DISPLAY \
    --net="host" \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.Xauthority:/home/xilinx/.Xauthority \
    -v $HOME/Projects:/home/xilinx/project \
    petalinux:2019.2 /bin/bash