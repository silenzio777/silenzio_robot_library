
- [JetsonOrin NX](JetsonOrinNX16Gb/README.md)<br/>
- [UbuntuPC](UbuntuPC)<br/>


## ROS2 command:
```
nano ~/.bashrc
source ~/.bashrc

source /opt/ros/$ROS_DISTRO/setup.bash
source /opt/ros/humble/setup.bash
cd ~/ros2_ws && source install/setup.bash

colcon_cd

colcon build

rqt_graph

ros2 topic list

ros2 topic echo odom --no-arr

ros2 run tf2_tools view_frames

ros2 topic hz /camera/color/image_raw


## PACKAGES:

## Lidar lfcd_lds:
sudo chmod a+rw /dev/ttyUSB0
ros2 launch hls_lfcd_lds_driver hlds_laser.launch.py

## Turtlebot3 teleop:

ros2 run turtlebot3_teleop teleop_keyboard

## REMAP:
##ros2 run demo_nodes_cpp listener --ros-args --remap /chatter:=/alt_chatter

--ros-args --remap /odom:=/T265/pose/sample 

## Publisher:
ros2 run tf2_ros static_transform_publisher 0 0 0 0 0 0 1 base_link camera_link
ros2 run tf2_ros static_transform_publisher 0.1 0 0.2 0 0 0 base_link base_laser


ros2 run tf2_ros tf2_echo base_link base_laser

At time 0.0
- Translation: [0.100, 0.000, 0.200]
- Rotation: in Quaternion [0.000, 0.000, 0.000, 1.000]

ros2 run py_pubsub publisher_member_function
ros2 run py_pubsub subscriber_member_function

ros2 run csi_cam_opencv impub
ros2 run csi_cam_opencv imsubs

```
