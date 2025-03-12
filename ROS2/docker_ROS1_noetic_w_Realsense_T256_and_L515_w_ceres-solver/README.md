
### Work on Ubuntu 22.04:

- Jetson NX 
- Ubuntu PC  

--------

### Create dockerfile:
```
cd ~/lib
mkdir -p docker_installs/R1_NV_RS_SSL_SLAM_CERES_CUDA
cd docker_installs/R1_NV_RS_SSL_SLAM_CERES_CUDA
nano Dockerfile
```

```
#FROM arm64v8/ros:noetic-robot-focal AS r1_nv_rs_ssl_slam_ceres_cuda
FROM dustynv/ros:noetic-desktop-l4t-r35.4.1 AS r1_nv_rs_ssl_slam_ceres_cuda

#- Found CUDA version 11.4.315 installed in: /usr/local/cuda
#16 3.400 -- The CUDA compiler identification is NVIDIA 11.4.315
#16 3.421 -- Detecting CUDA compiler ABI info
#16 10.86 -- Detecting CUDA compiler ABI info - done
#16 11.01 -- Check for working CUDA compiler: /usr/local/cuda/bin/nvcc - skipped
#16 11.01 -- Detecting CUDA compile features
#16 11.01 -- Detecting CUDA compile features - done
#16 11.02 -- Setting CUDA Architecture to 50;60;70;80
# ...
# CMake Warning:
#16 15.65   Manually-specified variables were not used by the project:
#16 15.65 
#16 15.65     CERES_USE_CUDA
#16 15.65     CUDA_ARCH_BIN
#16 15.65     CUDA_ARCH_PTX
#16 15.65     CUDA_TOOLKIT_ROOT_DIR

# To avoid waiting for input during package installation
ENV DEBIAN_FRONTEND=noninteractive

#################################
## BASE
#################################

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
    software-properties-common \
    wget \
    unzip 
    #&& rm -rf /var/lib/apt/lists/*

#   libopencv-dev -y
#   libopencv-dev \
#   -t=4.2.0 libopencv-dev
#   libopencv-dev=2.4.9.1+dfsg-1.5ubuntu1

#################################
## ceres-solver
#################################
## http://ceres-solver.org/installation.html

RUN add-apt-repository universe

# Install GTSAM & PCL
RUN add-apt-repository ppa:borglab/gtsam-release-4.0 -y
RUN apt-get update -y
RUN apt-get install -qq -y --no-install-recommends libgtsam-dev libgtsam-unstable-dev libpcl-dev

# g2o dependencies
RUN apt install -y libatlas-base-dev libsuitesparse-dev
# OpenCV dependencies
# RUN apt install -y libgtk-3-dev ffmpeg libavcodec-dev libavformat-dev libavutil-dev libswscale-dev libavresample-dev libtbb-dev
# eigen dependencies
RUN apt install -y gfortran libgflags2.2 libgflags-dev libgoogle-glog-dev

RUN cd /tmp && \
    wget -q https://gitlab.com/libeigen/eigen/-/archive/3.3.7/eigen-3.3.7.tar.bz2 && \
    tar xf eigen-3.3.7.tar.bz2 && rm -rf eigen-3.3.7.tar.bz2 && \
    cd eigen-3.3.7 && \
    mkdir build && \
    cd build && \
    cmake ../ -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr/local && \
    make -j7 && make install

WORKDIR /opt

RUN git clone https://ceres-solver.googlesource.com/ceres-solver --branch 2.2.0 --depth=1

WORKDIR /opt/ceres-solver/build

RUN cmake .. -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=ON \
    -DCERES_USE_CUDA=ON \
    -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
    -DCMAKE_CUDA_COMPILER=/usr/local/cuda/bin/nvcc \
    -DCUDA_ARCH_BIN="native" \    
    -DCMAKE_CUDA_ARCHITECTURES="native" \    
    -DCUDA_ARCH_PTX="" && \
    make -j7 && \
    make install
    

#################################
## ROS1 noetic
#################################

RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -

RUN apt-get install -qq -y --no-install-recommends libgoogle-glog-dev libgflags-dev libeigen3-dev \ 
    libboost-all-dev libboost-dev libpython2.7-dev 

RUN apt-get update 
RUN apt-get install -qq -y --no-install-recommends \
    pcl-tools \
    ros-noetic-rviz \
    ros-noetic-rqt \
    #ros-noetic-rqt-common-plugins \
    #ros-noetic-rqt-robot-plugins \
    #ros-noetic-rviz-visual-tools \
    ros-noetic-hls-lfcd-lds-driver \
    ros-noetic-hector-trajectory-server \
    ros-noetic-octomap* \
    ros-noetic-eigen-conversions \
    && apt clean

#apt install ros-noetic-diagnostic-msgs
#apt install ros-noetic-common-msgs
#apt install ros-noetic-ddynamic-reconfigure \
#apt install ros-noetic-geometry   



#################################
## realsense
#################################

## From apt:
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key F6E65AC044F831AC80A06380C8B3A55A6F3EFCDE
#RUN add-apt-repository "deb https://librealsense.intel.com/Debian/apt-repo $(lsb_release -cs) main" -u
#RUN apt-get install librealsense2-utils librealsense2-dev -y 

## From source:

ARG LIBRS_VERSION
# Make sure that wen have a version number of librealsense as argument
RUN test -n "$LIBRS_VERSION"

# Download sources
WORKDIR /usr/src
RUN curl https://codeload.github.com/IntelRealSense/librealsense/tar.gz/refs/tags/v$LIBRS_VERSION -o librealsense.tar.gz 
RUN tar -zxf librealsense.tar.gz \
    && rm librealsense.tar.gz 
RUN ln -s /usr/src/librealsense-$LIBRS_VERSION /usr/src/librealsense

RUN apt-get install libudev-dev -y 

# Build and install
RUN cd /usr/src/librealsense \
    && mkdir build && cd build \
    && cmake ../ \
    -DCMAKE_C_FLAGS_RELEASE="${CMAKE_C_FLAGS_RELEASE} -s" \
    -DCMAKE_CXX_FLAGS_RELEASE="${CMAKE_CXX_FLAGS_RELEASE} -s" \
    -DCMAKE_INSTALL_PREFIX=/opt/librealsense \
    -DBUILD_GRAPHICAL_EXAMPLES=OFF \
    -DBUILD_PYTHON_BINDINGS:bool=false \
    -DFORCE_RSUSB_BACKEND=true \
    #-DFORCE_RSUSB_BACKEND=false \
    -DCMAKE_BUILD_TYPE=Release \
    #-DBUILD_WITH_CUDA=true \
    -DPYTHON_EXECUTABLE=/usr/bin/python3 \
    && make -j$(($(nproc)-1)) all \
    && make install 

# cmake ../ -DFORCE_RSUSB_BACKEND=ON -DBUILD_PYTHON_BINDINGS:bool=true -DPYTHON_EXECUTABLE=/usr/bin/python3 
# -DCMAKE_BUILD_TYPE=release -DBUILD_EXAMPLES=true -DBUILD_GRAPHICAL_EXAMPLES=true -DBUILD_WITH_CUDA:bool=true 

#COPY /opt/librealsense /usr/local/
#COPY /usr/lib/python3/dist-packages/pyrealsense2 /usr/lib/python3/dist-packages/pyrealsense2
#COPY /usr/src/librealsense/config/99-realsense-libusb.rules /etc/udev/rules.d/

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py 
RUN python3 get-pip.py 

RUN apt install -y iputils-ping
RUN apt install -y ros-noetic-rqt-common-plugins; exit 0

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["/bin/bash"]

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/librealsense/lib
ENV PATH=$PATH:/opt/librealsense/bin

WORKDIR /catkin_ws
```

