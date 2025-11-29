


[https://github.com/user-attachments/assets/0a42dd82-9316-4a5f-aa9e-1be2aab0128e](https://github.com/user-attachments/assets/15b8f646-4ae0-4378-9d57-d59e3aa12946)


__________


<img width="700" height="400" alt="image" src="https://github.com/user-attachments/assets/0cb4daf2-25fb-416e-b8cd-a7e5527b2baf" />

 

https://docs.openarm.dev/software/description/

https://docs.openarm.dev/software/ros2/control

### Clean install:

```
mkdir -p ~/oa_ws/scr
cd ~/oa_ws/src
git clone https://github.com/enactic/openarm_description
git clone https://github.com/enactic/openarm_ros2
git clone https://github.com/enactic/openarm_mujoco_hardware
cd ..
colcon build --symlink-install
```
```
...
Finished <<< openarm_mujoco_hardware [18.2s]
Summary: 6 packages finished [18.5s]
```
```
. install/setup.bash
```

### Add to file:
/home/silenzio/oa_ws/install/openarm_description/share/openarm_description/urdf/ros2_control/openarm.bimanual.ros2_control.xacro

this lines of code:

```
    <!-- Left Arm Hardware Interface -->
    <ros2_control name="openarm_left_hardware_interface" type="system">
        <hardware>
          <plugin>openarm_mujoco_hardware/MujocoHardware</plugin>
          <param name="prefix">left_</param>
          <param name="websocket_port">1337</param>
         ...

    <!-- Right Arm Hardware Interface -->
    <ros2_control name="openarm_right_hardware_interface" type="system">
        <hardware>
          <plugin>openarm_mujoco_hardware/MujocoHardware</plugin>
          <param name="prefix">right_</param>
          <param name="websocket_port">1338</param>
         ...
```


Run in chrome - https://thomasonzhou.github.io/mujoco_anywhere/
```
ros2 launch openarm_bimanual_moveit_config demo.launch.py hardware_type:=mujoco
```

### works
<img src="https://github.com/user-attachments/assets/e6114715-ed4e-43b2-a219-f9e88a5bb2d9" width="700">

______


T1:
```
ros2 launch openarm_bringup openarm.launch.py arm_type:=v10 use_fake_hardware:=true
```

T2:
```
ros2 action send_goal /joint_trajectory_controller/follow_joint_trajectory control_msgs/action/FollowJointTrajectory '{trajectory: {joint_names: ["openarm_joint1", "openarm_joint2", "openarm_joint3", "openarm_joint4", "openarm_joint5", "openarm_joint6", "openarm_joint7"], points: [{positions: [1.15, 1.15, 1.15, 1.15, 1.15, 1.15, 1.15], time_from_start: {sec: 3, nanosec: 0}}]}}'
```

### works

<img src="https://github.com/user-attachments/assets/234b345f-51c7-40e6-9f77-15a73372ffe0" width="700">

_________________


```
cd ~/ros2_ws/src
git clone https://github.com/enactic/openarm_description.git
git clone https://github.com/enactic/openarm_ros2
```

Move "openarm_hardware" and "openarm_bringup" dir from "openarm_ros2" to "cd ~/ros2_ws/src":
```
mv ~/ros2_ws/src/openarm_ros2/openarm_hardware ~/ros2_ws/src
mv ~/ros2_ws/src/openarm_ros2/openarm_bringup ~/ros2_ws/src
mv ~/ros2_ws/src/openarm_ros2/openarm_bimanual_moveit_config ~/ros2_ws/src
```

Build:
```
colcon build --packages-select openarm_description
colcon build --packages-select openarm_hardware
colcon build --packages-select openarm_bringup
colcon build --packages-select openarm_bimanual_moveit_config
```

Generate URDF Files:
```
xacro ~/ros2_ws/src/openarm_description/urdf/robot/v10.urdf.xacro arm_type:=v10 bimanual:=false > ~/ros2_ws/src/openarm_description/urdf/robot/openarm_single.urdf
```
Visualization:

Display single arm with hand
```
ros2 launch openarm_description display_openarm.launch.py arm_type:=v10 bimanual:=false
```
<img width="700" alt="image" src="https://github.com/user-attachments/assets/b9234b6f-1c4f-4ebc-b8b2-ec7d19984b3b" />


Display single arm without end-effector
```
ros2 launch openarm_description display_openarm.launch.py arm_type:=v10 bimanual:=false ee_type:=none
```
<img width="700" alt="image" src="https://github.com/user-attachments/assets/bd4c57fd-5cb0-4d44-a75a-fd12f83c68b0" />

____

Xacro Structure
The package follows a hierarchical xacro structure with the following organization.

Robot (Overarching Structure)
- `robot/openarm_robot.xacro` - Main robot macro that orchestrates all components
- `robot/v10.urdf.xacro` - Entry point for v1.0 arm configuration

Component Structure
- `arm/` - Arm kinematics, joints, and links
- `openarm_arm.xacro` - Arm assembly
- `openarm_macro.xacro` - Arm macro definitions
- `body/` - Robot base/body components
- `openarm_body.xacro` - Body assembly
- `openarm_body_macro.xacro` - Body macro definitions
- `ee/` - End-effector components
- `openarm_hand.xacro` - OpenArm hand gripper
- `openarm_hand_macro.xacro` - Hand macro definitions
- `ee_with_one_link.xacro` - Simple single-link end-effector
- `ros2_control/` - ROS2 Control with hardware interfaces
- `openarm.ros2_control.xacro` - Single arm control interface
- `openarm.bimanual.ros2_control.xacro` - Bimanual control interface

Configuration Files
- `config/arm/v10/` - v1.0 arm parameters (kinematics, limits, inertials)
- `config/body/v10/` - v1.0 body parameters
- `config/hand/openarm_hand/` - Hand configuration


Available Arguments

Below are some configurable variables for the OpenArm robot description that allows customization when generating URDFs with xacro.

Core Arguments

- `arm_type` - Arm version (eg.: "v10")
- `body_type` - Body version (eg.: "v10")
- `ee_type` - End-effector type (default: "openarm_hand", options: "openarm_hand", "none")
- `bimanual` - Enable bimanual configuration (default: false)


ROS2 Control Arguments

- `ros2_control` - Enable ROS2 control hardware interface (default: false)
- `use_fake_hardware` - Use fake hardware for simulation (default: false)
- `fake_sensor_commands` - Enable fake sensor commands (default: false)
- `can_interface` - CAN interface for single arm (default: "can0")
- `left_can_interface` - CAN interface for left arm in bimanual setup (default: "can1")
- `right_can_interface` - CAN interface for right arm in bimanual setup (default: "can0")


Positioning Arguments

- `parent` - Parent frame (default: "world")
- `xyz` - Position offset (default: "0 0 0")
- `rpy` - Orientation offset (default: "0 0 0")
- `left_arm_base_xyz` - Left arm base position (default: "0.0 0.031 0.698")
- `left_arm_base_rpy` - Left arm base orientation (default: "-1.5708 0 0")
- `right_arm_base_xyz` - Right arm base position (default: "0.0 -0.031 0.698")
- `right_arm_base_rpy` - Right arm base orientation (default: "1.5708 0 0")


Getting Started with MoveIt2
To use the MoveIt2 integration:

Switch to the moveit2 branch:
```
cd ~/ros2_ws/src/openarm_ros2
git checkout moveit2
cd ~/ros2_ws && colcon build
source ~/ros2_ws/install/setup.bash
```

Launch the MoveIt2 demo:

```
ros2 launch openarm_bimanual_moveit_config demo.launch.py
```

<img width="700" alt="image" src="https://github.com/user-attachments/assets/6ea9618b-eac3-4442-ac8d-6bf36146e517" />

__

Motion Planning

<img width="700" alt="image" src="https://github.com/user-attachments/assets/3dfe707a-1fe5-4d4f-b104-72fb250fc0fb" />


Target positions can be set in the Joints tab in the MotionPlanning panel on the left. Alternatively, the targets on the arms can be dragged and rotated to a target pose, or the goal state can be selected from a list of preset keypoints under Planning > Goal State

The Planning tab provides a GUI to generate trajectories to reach a goal position. Clicking on Plan to preview the path is recommended.







____________




file - /home/silenzio/ros2_ws/install/openarm_description/share/openarm_description/urdf/ros2_control/openarm.ros2_control.xacro

```
<xacro:macro name="openarm_arm_ros2_control"
         params="arm_type
             can_interface
             use_fake_hardware:=^|true
             fake_sensor_commands:=^|false
             hand:=^|false
             gazebo_effort:=^|false
             arm_prefix:=''
             bimanual:=false
             can_fd:=^|false">
```
__

ros2 launch openarm_bringup openarm.launch.py arm_type:=v10 use_fake_hardware:=true

```
[ros2_control_node-2] [WARN] [1757516679.323199977] [controller_manager]: No real-time kernel detected on this system. See [https://control.ros.org/master/doc/ros2_control/controller_manager/doc/userdoc.html] for details on how to enable realtime scheduling.
```

```
sudo addgroup realtime
sudo usermod -a -G realtime $(whoami)
```

Afterwards, add the following limits to the realtime group in /etc/security/limits.conf:

```
sudo nano /etc/security/limits.conf
```

```
@realtime soft rtprio 99
@realtime soft priority 99
@realtime soft memlock unlimited
@realtime hard rtprio 99
@realtime hard priority 99
@realtime hard memlock unlimited
```

### restart Ubuntu
 

