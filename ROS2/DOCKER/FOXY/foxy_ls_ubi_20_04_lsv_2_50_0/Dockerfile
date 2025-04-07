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
    && rm -rf /var/lib/apt/lists/*

# Shows a list of connected Realsense devices
CMD [ "rs-enumerate-devices", "--compact" ]

WORKDIR /foxy/t265_l515_v4_0_4_ws
#RUN /bin/bash /ros_entrypoint.sh

RUN cd /foxy/t265_l515_v4_0_4_ws

#RUN /bin/bash foxy/t265_l515_v4_0_4_ws/install/local_setup.bash
#RUN /bin/bash -c 'source install/setup.bash'

#RUN /bin/bash -source /foxy/t265_l515_v4_0_4_ws/install/setup.bash


ENV CYCLONEDDS_URI=/.ros/cyclonedds_foxy.xml