### Build docker container
```
docker build --network=host --build-arg NVIDIA_DRIVER_CAPABILITIES=compute,utility -t r1_nv_rs_ssl_slam_ceres_cuda --target r1_nv_rs_ssl_slam_ceres_cuda --build-arg LIBRS_VERSION=2.48.0 --progress=plain . 
```
--------

### RUN on Jetson NX:
```
docker run -it --net=host --privileged --env="DISPLAY=$DISPLAY" --volume="${XAUTHORITY}:/root/.Xauthority" --rm -v /dev:/dev --device-cgroup-rule "c 81:* rmw" --device-cgroup-rule "c 189:* rmw" -v ~/_dataset:/_dataset -v ~/catkin_ws:/catkin_ws r1_nv_rs_ssl_slam_ceres_cuda bash
```

### RUN inside Jetson NX docker container:
```
#INSIDE DOCKER:

export ROS_MASTER_URI=http://192.168.X.XX:11311 <<< use Jetson NX ip
export ROS_IP=192.168.X.XX  <<< use Jetson NX ip

source ./devel/setup.bash
#SSL_SLAM2:
roslaunch ssl_slam2 ssl_slam2_mapping.launch
roslaunch ssl_slam2 ssl_slam2_large_mapping.launch
roslaunch ssl_slam2 ssl_slam2_localization.launch

#SSL_SLAM:
roslaunch ssl_slam ssl_slam_L515.launch
roslaunch ssl_slam ssl_slam_L515_octo_mapping.launch

roslaunch realsense2_camera demo_t265.launch

```
--------

