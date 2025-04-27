## Run:

UbuntuPC:

### Joystick teleop

T0:
```
ros2 launch teleop_twist_joy teleop-launch.py
```
_______

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

## SLAM mapping mide:

T2:
```
ros2 launch omni slam.launch.py mode:=map stp_config:=t265
```
```
ros2 launch omni slam.launch.py mode:=map stp_config:=stella_vslam
```
```
ros2 launch omni slam.launch.py mode:=map stp_config:=open_vins
```
_______

### Save map:

T3:
```
ros2 run nav2_map_server map_saver_cli -f /home/silenzio/ros2_ws/src/omni/maps/flat_map
```

Map will be save at files "flat_map.pgm" and "flat_map.yaml" in dir /home/silenzio/ros2_ws/src/omni/maps/flat_map

_______

### Localization mode:

T2:
```
ros2 launch omni slam.launch.py mode:=local stp_config:=t265
```
```
ros2 launch omni slam.launch.py mode:=local stp_config:=stella_vslam
```
```
ros2 launch omni slam.launch.py mode:=local stp_config:=open_vins
```


T4:
```
ros2 launch nav2_bringup navigation_launch.py map:=/home/silenzio/ros2_ws/src/omni/maps/flat_map.yaml
```

T5:
```
ros2 launch slam_toolbox online_async_launch.py
```



