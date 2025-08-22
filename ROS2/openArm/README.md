
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
<img width="2879" height="1679" alt="image" src="https://github.com/user-attachments/assets/b9234b6f-1c4f-4ebc-b8b2-ec7d19984b3b" />


`Display single arm without end-effector
```
ros2 launch openarm_description display_openarm.launch.py arm_type:=v10 bimanual:=false ee_type:=none
```
<img width="2879" height="1679" alt="image" src="https://github.com/user-attachments/assets/bd4c57fd-5cb0-4d44-a75a-fd12f83c68b0" />


Xacro Structure
The package follows a hierarchical xacro structure with the following organization.

Robot (Overarching Structure)
robot/openarm_robot.xacro - Main robot macro that orchestrates all components
robot/v10.urdf.xacro - Entry point for v1.0 arm configuration
Component Structure
arm/ - Arm kinematics, joints, and links
openarm_arm.xacro - Arm assembly
openarm_macro.xacro - Arm macro definitions
body/ - Robot base/body components
openarm_body.xacro - Body assembly
openarm_body_macro.xacro - Body macro definitions
ee/ - End-effector components
openarm_hand.xacro - OpenArm hand gripper
openarm_hand_macro.xacro - Hand macro definitions
ee_with_one_link.xacro - Simple single-link end-effector
ros2_control/ - ROS2 Control with hardware interfaces
openarm.ros2_control.xacro - Single arm control interface
openarm.bimanual.ros2_control.xacro - Bimanual control interface
Configuration Files
config/arm/v10/ - v1.0 arm parameters (kinematics, limits, inertials)
config/body/v10/ - v1.0 body parameters
config/hand/openarm_hand/ - Hand configuration



Available Arguments

Below are some configurable variables for the OpenArm robot description that allows customization when generating URDFs with xacro.

Core Arguments

- arm_type - Arm version (eg.: "v10")
- body_type - Body version (eg.: "v10")
- ee_type - End-effector type (default: "openarm_hand", options: "openarm_hand", "none")
- bimanual - Enable bimanual configuration (default: false)


ROS2 Control Arguments
```
ros2_control - Enable ROS2 control hardware interface (default: false)
use_fake_hardware - Use fake hardware for simulation (default: false)
fake_sensor_commands - Enable fake sensor commands (default: false)
can_interface - CAN interface for single arm (default: "can0")
left_can_interface - CAN interface for left arm in bimanual setup (default: "can1")
right_can_interface - CAN interface for right arm in bimanual setup (default: "can0")
```

Positioning Arguments
```
parent - Parent frame (default: "world")
xyz - Position offset (default: "0 0 0")
rpy - Orientation offset (default: "0 0 0")
left_arm_base_xyz - Left arm base position (default: "0.0 0.031 0.698")
left_arm_base_rpy - Left arm base orientation (default: "-1.5708 0 0")
right_arm_base_xyz - Right arm base position (default: "0.0 -0.031 0.698")
right_arm_base_rpy - Right arm base orientation (default: "1.5708 0 0")
```


