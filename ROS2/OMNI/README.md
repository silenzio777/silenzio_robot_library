## Run:


### UbuntuPC as RVIZ2 host:

UbuntuPC:

### Joystick teleop

T0:
```
ros2 launch teleop_twist_joy teleop-launch.py
```


T1:
```
ros2 launch omni slam.launch.py mode:=map stp_config:=t265 wheel_driver_run:=pc
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

T2:
```
ros2 run omni mecanum_wheel_driver
```




_______

### Jetson NX as RVIZ2 host:

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
In RVIZ2 open "SlamToolboxPlugin" panel. 
And fill the field ot name "flat" as exapmple:
```
Save Map: /home/silenzio/ros2_ws/src/omni/maps/flat
Serialize map:/home/silenzio/ros2_ws/src/omni/maps/flat
Deserialize map:/home/silenzio/ros2_ws/src/omni/maps/flat
```
Push this 3 buttons.

Map will be save at files :
```
flat.pgm
flat.yaml
flat.data
flat.posegraph
```
in dir /home/silenzio/ros2_ws/src/omni/maps/flat

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

### Launch navigation with saved map:

T3:
```
ros2 launch nav2_bringup navigation_launch.py map:=/home/silenzio/ros2_ws/src/omni/maps/flat.yaml
```







