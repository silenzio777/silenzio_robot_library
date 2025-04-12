
### Setup:


<img src="LogitechCordlessRumblePad_2_front.png" title="LogitechCordlessRumblePad_2_front" width="461">


UbuntuPC:
T0:
```
ros2 launch teleop_twist_joy teleop-launch.py
```

Jetson NX:
T0:
```
01_ROS2_T256_L515.sh
```

T1:
```
sudo chmod a+rw /dev/ttyUSB0
```
```
ros2 launch hls_lfcd_lds_driver hlds_laser.launch.py
```

```
03_stella_RVIZ_omni.sh
```
```
04_stella_SLAM.sh
```

T4:
```
ros2 launch nav2_bringup navigation_launch.py map:=~/ros2_ws/my_map.yaml
```

T5:
```
ros2 launch slam_toolbox online_async_launch.py
```




