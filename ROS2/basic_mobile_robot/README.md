
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

cd ~/ros2_ws/basic_mobile_robot/
mkdir src

cd ~/ros2_ws/two_wheeled_robot/
mkdir src
mkdir two_wheeled_robot
cd ~/ros2_ws/two_wheeled_robot/two_wheeled_robot
touch __init__.py

cd cd ~/ros2_ws
colcon build

...
Finished <<< two_wheeled_robot [0.80s]
Finished <<< basic_mobile_robot [1.39s]
```


## Setup gazebo sim worlds:
```
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
```
rqt_robot_steering
```

### T1:
```
cd ~/ros2_ws && source install/setup.bash
ros2 launch basic_mobile_robot basic_mobile_bot_v2.launch.py
```
### Error:

```
[gzclient-2] gzclient: /usr/include/boost/smart_ptr/shared_ptr.hpp:728: typename boost::detail::sp_member_access<T>::type boost::shared_ptr<T>::operator->() const [with T = gazebo::rendering::Camera; typename boost::detail::sp_member_access<T>::type = gazebo::rendering::Camera*]: Assertion `px != 0' failed.
[ERROR] [gzclient-2]: process has died [pid 26331, exit code -6, cmd 'gzclient --gui-client-plugin=libgazebo_ros_eol_gui.so'].
```

### Fix:

I had same problem in ros2 Humble.
Sourcing . /usr/share/gazebo/setup.sh solved my problem.

```
source /usr/share/gazebo/setup.sh
```
## Work

```
ros2 launch basic_mobile_robot basic_mobile_bot_v2.launch.py
[INFO] [launch]: All log files can be found below /home/silenzio/.ros/log/2025-04-18-15-29-40-908911-ubuntuPC-26561
[INFO] [launch]: Default logging verbosity is set to INFO
[INFO] [gzserver-1]: process started with pid [26564]
[INFO] [gzclient-2]: process started with pid [26566]
[INFO] [robot_state_publisher-3]: process started with pid [26568]
[INFO] [rviz2-4]: process started with pid [26570]
[robot_state_publisher-3] [INFO] [1744979382.951591034] [robot_state_publisher]: got segment base_footprint
[robot_state_publisher-3] [INFO] [1744979382.951703492] [robot_state_publisher]: got segment base_link
[robot_state_publisher-3] [INFO] [1744979382.951730271] [robot_state_publisher]: got segment drivewhl_l_link
[robot_state_publisher-3] [INFO] [1744979382.951739750] [robot_state_publisher]: got segment drivewhl_r_link
[robot_state_publisher-3] [INFO] [1744979382.951748669] [robot_state_publisher]: got segment front_caster
[robot_state_publisher-3] [INFO] [1744979382.951757113] [robot_state_publisher]: got segment gps_link
[robot_state_publisher-3] [INFO] [1744979382.951765661] [robot_state_publisher]: got segment imu_link
[rviz2-4] [INFO] [1744979383.479351603] [rviz2]: Stereo is NOT SUPPORTED
[rviz2-4] [INFO] [1744979383.479463954] [rviz2]: OpenGl version: 4.6 (GLSL 4.6)
[rviz2-4] [INFO] [1744979383.576192334] [rviz2]: Stereo is NOT SUPPORTED
[gzserver-1] [INFO] [1744979384.922026056] [basic_mobile_bot_diff_drive]: Wheel pair 1 separation set to [0.520000m]
[gzserver-1] [INFO] [1744979384.922291892] [basic_mobile_bot_diff_drive]: Wheel pair 1 diameter set to [0.280000m]
[gzserver-1] [INFO] [1744979384.922741144] [basic_mobile_bot_diff_drive]: Subscribed to [/cmd_vel]
[gzserver-1] [INFO] [1744979384.923923677] [basic_mobile_bot_diff_drive]: Advertise odometry on [/wheel/odometry]
[gzserver-1] [INFO] [1744979384.931956198] [basic_mobile_bot_joint_state]: Going to publish joint [drivewhl_l_joint]
[gzserver-1] [INFO] [1744979384.931990944] [basic_mobile_bot_joint_state]: Going to publish joint [drivewhl_r_joint]

```


```
ros2 topic echo /wheel/odometry  --no-arr

---
header:
  stamp:
    sec: 138
    nanosec: 686000000
  frame_id: odom