### RUN on Ubuntu PC:
```
docker run -it --net=host --privileged --env="DISPLAY=$DISPLAY" --volume="${XAUTHORITY}:/root/.Xauthority" --rm -v /dev:/dev --device-cgroup-rule "c 81:* rmw" --device-cgroup-rule "c 189:* rmw" -v ~/_dataset:/_dataset -v ~/catkin_ws:/catkin_ws r1_nv_rs_ssl_slam_ceres_cuda bash
```

### RUN inside Ubuntu PC docker container:
```
#INSIDE DOCKER:

export ROS_MASTER_URI=http://192.168.X.XX:11311  <<< use Jetson NX ip

source ./devel/setup.bash
#SSL_SLAM2:
roslaunch ssl_slam2 ssl_slam2_mapping.launch
roslaunch ssl_slam2 ssl_slam2_large_mapping.launch
roslaunch ssl_slam2 ssl_slam2_localization.launch

#SSL_SLAM:
roslaunch ssl_slam ssl_slam_L515.launch
roslaunch ssl_slam ssl_slam_L515_octo_mapping.launch

roslaunch realsense2_camera demo_t265.launch

```
--------

### Test driver version:
```
root@jetsonnx:/catkin_ws# rs-fw-update --version

rs-fw-update  version: 2.48.0
```

