
### Setup:

Stella_vslam_ros launch file:

~/ros2_ws/src/stella_vslam_ros/launch/slam.launch
```
<?xml version="1.0"?>
<launch>
    <node name="stella_vslam_ros" pkg="stella_vslam_ros" exec="run_slam" 
        args="--viewer none -v /home/silenzio/lib/stella_vslam/vocab/orb_vocab.fbow \
        -c /home/silenzio/lib/stella_vslam/example/tum_vi/T265_mono.yaml \
        -map-db /home/silenzio/ros2_ws/src/omni/map/stella_vslam/map.msg \
        --ros-args -p use_sim_time:=false \
        --ros-args -p publish_tf:=true \
        --ros-args -p odom_frame:=stella_odom_frame \
        --ros-args -p camera_frame:=stella_camera_frame \
        --ros-args -p map_frame:=odom_frame
        " output="screen">
     <remap from="/camera/image_raw" to="/T265/fisheye1/image_raw"/>
     <remap from="/stella_vslam_ros/camera_pose" to="/camera_pose"/>
    </node>
</launch>
```


_______
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

_______

### Graphics:

<img src="Stella_odom_frame_01.png" title="" width="800">

<img src="Stella_odom_tf_tree.png" title="" width="1000">

<img src="Stella_odom_nodes.png" title="" width="1000">




