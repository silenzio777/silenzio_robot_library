
### apriltag_ros

https://github.com/christianrauch/apriltag_ros


### Run:

Standalone Executable
The apriltag_node executable can be launched with topic remappings and a configuration file:

```
ros2 run apriltag_ros apriltag_node --ros-args \
    -r image_rect:=/camera/image \
    -r camera_info:=/camera/camera_info \
    --params-file /home/silenzio/ros2_ws/install/share/apriltag_ros/cfg/tags_36h11.yaml
```

```
ros2 run apriltag_ros apriltag_node --ros-args -r image_rect:=/T265/fisheye1/image_raw -r camera_info:=/T265/fisheye1/camera_info --params-file /home/silenzio/ros2_ws/src/apriltag_ros/cfg/tags_36h11.yaml
```