### Test cameras:
- L515
```
root@jetsonnx:/catkin_ws# rs-enumerate-devices
Device info: 
    Name                          : 	Intel RealSense L515
    Serial Number                 : 	f0211758
    Firmware Version              : 	01.05.08.01
    Recommended Firmware Version  : 	01.05.08.01
    Physical Port                 : 	2-1.1-8
    Debug Op Code                 : 	15
    Product Id                    : 	0B64
    Camera Locked                 : 	YES
    Usb Type Descriptor           : 	3.2
    Product Line                  : 	L500
    Asic Serial Number            : 	0003aa95b255
    Firmware Update Id            : 	0003aa95b255

Stream Profiles supported by L500 Depth Sensor
 Supported modes:
    stream       resolution      fps       format   
    Confidence	  1024x768	@ 30Hz	   RAW8
    Confidence	  640x480	@ 30Hz	   RAW8
    Confidence	  320x240	@ 30Hz	   RAW8
    Infrared	  1024x768	@ 30Hz	   Y8
    Infrared	  640x480	@ 30Hz	   Y8
    Infrared	  320x240	@ 30Hz	   Y8
    Depth	  1024x768	@ 30Hz	   Z16
    Depth	  640x480	@ 30Hz	   Z16
    Depth	  320x240	@ 30Hz	   Z16

Stream Profiles supported by RGB Camera
 Supported modes:
    stream       resolution      fps       format   
    Color	  1920x1080	@ 30Hz	   RGB8
    Color	  1920x1080	@ 30Hz	   Y16
    Color	  1920x1080	@ 30Hz	   BGRA8
    Color	  1920x1080	@ 30Hz	   RGBA8
    Color	  1920x1080	@ 30Hz	   BGR8
    Color	  1920x1080	@ 30Hz	   YUYV
    Color	  1920x1080	@ 15Hz	   RGB8
    Color	  1920x1080	@ 15Hz	   Y16
    Color	  1920x1080	@ 15Hz	   BGRA8
    Color	  1920x1080	@ 15Hz	   RGBA8
    Color	  1920x1080	@ 15Hz	   BGR8
    Color	  1920x1080	@ 15Hz	   YUYV
    Color	  1920x1080	@ 6Hz	   RGB8
    Color	  1920x1080	@ 6Hz	   Y16
    Color	  1920x1080	@ 6Hz	   BGRA8
    Color	  1920x1080	@ 6Hz	   RGBA8
    Color	  1920x1080	@ 6Hz	   BGR8
    Color	  1920x1080	@ 6Hz	   YUYV
    Color	  1280x720	@ 60Hz	   RGB8
    Color	  1280x720	@ 60Hz	   Y16
    Color	  1280x720	@ 60Hz	   BGRA8
    Color	  1280x720	@ 60Hz	   RGBA8
    Color	  1280x720	@ 60Hz	   BGR8
    Color	  1280x720	@ 60Hz	   YUYV
    Color	  1280x720	@ 30Hz	   RGB8
    Color	  1280x720	@ 30Hz	   Y16
    Color	  1280x720	@ 30Hz	   BGRA8
    Color	  1280x720	@ 30Hz	   RGBA8
    Color	  1280x720	@ 30Hz	   BGR8
    Color	  1280x720	@ 30Hz	   YUYV
    Color	  1280x720	@ 15Hz	   RGB8
    Color	  1280x720	@ 15Hz	   Y16
    Color	  1280x720	@ 15Hz	   BGRA8
    Color	  1280x720	@ 15Hz	   RGBA8
    Color	  1280x720	@ 15Hz	   BGR8
    Color	  1280x720	@ 15Hz	   YUYV
    Color	  1280x720	@ 6Hz	   RGB8
    Color	  1280x720	@ 6Hz	   Y16
    Color	  1280x720	@ 6Hz	   BGRA8
    Color	  1280x720	@ 6Hz	   RGBA8
    Color	  1280x720	@ 6Hz	   BGR8
    Color	  1280x720	@ 6Hz	   YUYV
    Color	  960x540	@ 60Hz	   RGB8
    Color	  960x540	@ 60Hz	   Y16
    Color	  960x540	@ 60Hz	   BGRA8
    Color	  960x540	@ 60Hz	   RGBA8
    Color	  960x540	@ 60Hz	   BGR8
    Color	  960x540	@ 60Hz	   YUYV
    Color	  960x540	@ 30Hz	   RGB8
    Color	  960x540	@ 30Hz	   Y16
    Color	  960x540	@ 30Hz	   BGRA8
    Color	  960x540	@ 30Hz	   RGBA8
    Color	  960x540	@ 30Hz	   BGR8
    Color	  960x540	@ 30Hz	   YUYV
    Color	  960x540	@ 15Hz	   RGB8
    Color	  960x540	@ 15Hz	   Y16
    Color	  960x540	@ 15Hz	   BGRA8
    Color	  960x540	@ 15Hz	   RGBA8
    Color	  960x540	@ 15Hz	   BGR8
    Color	  960x540	@ 15Hz	   YUYV
    Color	  960x540	@ 6Hz	   RGB8
    Color	  960x540	@ 6Hz	   Y16
    Color	  960x540	@ 6Hz	   BGRA8
    Color	  960x540	@ 6Hz	   RGBA8
    Color	  960x540	@ 6Hz	   BGR8
    Color	  960x540	@ 6Hz	   YUYV
    Color	  640x480	@ 60Hz	   RGB8
    Color	  640x480	@ 60Hz	   Y16
    Color	  640x480	@ 60Hz	   BGRA8
    Color	  640x480	@ 60Hz	   RGBA8
    Color	  640x480	@ 60Hz	   BGR8
    Color	  640x480	@ 60Hz	   YUYV
    Color	  640x480	@ 30Hz	   RGB8
    Color	  640x480	@ 30Hz	   Y16
    Color	  640x480	@ 30Hz	   BGRA8
    Color	  640x480	@ 30Hz	   RGBA8
    Color	  640x480	@ 30Hz	   BGR8
    Color	  640x480	@ 30Hz	   YUYV
    Color	  640x480	@ 15Hz	   RGB8
    Color	  640x480	@ 15Hz	   Y16
    Color	  640x480	@ 15Hz	   BGRA8
    Color	  640x480	@ 15Hz	   RGBA8
    Color	  640x480	@ 15Hz	   BGR8
    Color	  640x480	@ 15Hz	   YUYV
    Color	  640x480	@ 6Hz	   RGB8
    Color	  640x480	@ 6Hz	   Y16
    Color	  640x480	@ 6Hz	   BGRA8
    Color	  640x480	@ 6Hz	   RGBA8
    Color	  640x480	@ 6Hz	   BGR8
    Color	  640x480	@ 6Hz	   YUYV
    Color	  640x360	@ 60Hz	   RGB8
    Color	  640x360	@ 60Hz	   Y16
    Color	  640x360	@ 60Hz	   BGRA8
    Color	  640x360	@ 60Hz	   RGBA8
    Color	  640x360	@ 60Hz	   BGR8
    Color	  640x360	@ 60Hz	   YUYV
    Color	  640x360	@ 30Hz	   RGB8
    Color	  640x360	@ 30Hz	   Y16
    Color	  640x360	@ 30Hz	   BGRA8
    Color	  640x360	@ 30Hz	   RGBA8
    Color	  640x360	@ 30Hz	   BGR8
    Color	  640x360	@ 30Hz	   YUYV
    Color	  640x360	@ 15Hz	   RGB8
    Color	  640x360	@ 15Hz	   Y16
    Color	  640x360	@ 15Hz	   BGRA8
    Color	  640x360	@ 15Hz	   RGBA8
    Color	  640x360	@ 15Hz	   BGR8
    Color	  640x360	@ 15Hz	   YUYV
    Color	  640x360	@ 6Hz	   RGB8
    Color	  640x360	@ 6Hz	   Y16
    Color	  640x360	@ 6Hz	   BGRA8
    Color	  640x360	@ 6Hz	   RGBA8
    Color	  640x360	@ 6Hz	   BGR8
    Color	  640x360	@ 6Hz	   YUYV

Stream Profiles supported by Motion Module
 Supported modes:
    stream       resolution      fps       format   
    Accel	 N/A		@ 400Hz	   MOTION_XYZ32F
    Accel	 N/A		@ 200Hz	   MOTION_XYZ32F
    Accel	 N/A		@ 100Hz	   MOTION_XYZ32F
    Gyro	 N/A		@ 400Hz	   MOTION_XYZ32F
    Gyro	 N/A		@ 200Hz	   MOTION_XYZ32F
    Gyro	 N/A		@ 100Hz	   MOTION_XYZ32F
```
- T265
```
Device info: 
    Name                          : 	Intel RealSense T265
    Serial Number                 : 	905312111138
    Firmware Version              : 	0.2.0.951
    Physical Port                 : 	2-1.2-9
    Product Id                    : 	0B37
    Usb Type Descriptor           : 	3.1
    Product Line                  : 	T200

Stream Profiles supported by Tracking Module
 Supported modes:
    stream       resolution      fps       format   
    Fisheye 1	  848x800	@ 30Hz	   Y8
    Fisheye 2	  848x800	@ 30Hz	   Y8
    Gyro	 N/A		@ 200Hz	   MOTION_XYZ32F
    Accel	 N/A		@ 62Hz	   MOTION_XYZ32F
    Pose	 N/A		@ 200Hz	   6DOF
```
-----

