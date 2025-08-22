
https://docs.openarm.dev/software/description/

https://docs.openarm.dev/software/ros2/control
```
cd ~/ros2_ws/src
git clone https://github.com/enactic/openarm_description.git
git clone https://github.com/enactic/openarm_ros2
```

Move "openarm_hardware" and "openarm_bringup" dir from "openarm_ros2" to "cd ~/ros2_ws/src":
```
mv ~/ros2_ws/src/openarm_ros2/openarm_hardware ~/ros2_ws/src
mv ~/ros2_ws/src/openarm_ros2/openarm_bringup ~/ros2_ws/src
```

Buld:
```
colcon build --packages-select openarm_description
colcon build --packages-select openarm_hardware
colcon build --packages-select openarm_bringup
```
