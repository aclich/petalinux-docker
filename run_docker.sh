#!/bin/bash
docker run \
    -ti \
    -e DISPLAY=$DISPLAY \
    -p 8888:8888 \
    -p 5000:5000 \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $HOME/.Xauthority:/home/xilinx/.Xauthority \
    -v $HOME/Projects:/home/xilinx/project \
    --name petalinux2019.2_DNNDKv3.1 \
    petalinux:2019.2 jupyter-lab