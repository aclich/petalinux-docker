FROM ubuntu:18.04

# build with "docker build --build-arg PETA_VERSION=2020.2 --build-arg PETA_RUN_FILE=petalinux-v2020.2-final-installer.run -t petalinux:2020.2 ."

# install dependences:

ARG UBUNTU_MIRROR
RUN [ -z "${UBUNTU_MIRROR}" ] || sed -i.bak s/archive.ubuntu.com/${UBUNTU_MIRROR}/g /etc/apt/sources.list 

RUN apt-get update &&  DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
  build-essential \
  sudo \
  tofrodos \
  iproute2 \
  gawk \
  net-tools \
  expect \
  libncurses5-dev \
  tftpd \
  update-inetd \
  libssl-dev \
  flex \
  bison \
  libselinux1 \
  gnupg \
  wget \
  socat \
  gcc-multilib \
  libidn11 \
  libsdl1.2-dev \
  libglib2.0-dev \
  lib32z1-dev \
  libgtk2.0-0 \
  libtinfo5 \
  xxd \
  screen \
  pax \
  diffstat \
  xvfb \
  xterm \
  texinfo \
  gzip \
  unzip \
  cpio \
  chrpath \
  autoconf \
  lsb-release \
  libtool \
  libtool-bin \
  locales \
  kmod \
  git \
  rsync \
  bc \
  u-boot-tools \
  python \
  python3-pip \
  vim \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN dpkg --add-architecture i386 &&  apt-get update &&  \
      DEBIAN_FRONTEND=noninteractive apt-get install -y -q \
      zlib1g:i386 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --upgrade pip wheel -y && pip3 install bpytop gdown -y

# ARG PETA_VERSION
ARG PETA_RUN_FILE

RUN gdown 

RUN locale-gen en_US.UTF-8 && update-locale

#make a xilinx user
RUN adduser --disabled-password --gecos '' xilinx && \
  usermod -aG sudo xilinx && \
  echo "xilinx ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY accept-eula.sh ${PETA_RUN_FILE} ${DNNDK_PACKAGE} /

# run the install
RUN chmod a+rx /${PETA_RUN_FILE} && \
  chmod a+rx /accept-eula.sh && \
  mkdir -p /opt/Xilinx && \
  chmod 777 /tmp /opt/Xilinx && \
  cd /tmp && \
  sudo -u xilinx -i /accept-eula.sh /${PETA_RUN_FILE} /opt/Xilinx/petalinux && \
  rm -f /${PETA_RUN_FILE} /accept-eula.sh

#install DNNDK_v3.1
RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    graphviz \
    python-dev \
    python-flask \
    python-flaskext.wtf \
    python-gevent \
    python-h5py \
    python-numpy \
    python-pil \
    python-scipy \
    python-tk \
    python-all-dev \
    python-matplotlib \
    python-opencv \
    python-pydot \
    python-skimage \
    python-sklearn \
    libatlas-base-dev \
    build-essential \
    cmake \
    gfortran \
    libboost-filesystem-dev \
    libboost-python-dev \ 
    libboost-system-dev \
    libboost-thread-dev \
    libboost-regex1.65.1 \
    libboost-python1.65.1 \
    libopenblas-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    libhdf5-serial-dev \
    libleveldb-dev \
    liblmdb-dev \
    libopencv-dev \
    libsnappy-dev \
    libboost-all-dev \
    libprotobuf-dev \
    protobuf-compiler \
    libturbojpeg \
    tree 

RUN gdown "https://drive.google.com/u/0/uc?id=19D2UjDTjo0_yUr1cBuCm_kGuazUAczY-"
RUN pip3 install -y \
    progressbar \
    opencv-python \
    scikit-learn \
    scikit-image \
    scipy \
    testresources \
    jupyterlab \
    imutils \
    keras==2.2.4 && \
    tar -xzvf "xilinx_dnndk_v3.1_190809.tar.gz"
RUN pip3 install ./xilinx_dnndk_v3.1/host_x86/decent-tf/ubuntu18.04/tensorflow-1.12.0-cp36-cp36m-linux_x86_64.whl && \
    cd ./dnndkv3.1/host_x86 && chmod +x ./install.sh && ./install.sh
RUN jupyterlab

# make /bin/sh symlink to bash instead of dash:
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

USER xilinx
ENV HOME /home/xilinx
ENV LANG en_US.UTF-8
RUN mkdir /home/xilinx/project
RUN sudo chmod -R 777 /home/xilinx -v
WORKDIR /home/xilinx/project


#add xilinx tools to path
# RUN echo "PATH=$PATH:/home/xilinx/.local/bin" >> /home/xilinx/.bashrc
RUN echo "source /opt/Xilinx/petalinux/settings.sh" >> /home/xilinx/.bashrc

