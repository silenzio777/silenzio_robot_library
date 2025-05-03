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
. install/local_setup.bash
ros2 launch ov_msckf subscribe.launch.py config:=euroc_mav
```

### T1:
```
ov_docker ov_ros2_22_04 bash
ros2 bag play /datasets/V1_01_easy/V1_01_easy.db3
```
### Works:

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
colcon build --cmake-args --event-handlers console_cohesion+ --packages-select ov_core ov_init ov_msckf ov_eval
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

------------------------------------------------------------------------------------------
### Ubuntu 22 Jetson Orin NX: Install Ceres-solver 2.1.0 
------------------------------------------------------------------------------------------
http://ceres-solver.org/installation.html

```
wget http://ceres-solver.org/ceres-solver-2.1.0.tar.gz
tar zxf ceres-solver-2.1.0.tar.gz
mkdir ceres-bin
cd ceres-bin
```

```
cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON -DCERES_USE_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES="87" -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda -DCMAKE_CUDA_COMPILER=/usr/local/cuda-12.6/bin/nvcc -DCUDA_ARCH_BIN="87" -DCUDA_ARCH_PTX=""

make -j7

sudo make install
...
-- Up-to-date: /usr/local/include
-- Up-to-date: /usr/local/include/ceres
-- Up-to-date: /usr/local/include/ceres/internal
-- Installing: /usr/local/include/ceres/internal/config.h
-- Installing: /usr/local/include/ceres/internal/export.h
-- Old export file "/usr/local/lib/cmake/Ceres/CeresTargets.cmake" will be replaced.  Removing files [/usr/local/lib/cmake/Ceres/CeresTargets-release.cmake].
-- Installing: /usr/local/lib/cmake/Ceres/CeresTargets.cmake
-- Installing: /usr/local/lib/cmake/Ceres/CeresTargets-release.cmake
-- Installing: /usr/local/lib/cmake/Ceres/CeresConfig.cmake
-- Installing: /usr/local/lib/cmake/Ceres/CeresConfigVersion.cmake
-- Installing: /usr/local/lib/libceres.so.2.1.0
-- Installing: /usr/local/lib/libceres.so.3
-- Set non-toolchain portion of runtime path of "/usr/local/lib/libceres.so.2.1.0" to ""
-- Installing: /usr/local/lib/libceres.so

sudo ldconfig
```

____________
### T265 online demo:

### T0:
```
01_ROS2_T256_L515.sh
#
cd /foxy/t265_l515_v4_0_4_ws
. install/local_setup.bash
export CYCLONEDDS_URI=/.ros/cyclonedds_foxy.xml
os2 launch realsense2_camera rs_launch.py camera_name:=t265  enable_pose:=false
```

### T1:
```
ov_docker ov_ros2_22_04 bash
cd catkin_ws
source install/setup.bash 
ros2 launch ov_msckf subscribe.launch.py config:=rs_t265
```

### T2:
```
rviz2
```

### Works on Jetson Orin NX
 
_________
## open_vins

### open_vins topics:

```
ros2 topic echo /ov_msckf/poseimu
```
```
---
header:
  stamp:
    sec: 1745090475
    nanosec: 571621180
  frame_id: global
pose:
  pose:
    position:
      x: 0.016779041972254168
      y: 0.04588799576898281
      z: 0.0044552041103211445
    orientation:
      x: 0.3915636577023765
      y: -0.5394562164027045
      z: -0.5922423486211437
      w: 0.452674157701681
  covariance:
  - 0.002532857846588113
```

```
/ov_msckf/poseimu frame_id: global
            child_frame_id: imu
```

/t265/pose/sample frame_id: odom_frame
            child_frame_id: t265_pose_frame

__________

## Setup T265 only:

### Run:

### T0:
```
01_ROS2_T256_L515.sh
#
    cd /foxy/t265_l515_v4_0_4_ws
    . install/local_setup.bash
    export CYCLONEDDS_URI=/.ros/cyclonedds_foxy.xml
    ros2 launch realsense2_camera rs_launch.py camera_name:=t265 enable_pose:=false enable_gyro:=true enable_accel:=true
```

### T1:
```
ros2 launch ov_msckf subscribe.launch.py config:=rs_t265
```

### T2:
```
rviz2
```


### Works:

__________

## Setup T265 + L515:

### Run:

### T0:
```
01_ROS2_T256_L515.sh
#
    cd /foxy/t265_l515_v4_0_4_ws
    . install/local_setup.bash
    export CYCLONEDDS_URI=/.ros/cyclonedds_foxy.xml    
    ros2 launch realsense2_camera rs_l515_and_t265_launch.py enable_pose:=false enable_gyro:=true enable_accel:=true
```

### T1:
```
ros2 launch ov_msckf subscribe.launch.py config:=rs_t265
```

### T2:
```
rviz2
```


### Works:
