
### Nav2 Tutorials

The possible independent servers and plugins available are:

- Map Server, to load and store maps
- AMCL, to localize the robot in the map
- Nav2 Planner, to plan a path from A to B around the obstacle inside the environment
- Nav2 Smoother, to smooth out the planned trajectories and make navigation more continuous and feasible
- Nav2 Costmap 2D, to convert sensor data into a costmap representation of the world
- Nav2 Recoveries, to compute recovery behaviors in case of some failure
- Nav2 Core, plugins to enable your own custom algorithms and behaviors


### General Tutorials
[https://docs.nav2.org/tutorials/docs/navigation2_with_slam.html](https://docs.nav2.org/tutorials/index.html)


____

### nonpersistent_voxel_layer
plugin: nav2_costmap_2d/NonPersistentVoxelLayer

ROS2 drop in replacement to the voxel layer which does not persist readings through iterations when ray tracing or map maintenance is undesirable.
https://github.com/SteveMacenski/nonpersistent_voxel_layer

____

### Spatio-Temporal Voxel Layer
https://github.com/SteveMacenski/spatio_temporal_voxel_layer

https://github.com/SteveMacenski/spatio_temporal_voxel_layer/tree/humble

____
### ros2_navigation_stvl
ROS2-based navigation and mapping package using Nav2 and STVL plugin.</br>
https://github.com/mich-pest/ros2_navigation_stvl



_________
### linorobot2
https://github.com/linorobot/linorobot2

linorobot2 is a ROS2 implementation of the linorobot package for building custom robots with 2WD, 4WD, or Mecanum drive configurations. This package provides launch files for Nav2 integration and includes a complete simulation pipeline in Gazebo.



___________
### Using VIO to Augment Robot Odometry

https://docs.nav2.org/tutorials/docs/integrating_vio.html

This tutorial highlights how to setup Visual-Inerial Odometry (VIO) into a Nav2 and ROS 2 based robotics system to augment robot odometry.

...
As of September 2023, the driver out of the box produces the full map->odom->base_link->camera tree on its own. This is since the Pose SDK can produce not only VIO, but loop-closure VSLAM representing the full state estimation TF tree.

We want to be able to fuse in other information such as an external IMU, wheel odometry, GPS, or other sensors into our local or global state estimates, so we need to disable TF publication of map->odom and odom->base_link to be provided by our fused outputs. Especially considering the ZED X camera knows nothing about the nature of the base_link frame. However, if you would like to use the ZED’s state estimate for your entire system without further sensor fusion, you certainly can!


### Setting Up ZED ROS
In order to run VIO alone, we need to do the following:

1. Stop computing VSLAM’s map->odom, TF transform. This part of the TF tree is provided by our global localization solution (e.g. AMCL, GPS, fused global state estimate).

2. Disable VIO’s publication of odom->camera and instead publish nav_msgs/Odometry of the VIO’s pose solution for fusion. By default the zed_wrapper publishes this under the odom topic, but it is recommended to remap this to a non-reserved topic name (for example, camera_odom).

3. Re-configure the ZED Wrapper’s parameters to obtain the best VIO as possible.

- two_d_mode will force the pose tracking to be in 2D dimensions (e.g. X, Y, Yaw) for indoor or 2D applications.

- pos_tracking_enabled will disable or enable pose tracking, if you desire it (and we do here!).

- path_max_count will set the maximum size of the visualization of the pose over time. By default it is infinite. We should make this finite.

qos_depth will set the QoS depth throughout the driver. Set this to 3-5 for all options. 1 may result in dropping of messages in very temporary blibs in compute. 3-5 allows us to buffer a small handful of measurements to process for very short term blibs, but clears them all the same in CPU thrashing situations.

Thus, make the following parameter updates to the zed_wrapper’s default parameters:

```
pos_tracking:
    publish_tf: false # Disables odom -> base_link TF transformation
    publish_map_tf: true # Disables map -> odom TF transformation
    area_memory: false # Disables loop closure computation, but Pose topic for global VSLAM still published (but now pure VIO)

    # Optional optimizations
    two_d_mode: false # Or true, up to you!
    pos_tracking_enabled: true # of course!
    path_max_count: 30
    qos_depth: 5

```

Optionally, remap the zed odom topic to a topic that isn’t reserved or commonly used by other systems. In your ZED launch file add to the node / launch file:
```
remappings=[('odom', 'camera_odom')]
```
