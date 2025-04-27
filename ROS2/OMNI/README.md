### Run:

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



T3:
```
ros2 run nav2_map_server map_saver_cli -f ~/andino_map
```

T4:
```
ros2 launch nav2_bringup navigation_launch.py map:=~/ros2_ws/my_map.yaml
```

T5:
```
ros2 launch slam_toolbox online_async_launch.py
```



