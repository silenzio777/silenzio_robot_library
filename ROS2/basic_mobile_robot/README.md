
### Set Up the Odometry for a Simulated Mobile Robot in ROS 2

https://automaticaddison.com/set-up-the-odometry-for-a-simulated-mobile-robot-in-ros-2/

You can get the entire code for this project:</br>

https://drive.google.com/drive/folders/1134y69OYI7JzXF9H2B_IV4VztaCAzzPj?usp=sharing

https://drive.google.com/drive/folders/1VrgqtETVSuheNITop0MXDy4BY3U8IphQ?usp=sharing



```
sudo apt-get install ros-humble-rqt-robot-steering
sudo apt install ros-humble-robot-localization

source /opt/ros/humble/setup.bash
cd ~/ros2_ws && source install/setup.bash

cd cd ~/ros2_ws
colcon build
```
Finished <<< two_wheeled_robot [0.80s]
Finished <<< basic_mobile_robot [1.39s]

```
cd ~/ros2_ws && source install/setup.bash

export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/home/silenzio/ros2_ws/src/two_wheeled_robot/models
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/home/silenzio/ros2_ws/src/basic_mobile_robot/models

cd ~/ros2_ws/src/basic_mobile_robot/worlds/basic_mobile_bot_world

gazebo smalltown.world
```

## Work
![Screenshot 2025-04-18 at 14 46 39](https://github.com/user-attachments/assets/17570915-2f15-40a7-831d-ebc47945e2c7)
_________

```
ros2 topic info /imu/data
ros2 topic info /wheel/odometry
```

### T0:
rqt_robot_steering

### T1:

