
<img width="700" height="400" alt="image" src="https://github.com/user-attachments/assets/0cb4daf2-25fb-416e-b8cd-a7e5527b2baf" />


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

Build:
```
colcon build --packages-select openarm_description
colcon build --packages-select openarm_hardware
colcon build --packages-select openarm_bringup
```

Generate URDF Files:
```
xacro ~/ros2_ws/src/openarm_description/urdf/robot/v10.urdf.xacro arm_type:=v10 bimanual:=false > ~/ros2_ws/src/openarm_description/urdf/robot/openarm_single.urdf
```
Visualization:

`Display single arm with hand
```
ros2 launch openarm_description display_openarm.launch.py arm_type:=v10 bimanual:=false
```

`Display single arm without end-effector
```
ros2 launch openarm_description display_openarm.launch.py arm_type:=v10 bimanual:=false ee_type:=none
```

