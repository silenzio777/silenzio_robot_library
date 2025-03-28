### CAN interface setup:

- [nmap](#nmap)<br/>


### Install CAN on Jetson Orin NX:
```
sudo apt-get install can-utils

sudo modprobe can

sudo modprobe can_raw

sudo modprobe mttcan
```

### Start interface:
```
sudo ip link set can0 up type can bitrate 500000 dbitrate 1000000 berr-reporting on fd on
```




### Verify these messages are working properly with:

```
candump can0 -xct z -n 10
```
```
python3 -m can.viewer -c "can0" -i "socketcan".

```


### Installing the ros_odrive Package:
[Source link](#[nmap](https://docs.odriverobotics.com/v/latest/guides/ros-package.html))<br/>


1. Clone the official ros_odrive repository into the src folder of your ROS2 workspace.
```
cd ~/ros2_ws/src/
git clone https://github.com/odriverobotics/ros_odrive.git
```

2. Navigate to the top level of the ROS2 workspace folder and run;
```
cd ..
colcon build --packages-select odrive_can
```
3. Source the workspace:
```
source ./install/setup.bash
```
4. Run the example launch file:
```
ros2 launch odrive_can example_launch.yaml
```

You should now have a ROS node running that is ready to relay commands and telemetry between other ROS nodes and the ODrive.

> [!NOTE]
> This example assumes the axis node_id is 0, and the CAN network interface is “can0”. These expected values can be changed in ./launch/example_launch.yaml



> [!NOTE]
> The following commands assume the odrive_can_node is within the namespace odrive_axis0 (set in ./launch/example_launch.yaml).


Once the node is running you can verify everything is setup correctly by running some basic ROS commands in another terminal:

1. Source the workspace (this needs to be done each time you open a new terminal session):

```
source ./install/setup.bash
```
2. Show feedback from the ODrive:

```
ros2 topic echo /odrive_axis0/controller_status
```
```
ros2 topic echo /odrive_axis0/odrive_status
```
3. Request a new state. For example to request CLOSED_LOOP_CONTROL (8):
```
ros2 service call /odrive_axis0/request_axis_state odrive_can/srv/AxisState "{axis_requested_state: 8}"
```
Full list of axis_requested_state codes: AxisState

4. Send setpoints. For example this command requests a velocity of 1.0 turns/s in velocity ramp mode:
```
ros2 topic pub /odrive_axis0/control_message odrive_can/msg/ControlMessage "{control_mode: 2, input_mode: 1, input_pos: 0.0, input_vel: 1.0, input_torque: 0.0}"
```
Full list of control_mode codes: ControlMode

Full list of input_mode codes: InputMode

