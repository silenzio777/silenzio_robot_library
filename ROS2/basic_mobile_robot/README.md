
### Set Up the Odometry for a Simulated Mobile Robot in ROS 2

https://automaticaddison.com/set-up-the-odometry-for-a-simulated-mobile-robot-in-ros-2/

```
sudo apt-get install ros-humble-rqt-robot-steering
sudo apt install ros-humble-robot-localization

source /opt/ros/humble/setup.bash
cd ~/ros2_ws && source install/setup.bash

export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/home/silenzio/ros2_ws/src/two_wheeled_robot/models
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/home/silenzio/ros2_ws/src/basic_mobile_robot/models

cd ~/ros2_ws/src/basic_mobile_robot/worlds/basic_mobile_bot_world

gazebo smalltown.world
```

## Work


basic_mobile_robot

### T0:
rqt_robot_steering

### T1:

