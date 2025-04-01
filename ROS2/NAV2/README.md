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
