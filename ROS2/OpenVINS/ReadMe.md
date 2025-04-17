## OpenVINS

https://github.com/rpng/open_vins

### Docker Install: 

```
mkdir -p ~/ws/catkin_ws_ov/src
cd ~/ws/catkin_ws_ov/src
git clone https://github.com/rpng/open_vins.git
cd open_vins
export VERSION=ros2_22_04 # which docker file version you want (ROS1 vs ROS2 and ubuntu version)
docker build -t ov_$VERSION -f Dockerfile_$VERSION .
```

### Get dataset: 
https://docs.openvins.com/gs-tutorial.html

```
https://drive.google.com/file/d/1LFrdiMU6UBjtFfXPHzjJ4L7iDIXcdhvh/view?usp=drive_link
```

Unarchive it to: /home/silenzio/_dataset/ov/V1_01_easy/V1_01_easy.db3

### Run:

```
nano ~/.bashrc # add to the bashrc file
xhost + &> /dev/null
export DOCKER_CATKINWS=/home/silenzio/ws/catkin_ws_ov
export DOCKER_DATASETS=/home/silenzio/_dataset/ov

alias ov_docker="docker run -it --net=host --gpus all \
    --env=\"NVIDIA_DRIVER_CAPABILITIES=all\" --env=\"DISPLAY\" \
    --env=\"QT_X11_NO_MITSHM=1\" --volume=\"/tmp/.X11-unix:/tmp/.X11-unix:rw\" \
    --mount type=bind,source=$DOCKER_CATKINWS,target=/catkin_ws \
    --mount type=bind,source=$DOCKER_DATASETS,target=/datasets $1"
source ~/.bashrc # after you save and exit
```

```
ov_docker ov_ros2_22_04 bash
ov_docker ov_ros2_22_04 ros2
ov_docker ov_ros2_22_04 ros2 run rviz2 rviz2 -d /catkin_ws/src/open_vins/ov_msckf/launch/display_ros2.rviz
```

### ROS2 build:

UBUNTU PC:
```
ov_docker ov_ros2_22_04 bash
cd catkin_ws
colcon build --event-handlers console_cohesion+
```

### ROS2 run:
Test:
```
ov_docker ov_ros2_22_04 bash
cd catkin_ws
source install/setup.bash
ros2 run ov_eval plot_trajectories none src/open_vins/ov_data/sim/udel_gore.txt
ros2 run ov_eval plot_trajectories none src/open_vins/ov_data/sim/euroc_V1_01_easy.txt
ros2 run ov_msckf run_simulation src/open_vins/config/rpng_sim/estimator_config.yaml
ros2 run ov_msckf run_simulation src/open_vins/config/kaist_vio/estimator_config.yaml
```


### T0:
```
ov_docker ov_ros2_22_04 bash
cd catkin_ws
ros2 launch ov_msckf subscribe.launch.py config:=euroc_mav
```

### T1:
```
ov_docker ov_ros2_22_04 bash
ros2 bag play /datasets/V1_01_easy/V1_01_easy.db3
```
### Work:

<img src="OpenVINS _01.png" title="OpenVINS _01" width="1000">

```
ros2 topic echo  /cam0/image_raw
---
header:
  stamp:
    sec: 1403715291
    nanosec: 812143000
  frame_id: cam0
height: 480
width: 752
encoding: mono8
is_bigendian: 0
step: 752
data:
- 148
```

### T265 online demo:

### T0:
```
ov_docker ov_ros2_22_04 bash
cd catkin_ws
source install/setup.bash
ros2 launch ov_msckf subscribe.launch.py config:=rs_t265
```

```
ros2 topic list
/ov_msckf/loop_depth
/ov_msckf/loop_depth_colored
/ov_msckf/loop_extrinsic
/ov_msckf/loop_feats
/ov_msckf/loop_intrinsics
/ov_msckf/loop_pose
/ov_msckf/odomimu
/ov_msckf/pathgt
/ov_msckf/pathimu
/ov_msckf/points_aruco
/ov_msckf/points_msckf
/ov_msckf/points_sim
/ov_msckf/points_slam
/ov_msckf/posegt
/ov_msckf/poseimu
/ov_msckf/trackhist
/parameter_events

/t265/fisheye1/image_raw
/t265/fisheye2/image_raw
/t265/imu

/rosout
/tf

```

