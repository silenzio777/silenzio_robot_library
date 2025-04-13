
## OctoMap-ROS2

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
colcon build
```

