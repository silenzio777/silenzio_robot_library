## TIAGo ROS 2 Simulation

## This repository contains the launch files to simulate the TIAGo robot in ROS 2.
https://github.com/pal-robotics/tiago_simulation/tree/humble-devel

### Install:
```
sudo apt install ros-humble-moveit
```

### Prerequisites
```
sudo apt-get update
sudo apt-get install git python3-vcstool python3-rosdep python3-colcon-common-extensions
```

### Create a workspace and clone all repositories:
```
mkdir -p ~/tiago_public_ws/src
cd ~/tiago_public_ws
vcs import --input https://raw.githubusercontent.com/pal-robotics/tiago_tutorials/humble-devel/tiago_public.repos src
```
### Install dependencies using rosdep
```
sudo rosdep init
rosdep update
sudo rosdep install --from-paths src -y --ignore-src
```

### Source the environment and build
```
source /opt/ros/humble/setup.bash
colcon build --symlink-install
```
### Ubuntu PC: build OK

### Finally, before running any application you have to source the workspace
```
source ~/tiago_public_ws/install/setup.bash
```

### Simulation
Standalone
Launch gazebo simulation:
```
ros2 launch tiago_gazebo tiago_gazebo.launch.py is_public_sim:=True [arm_type:=no-arm]
```
### Ubuntu PC: launch OK