```
cd ~/ws/catkin_ws_ov/
source install/setup.bash

```


_________________

## Jetson Orin NX:

### ROS2 Install: 

```
cd ~/ros2_ws/src
git clone https://github.com/rpng/open_vins.git
```


### ROS2 build:

```
cd ~/ros2_ws/
## colcon build --event-handlers console_cohesion+
colcon build --cmake-args -DOpenCV_DIR=/usr/local/lib/cmake/opencv4 --event-handlers console_cohesion+ --packages-select ov_core ov_init ov_msckf ov_eval
```




### Bulld error:
```
Finished <<< ov_core [3min 0s]
Starting >>> ov_init
Starting >>> ov_eval
[Processing: ov_eval, ov_init]                                                                           
--- output: ov_init
...
[ 56%] Building CXX object CMakeFiles/ov_init_lib.dir/src/sim/SimulatorInit.cpp.o
In file included from /home/silenzio/ros2_ws/src/open_vins/ov_init/src/ceres/State_JPLQuatLocal.cpp:22:
/home/silenzio/ros2_ws/src/open_vins/ov_init/src/ceres/State_JPLQuatLocal.h:32:64: error: expected class-name before `{` token
   32 | class State_JPLQuatLocal : public ceres::LocalParameterization {
...
```

### Fix:
https://github.com/rpng/open_vins/issues/421

https://github.com/rpng/open_vins/issues/385


This is due to a backwards incompatible change of ceres-solver.

LocalParameterization has been removed, use Manifold instead.
http://ceres-solver.org/version_history.html#id1

You should install a version earlier than 2.2.0

...

_____________

------------------------------------------------------------------------------------------
### ceres-solver Install UBUNTU 22 Jetson Orin NX
------------------------------------------------------------------------------------------
http://ceres-solver.org/installation.html

wget http://ceres-solver.org/ceres-solver-2.1.0.tar.gz
tar zxf ceres-solver-2.2.0.tar.gz
mkdir ceres-bin
cd ceres-bin


cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DCERES_USE_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES="87" -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda -DCMAKE_CUDA_COMPILER=/usr/local/cuda-12.6/bin/nvcc -DCUDA_ARCH_BIN="87" -DCUDA_ARCH_PTX=""



_____________

## Jetson Orin NX:

### Docker Install: 
https://github.com/dusty-nv/jetson-containers/tree/master/packages/robots/ros

file "Dockerfile_ros2_22_04":

```
#FROM osrf/ros:humble-desktop
#FROM  arm64v8/ros:humble-ros-base-jammy
FROM dustynv/ros:humble-ros-base-l4t-r36.2.0

# =========================================================
# =========================================================

# Are you are looking for how to use this docker file?
#   - https://docs.openvins.com/dev-docker.html
#   - https://docs.docker.com/get-started/
#   - http://wiki.ros.org/docker/Tutorials/Docker

# =========================================================
# =========================================================

# Dependencies we use, catkin tools is very good build system
# Also some helper utilities for fast in terminal edits (nano etc)
RUN apt update && apt install -y nano git libeigen3-dev libboost-system1.74-dev 

# Ceres solver install and setup
RUN sudo apt-get install -y cmake libgoogle-glog-dev libgflags-dev libatlas-base-dev libeigen3-dev libsuitesparse-dev 

## libceres-dev

ENV CERES_VERSION="2.0.0"
RUN git clone https://ceres-solver.googlesource.com/ceres-solver && \
     cd ceres-solver && \
     git checkout tags/${CERES_VERSION} && \
     mkdir build && cd build && \
     cmake .. && \
     make -j$(nproc) install && \
     rm -rf ../../ceres-solver

# Seems this has Python 3.10 installed on it...
RUN apt-get update && apt-get install -y python3-dev python3-matplotlib python3-numpy python3-psutil python3-tk

# Install deps needed for clion remote debugging
# https://blog.jetbrains.com/clion/2020/01/using-docker-with-clion/
# RUN sed -i '6i\source "/catkin_ws/install/setup.bash"\' /ros_entrypoint.sh
RUN apt-get update && apt-get install -y ssh build-essential gcc g++ \
    gdb clang cmake rsync tar python3 && apt-get clean
RUN ( \
    echo 'LogLevel DEBUG2'; \
    echo 'PermitRootLogin yes'; \
    echo 'PasswordAuthentication yes'; \
    echo 'Subsystem sftp /usr/lib/openssh/sftp-server'; \
  ) > /etc/ssh/sshd_config_test_clion \
  && mkdir /run/sshd
RUN useradd -m user && yes password | passwd user
RUN usermod -s /bin/bash user
CMD ["/usr/sbin/sshd", "-D", "-e", "-f", "/etc/ssh/sshd_config_test_clion"]

```

```
cd ~/ros2_ws/src
git clone https://github.com/rpng/open_vins.git
cd open_vins
export VERSION=ros2_22_04 # which docker file version you want (ROS1 vs ROS2 and ubuntu version)
docker build -t ov_$VERSION -f Dockerfile_$VERSION .
```

### Build:
```
docker build -t ov_$VERSION -f Dockerfile_$VERSION .
```

### Run:
cd ~/ros2_ws/src
```
nano ~/.bashrc # add to the bashrc file
xhost + &> /dev/null
export DOCKER_CATKINWS=/home/silenzio/ros2_ws
export DOCKER_DATASETS=/home/silenzio/_dataset/ov

alias ov_docker="docker run -it --net=host  \
    --rm --runtime=nvidia --gpus all \
    --rm -v /usr/local/lib:/usr/local/lib \
    --env=\"DISPLAY\" \
    --env=\"QT_X11_NO_MITSHM=1\" --volume=\"/tmp/.X11-unix:/tmp/.X11-unix:rw\" \
    --mount type=bind,source=$DOCKER_CATKINWS,target=/catkin_ws \
    --mount type=bind,source=$DOCKER_DATASETS,target=/datasets $1"

alias ov_docker="docker run -it --net=host  \
    --rm --runtime=nvidia --gpus all \
    --rm -v /usr/local/lib/cmake/opencv4:/usr/local/lib/cmake/opencv4 \
    --env=\"DISPLAY\" \
    --env=\"QT_X11_NO_MITSHM=1\" --volume=\"/tmp/.X11-unix:/tmp/.X11-unix:rw\" \
    --mount type=bind,source=$DOCKER_CATKINWS,target=/catkin_ws \
    --mount type=bind,source=$DOCKER_DATASETS,target=/datasets $1"


alias ov_docker="docker run -it --net=host  \
    --rm --runtime=nvidia --gpus all \
    --env=\"DISPLAY\" \
    --env=\"QT_X11_NO_MITSHM=1\" --volume=\"/tmp/.X11-unix:/tmp/.X11-unix:rw\" \
    --mount type=bind,source=$DOCKER_CATKINWS,target=/catkin_ws \
    --mount type=bind,source=$DOCKER_DATASETS,target=/datasets $1"



source ~/.bashrc # after you save and exit
```

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib/

```
ov_docker ov_ros2_22_04 bash
ov_docker ov_ros2_22_04 ros2
ov_docker ov_ros2_22_04 ros2 run rviz2 rviz2 -d /catkin_ws/src/open_vins/ov_msckf/launch/display_ros2.rviz
```

### T265 online demo:
### T0:
```
01_ROS2_T256_L515.sh

```


### T1:
```
ov_docker ov_ros2_22_04 bash
cd catkin_ws
source install/setup.bash
ros2 launch ov_msckf subscribe.launch.py config:=rs_t265
```
