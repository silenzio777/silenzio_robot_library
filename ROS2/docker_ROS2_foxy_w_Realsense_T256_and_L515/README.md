
## Docker container for ROS2 foxy with Realsense T256 and L515 cameras

1. Pull Dockerfile:

```
docker pull dustynv/ros:foxy-ros-core-l4t-r35.4.1
```

2. Create Dockerfile:
```
ARG BASE_IMAGE=ubuntu:20.04 #18.04 #2.51.1 with 20.04 <<-- work but with warnings
# LIBRS_VERSION=2.47.0 with 20.04 <<-- work OK
#################################
#   Librealsense Builder Stage  #
#################################
FROM $BASE_IMAGE as librealsense-builder

ARG LIBRS_VERSION
# Make sure that we have a version number of librealsense as argument
RUN test -n "$LIBRS_VERSION"

# To avoid waiting for input during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Builder dependencies installation
RUN apt-get update \
    && apt-get install -qq -y --no-install-recommends \
    build-essential \
    cmake \
    git \
    libssl-dev \
    libusb-1.0-0-dev \
    pkg-config \
    libgtk-3-dev \
    libglfw3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \    
    curl \
    python3 \
    python3-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download sources
WORKDIR /usr/src
RUN curl https://codeload.github.com/IntelRealSense/librealsense/tar.gz/refs/tags/v$LIBRS_VERSION -o librealsense.tar.gz 
RUN tar -zxf librealsense.tar.gz \
    && rm librealsense.tar.gz 
RUN ln -s /usr/src/librealsense-$LIBRS_VERSION /usr/src/librealsense

# Build and install
RUN cd /usr/src/librealsense \
    && mkdir build && cd build \
    && cmake \
    -DCMAKE_C_FLAGS_RELEASE="${CMAKE_C_FLAGS_RELEASE} -s" \
    -DCMAKE_CXX_FLAGS_RELEASE="${CMAKE_CXX_FLAGS_RELEASE} -s" \
    -DCMAKE_INSTALL_PREFIX=/opt/librealsense \
    -DBUILD_GRAPHICAL_EXAMPLES=OFF \
    -DBUILD_PYTHON_BINDINGS:bool=true \
    -DFORCE_RSUSB_BACKEND=true \
    -DCMAKE_BUILD_TYPE=Release ../ \
    && make -j$(($(nproc)-1)) all \
    && make install 
```

Build:
```
docker build -t ls_2_50_0 --build-arg LIBRS_VERSION=2.50.0 .
```

3.

Create Dockerfile:
```
ARG BASE_IMAGE=ls_2_50_0 #ls_ubi_20_04_lsv_2_48_0 #ubuntu:20.04 #18.04 #2.51.1 with 20.04 <<-- work but with warnings
# LIBRS_VERSION=#2.47.0 with 20.04 <<-- work OK
#################################
#   Librealsense Builder Stage  #
#################################
FROM $BASE_IMAGE as librealsense-builder

######################################
#   librealsense Base Image Stage    #
######################################
#FROM ${BASE_IMAGE} as librealsense
FROM dustynv/ros:foxy-ros-core-l4t-r35.4.1 as librealsense
                 
# Copy binaries from builder stage
COPY --from=librealsense-builder /opt/librealsense /usr/local/
COPY --from=librealsense-builder /usr/lib/python3/dist-packages/pyrealsense2 /usr/lib/python3/dist-packages/pyrealsense2
COPY --from=librealsense-builder /usr/src/librealsense/config/99-realsense-libusb.rules /etc/udev/rules.d/
COPY 99-realsense-d4xx-mipi-dfu.rules /etc/udev/rules.d/
ENV PYTHONPATH=$PYTHONPATH:/usr/local/lib

# Install dep packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \ 
    libusb-1.0-0 \
    udev \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*; exit 0

# Shows a list of connected Realsense devices
# CMD [ "rs-enumerate-devices", "--compact" ]

WORKDIR /foxy/t265_l515_v4_0_4_ws

RUN cd /foxy/t265_l515_v4_0_4_ws

ENV CYCLONEDDS_URI=/.ros/cyclonedds_foxy.xml
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
RUN echo ". install/local_setup.bash" >> ~/.bashrc
```

Build:
```
docker build -t foxy_ls_ubi_20_04_lsv_2_50_0 .
```
______________
```
docker images
```
REPOSITORY                        TAG                         IMAGE ID       CREATED          SIZE
foxy_ls_ubi_20_04_lsv_2_50_0      latest                      399a0e440cfa   11 minutes ago   11.2GB
ls_2_50_0                         latest                      b88d5b292b3f   48 minutes ago   2.1GB
dustynv/ros                       foxy-ros-core-l4t-r35.4.1   1671f9250223   18 months ago    11.1GB
```