child_frame_id: base_footprint
pose:
  pose:
    position:
      x: 0.026669722806629808
      y: 0.0019291823795402117
      z: 0.23998762884056996
    orientation:
      x: -7.769214135659952e-07
      y: 2.840117738975622e-05
      z: 0.002572573943476475
      w: 0.9999966905225612
  covariance: '<array type: double[36]>'
twist:
  twist:
    linear:
      x: 0.00023296327200423965
      y: 1.326383204530475e-05
      z: 0.0
    angular:
      x: 0.0
      y: 0.0
      z: -3.879842268297591e-05
  covariance: '<array type: double[36]>'

```

## Run:


### T0:
```
ros2 launch teleop_twist_joy teleop-launch.py
```

### T1:
```
ros2 launch basic_mobile_robot basic_mobile_bot_v4.launch.py
[INFO] [launch]: All log files can be found below /home/silenzio/.ros/log/2025-04-18-16-29-07-627956-ubuntuPC-34961
[INFO] [launch]: Default logging verbosity is set to INFO
[INFO] [gzserver-1]: process started with pid [34963]
[INFO] [gzclient-2]: process started with pid [34965]
[INFO] [ekf_node-3]: process started with pid [34967]
[INFO] [robot_state_publisher-4]: process started with pid [34969]
[INFO] [rviz2-5]: process started with pid [34971]
...
```

### T2:
```
ros2 launch slam_toolbox online_async_launch.py
```
<img src="https://github.com/user-attachments/assets/f70a2fc1-9576-480a-aded-cb8007017681" title="" width="1200">

![Screenshot 2025-04-18 at 16 37 30](https://github.com/user-attachments/assets/187f8ff8-c12c-40ea-9986-086762dfe5c2)

![Screenshot 2025-04-18 at 16 38 00](https://github.com/user-attachments/assets/a9b503ed-55ab-4b58-b086-6c3f2d8c0228)

<img src="https://github.com/user-attachments/assets/8bd70c5a-f11f-4510-a654-996533488453" title="" width="800">

```
ros2 topic list
```

```
/basic_mobile_bot_gps/vel
/clicked_point
/clock
/cmd_vel
/diagnostics
/gps/fix
/imu/data
/initialpose
/joint_states
/joy
/joy/set_feedback
/map
/map_metadata
/map_updates
/odometry/filtered
/parameter_events
/performance_metrics
/pose
/robot_description
/rosout
/scan
/set_pose
/slam_toolbox/feedback
/slam_toolbox/graph_visualization
/slam_toolbox/scan_visualization
/slam_toolbox/update
/tf
/tf_static
/wheel/odometry
```

### T3:

NAV2
```
ros2 launch nav2_bringup navigation_launch.py map:=~/ros2_ws/my_map.yaml
```
 
![Screenshot 2025-04-18 at 17 09 33](https://github.com/user-attachments/assets/c91d4279-6f73-4299-ab7c-2cccb15ab94b)

![rosgraph_](https://github.com/user-attachments/assets/6036076f-5483-45e1-9b81-1b41e6a9e871)


```
ros2 topic list
```
```
/basic_mobile_bot_gps/vel
/behavior_server/transition_event
/behavior_tree_log
/bond
/bt_navigator/transition_event
/clicked_point
/clock
/cmd_vel
/cmd_vel_nav
/cmd_vel_teleop
/controller_server/transition_event
/cost_cloud
/diagnostics
/evaluation
/global_costmap/costmap
/global_costmap/costmap_raw
/global_costmap/costmap_updates
/global_costmap/footprint
/global_costmap/global_costmap/transition_event
/global_costmap/published_footprint
/goal_pose
/gps/fix
/imu/data
/initialpose
/joint_states
/local_costmap/clearing_endpoints
/local_costmap/costmap
/local_costmap/costmap_raw
/local_costmap/costmap_updates
/local_costmap/footprint
/local_costmap/local_costmap/transition_event
/local_costmap/published_footprint
/local_costmap/voxel_grid
/local_plan
/map
/map_metadata
/map_updates
/marker
/odom
/odometry/filtered
/parameter_events
/performance_metrics
/plan
/plan_smoothed
/planner_server/transition_event
/pose
/preempt_teleop
/received_global_plan
/robot_description
/rosout
/scan
/set_pose
/slam_toolbox/feedback
/slam_toolbox/graph_visualization
/slam_toolbox/scan_visualization
/slam_toolbox/update
/smoother_server/transition_event
/speed_limit
/tf
/tf_static
/transformed_global_plan
/velocity_smoother/transition_event
/waypoint_follower/transition_event
/waypoints
/wheel/odometry
```

