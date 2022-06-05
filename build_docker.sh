#!/bin/bash

docker build \
    --build-arg PETA_VERSION=2019.2 \
    --build-arg PETA_RUN_FILE=petalinux-v2019.2-final-installer.run \
    --build-arg UBUNTU_MIRROR=free.nchc.org.tw \
    -t petalinux_DNNDK:2019.2_3.1 .
