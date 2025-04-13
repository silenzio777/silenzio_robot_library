
## OctoMap-ROS2

https://github.com/Taeyoung96/OctoMap-ROS2

### Environment setting
- ROS2 humble
- PCL
- Eigen

### Install:

Environment setting
```
sudo apt update

sudo apt install libatlas-base-dev libeigen3-dev libpcl-dev libgoogle-glog-dev libsuitesparse-dev libglew-dev ros-humble-pcl-conversions ros-humble-pcl-ros ros-humble-ament-cmake-auto
```

```
cd ~/ros2_ws/src
git clone https://github.com/Taeyoung96/OctoMap-ROS2.git
```
### Build:

```
colcon build --packages-select octomap_msgs octomap_ros
```
```
source install/setup.bash
```
```
colcon build
```

### Run:
___
```
ros2 launch fast_lio velodyne.launch.py
```
Error:
```
Package 'fast_lio' not found:...
```

```
ros2 launch octomap_server octomap_mapping.launch.xml

[INFO] [launch]: All log files can be found below /home/silenzio/.ros/log/2025-04-13-19-09-58-032111-jetsonnx-87161
[INFO] [launch]: Default logging verbosity is set to INFO
[INFO] [octomap_server_node-1]: process started with pid [87186]
[octomap_server_node-1] [INFO] [1744560598.479580164] [octomap_server]: Publishing latched (single publish will take longer, all topics are prepared)
[octomap_server_node-1] [WARN] [1744560598.495300750] [octomap_server]: Nothing to publish, octree is empty
[octomap_server_node-1] [WARN] [1744560598.495430163] [octomap_server]: Could not open file
```


You need to run the 3D Mapping package (ex. FAST_LIO_ROS2) at the same time.

On the FAST-LIO2 terminal,
```
ros2 launch fast_lio velodyne.launch.py
```
For this docker container,

```
ros2 launch octomap_server octomap_mapping.launch.xml
```

Map save
```
ros2 run nav2_map_server map_saver_cli -f ~/ros2_ws/src/ --ros-args --remap map:=/projected_map
```

_____________


### Install image_pipeline:
[https://github.com/ros-perception/image_pipeline/tree/humble](https://github.com/ros-perception/image_pipeline/tree/humble)

To convert L515 RGBD data to PointCloud2

```
cd ~/ros2_ws/src

git clone -b humble https://github.com/ros-perception/image_pipeline
```
```
colcon build --packages-select depth_image_proc
```
```
source install/setup.bash
```

### Run:

T1:
```
ros2 run depth_image_proc point_cloud_xyz_node
```


T2:
```
ros2 run image_transport republish raw in:=/camera/depth/image_rect_raw raw out:=/image_rect
```

T3:
```
ros2 run image_transport republish raw in:=/camera/depth/camera_info raw out:=/camera_info
```

_____________