### Packages for build:
```
silenzio@jetsonnx:~/catkin_ws/src$ ls

realsense-ros-2.3.1
vision_opencv
diagnostics
omni
ssl_slam
ssl_slam2
ssl_slam3
common_msgs
geometry
ddynamic_reconfigure
install_rep.sh
CMakeLists.txt
```


### Test launch:
```
root@jetsonnx:/catkin_ws# roslaunch realsense2_camera demo_t265.launch
... logging to /root/.ros/log/2f593092-ff6e-11ef-bcd6-488f4cfd08c6/roslaunch-jetsonnx-54.log
Checking log directory for disk usage. This may take a while.
Press Ctrl-C to interrupt
Done checking log file disk usage. Usage is <1GB.

started roslaunch server http://192.168.X.XX:46343/

SUMMARY
========

PARAMETERS
 * /camera/realsense2_camera/accel_fps: -1
 * /camera/realsense2_camera/accel_frame_id: camera_accel_frame
 * /camera/realsense2_camera/accel_optical_frame_id: camera_accel_opti...
 * /camera/realsense2_camera/align_depth: False
 * /camera/realsense2_camera/aligned_depth_to_color_frame_id: camera_aligned_de...
 * /camera/realsense2_camera/aligned_depth_to_fisheye1_frame_id: camera_aligned_de...
 * /camera/realsense2_camera/aligned_depth_to_fisheye2_frame_id: camera_aligned_de...
 * /camera/realsense2_camera/aligned_depth_to_fisheye_frame_id: camera_aligned_de...
 * /camera/realsense2_camera/aligned_depth_to_infra1_frame_id: camera_aligned_de...
 * /camera/realsense2_camera/aligned_depth_to_infra2_frame_id: camera_aligned_de...
 * /camera/realsense2_camera/allow_no_texture_points: False
 * /camera/realsense2_camera/base_frame_id: camera_link
 * /camera/realsense2_camera/calib_odom_file: 
 * /camera/realsense2_camera/clip_distance: -1.0
 * /camera/realsense2_camera/color_fps: 30
 * /camera/realsense2_camera/color_frame_id: camera_color_frame
 * /camera/realsense2_camera/color_height: 480
 * /camera/realsense2_camera/color_optical_frame_id: camera_color_opti...
 * /camera/realsense2_camera/color_width: 640
 * /camera/realsense2_camera/confidence_fps: 30
 * /camera/realsense2_camera/confidence_height: 480
 * /camera/realsense2_camera/confidence_width: 640
 * /camera/realsense2_camera/depth_fps: 30
 * /camera/realsense2_camera/depth_frame_id: camera_depth_frame
 * /camera/realsense2_camera/depth_height: 480
 * /camera/realsense2_camera/depth_optical_frame_id: camera_depth_opti...
 * /camera/realsense2_camera/depth_width: 640
 * /camera/realsense2_camera/device_type: t265
 * /camera/realsense2_camera/enable_accel: True
 * /camera/realsense2_camera/enable_color: True
 * /camera/realsense2_camera/enable_confidence: True
 * /camera/realsense2_camera/enable_depth: True
 * /camera/realsense2_camera/enable_fisheye1: False
 * /camera/realsense2_camera/enable_fisheye2: False
 * /camera/realsense2_camera/enable_fisheye: False
 * /camera/realsense2_camera/enable_gyro: True
 * /camera/realsense2_camera/enable_infra1: False
 * /camera/realsense2_camera/enable_infra2: False
 * /camera/realsense2_camera/enable_infra: False
 * /camera/realsense2_camera/enable_pointcloud: False
 * /camera/realsense2_camera/enable_pose: True
 * /camera/realsense2_camera/enable_sync: False
 * /camera/realsense2_camera/filters: 
 * /camera/realsense2_camera/fisheye1_frame_id: camera_fisheye1_f...
 * /camera/realsense2_camera/fisheye1_optical_frame_id: camera_fisheye1_o...
 * /camera/realsense2_camera/fisheye2_frame_id: camera_fisheye2_f...
 * /camera/realsense2_camera/fisheye2_optical_frame_id: camera_fisheye2_o...
 * /camera/realsense2_camera/fisheye_fps: -1
 * /camera/realsense2_camera/fisheye_frame_id: camera_fisheye_frame
 * /camera/realsense2_camera/fisheye_height: -1
 * /camera/realsense2_camera/fisheye_optical_frame_id: camera_fisheye_op...
 * /camera/realsense2_camera/fisheye_width: -1
 * /camera/realsense2_camera/gyro_fps: -1
 * /camera/realsense2_camera/gyro_frame_id: camera_gyro_frame
 * /camera/realsense2_camera/gyro_optical_frame_id: camera_gyro_optic...
 * /camera/realsense2_camera/imu_optical_frame_id: camera_imu_optica...
 * /camera/realsense2_camera/infra1_frame_id: camera_infra1_frame
 * /camera/realsense2_camera/infra1_optical_frame_id: camera_infra1_opt...
 * /camera/realsense2_camera/infra2_frame_id: camera_infra2_frame
 * /camera/realsense2_camera/infra2_optical_frame_id: camera_infra2_opt...
 * /camera/realsense2_camera/infra_fps: 30
 * /camera/realsense2_camera/infra_height: 480
 * /camera/realsense2_camera/infra_rgb: False
 * /camera/realsense2_camera/infra_width: 640
 * /camera/realsense2_camera/initial_reset: False
 * /camera/realsense2_camera/json_file_path: 
 * /camera/realsense2_camera/linear_accel_cov: 0.01
 * /camera/realsense2_camera/odom_frame_id: camera_odom_frame
 * /camera/realsense2_camera/ordered_pc: False
 * /camera/realsense2_camera/pointcloud_texture_index: 0
 * /camera/realsense2_camera/pointcloud_texture_stream: RS2_STREAM_COLOR
 * /camera/realsense2_camera/pose_frame_id: camera_pose_frame
 * /camera/realsense2_camera/pose_optical_frame_id: camera_pose_optic...
 * /camera/realsense2_camera/publish_odom_tf: True
 * /camera/realsense2_camera/publish_tf: True
 * /camera/realsense2_camera/rosbag_filename: 
 * /camera/realsense2_camera/serial_no: 
 * /camera/realsense2_camera/stereo_module/exposure/1: 7500
 * /camera/realsense2_camera/stereo_module/exposure/2: 1
 * /camera/realsense2_camera/stereo_module/gain/1: 16
 * /camera/realsense2_camera/stereo_module/gain/2: 16
 * /camera/realsense2_camera/tf_publish_rate: 0.0
 * /camera/realsense2_camera/topic_odom_in: camera/odom_in
 * /camera/realsense2_camera/unite_imu_method: 
 * /camera/realsense2_camera/usb_port_id: 
 * /rosdistro: noetic
 * /rosversion: 1.17.0

NODES
  /
    rviz (rviz/rviz)
  /camera/
    realsense2_camera (nodelet/nodelet)
    realsense2_camera_manager (nodelet/nodelet)

auto-starting new master
process[master]: started with pid [69]
ROS_MASTER_URI=http://192.168.X.XX:11311

setting /run_id to 2f593092-ff6e-11ef-bcd6-488f4cfd08c6
process[rosout-1]: started with pid [86]
started core service [/rosout]
process[camera/realsense2_camera_manager-2]: started with pid [93]
process[camera/realsense2_camera-3]: started with pid [94]
process[rviz-4]: started with pid [95]
[ INFO] [1741803418.775126112]: Initializing nodelet with 8 worker threads.
QStandardPaths: XDG_RUNTIME_DIR not set, defaulting to '/tmp/runtime-root'
[ INFO] [1741803418.874247414]: RealSense ROS v2.3.1
[ INFO] [1741803418.874320313]: Built with LibRealSense v2.48.0
[ INFO] [1741803418.874378683]: Running with LibRealSense v2.48.0
[ INFO] [1741803418.908208201]:  
 12/03 18:16:59,001 WARNING [281472409784688] (messenger-libusb.cpp:42) control_transfer returned error, index: 300, error: No data available, number: 3d
[ INFO] [1741803419.180567381]: Device with serial number f0211758 was found.

[ INFO] [1741803419.180671033]: Device with physical ID 2-1.1-8 was found.
[ INFO] [1741803419.180695130]: Device with name Intel RealSense L515 was found.
[ INFO] [1741803419.181427892]: Device with port number 2-1.1 was found.
[ INFO] [1741803419.205440774]: Device with serial number 905312111138 was found.

[ INFO] [1741803419.205518537]: Device with physical ID 2-1.2-9 was found.
[ INFO] [1741803419.205538058]: Device with name Intel RealSense T265 was found.
[ INFO] [1741803419.205915287]: Device with port number 2-1.2 was found.
[ INFO] [1741803419.205978233]: Device USB type: 3.1
[ INFO] [1741803419.219044680]: No calib_odom_file. No input odometry accepted.
[ INFO] [1741803419.221559873]: getParameters...
[ INFO] [1741803419.283887424]: setupDevice...
[ INFO] [1741803419.283950530]: JSON file is not provided
[ INFO] [1741803419.283971395]: ROS Node Namespace: camera
[ INFO] [1741803419.284013284]: Device Name: Intel RealSense T265
[ INFO] [1741803419.284035013]: Device Serial No: 905312111138
[ INFO] [1741803419.284057734]: Device physical port: 2-1.2-9
[ INFO] [1741803419.284089095]: Device FW version: 0.2.0.951
[ INFO] [1741803419.284108808]: Device Product ID: 0x0B37
[ INFO] [1741803419.284124744]: Enable PointCloud: Off
[ INFO] [1741803419.284139657]: Align Depth: Off
[ INFO] [1741803419.284155657]: Sync Mode: Off
[ INFO] [1741803419.284260717]: Device Sensors: 
[ INFO] [1741803419.284476437]: Tracking Module was found.
[ INFO] [1741803419.284549719]: (Depth, 0) sensor isn't supported by current device! -- Skipping...
[ INFO] [1741803419.284572056]: (Color, 0) sensor isn't supported by current device! -- Skipping...
[ INFO] [1741803419.284601977]: (Confidence, 0) sensor isn't supported by current device! -- Skipping...
[ INFO] [1741803419.284642491]: num_filters: 0
[ INFO] [1741803419.284673212]: Setting Dynamic reconfig parameters.
[ WARN] [1741803419.289825426]: Param '/camera/tracking_module/frames_queue_size' has value 256 that is not in range [0, 32]. Removing this parameter from dynamic reconfigure options.
[ INFO] [1741803419.300293477]: Done Setting Dynamic reconfig parameters.
[ INFO] [1741803419.301217093]: gyro stream is enabled - fps: 200
[ INFO] [1741803419.301743576]: accel stream is enabled - fps: 62
[ INFO] [1741803419.302148358]: pose stream is enabled - fps: 200
[ INFO] [1741803419.302473714]: setupPublishers...
[ INFO] [1741803419.306240119]: setupStreams...
[ INFO] [1741803419.306622917]: insert Gyro to Tracking Module
[ INFO] [1741803419.306927984]: insert Accel to Tracking Module
[ INFO] [1741803419.307155896]: insert Pose to Tracking Module
[ INFO] [1741803419.335763021]: SELECTED BASE:Pose, 0
[ INFO] [1741803419.339992450]: RealSense Node Is Up!
[ WARN] [1741803419.342790885]: 
^C[rviz-4] killing on exit
[camera/realsense2_camera-3] killing on exit
[camera/realsense2_camera_manager-2] killing on exit
^C^C^C[rosout-1] killing on exit
[master] killing on exit
shutting down processing monitor...
... shutting down processing monitor complete
```
### Rostopic list:
```
root@jetsonnx:/catkin_ws# rostopic list
/camera/accel/imu_info
/camera/accel/sample
/camera/gyro/imu_info
/camera/gyro/sample
/camera/odom/sample
/camera/realsense2_camera_manager/bond
/camera/tracking_module/parameter_descriptions
/camera/tracking_module/parameter_updates
/clicked_point
/diagnostics
/initialpose
/move_base_simple/goal
/rosout
/rosout_agg
/tf
/tf_static
```
