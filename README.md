# petalinux-docker

This branch help you to create a docker image with petalinux and DNNDKv3.1.

## Pre-request
- If you intend to build this image under windows, running this repo under WSL env is recommended.
- Install docker. Official tutorial: ([win](https://docs.docker.com/desktop/windows/install/)/[Linux](https://docs.docker.com/desktop/linux/install/))
- Download Installers
  - Petalinux [v2019.2](https://www.xilinx.com/member/forms/download/xef.html?filename=petalinux-v2019.2-final-installer.run) 
  - DNNDKv3.1 [Link](https://www.xilinx.com/member/forms/download/xef.html?filename=xilinx_dnndk_v3.1_190809.tar.gz)
- Modify the ```UBUNTU_MIRROR``` in [build_docker.sh](./build_docker.sh) according to your location
   ```
  ### build_docker.sh ###
  
  docker build \
    --build-arg PETA_VERSION=2019.2 \ # Petalinux version
    --build-arg PETA_RUN_FILE=petalinux-v2019.2-final-installer.run \ # Petalinux installer
    --build-arg UBUNTU_MIRROR=free.nchc.org.tw \  # Ubuntu APT Source URL 
    -t petalinux_DNNDK:2019.2_3.1 .  # Your Image name

   ```
## Building Image
Copy petalinux-v2019.2-final-installer.run and xilinx_dnndk_v3.1_190809.tar.gz. Then run  
`chmod +x ./build_docker.sh && ./build_docker.sh`i
<!--or 
`docker build --build-arg PETA_VERSION=2019.2 --build-arg PETA_RUN_FILE=petalinux-v2019.2-final-installer.run --build-arg UBUNTU_MIRROR=free.nchc.org.tw -t petalinux_DNNDK:2019.2_3.1 .`-->


After installation, launch petalinux with:  
`chmod +x ./run_docker.sh && ./run_docker.sh`
<!--or
`docker run -ti -e DISPLAY=$DISPLAY -p 8888:8888 -p 5000:5000 -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:/home/xilinx/.Xauthority -v $HOME/Projects:/home/xilinx/project --name petalinux_DNNDK petalinux_DNNDK:2019.2_3.1 jupyter-lab`-->
