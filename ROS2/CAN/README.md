### CAN interface setup:

- [nmap](#nmap)<br/>


https://docs.odriverobotics.com/v/latest/guides/ros-package.html

### Verify these messages are working properly with::

```
candump can0 -xct z -n 10

python3 -m can.viewer -c "can0" -i "socketcan".

```


### Installing the ros_odrive Package:

1. Clone the official ros_odrive repository into the src folder of your ROS2 workspace.
```
~/ros2_ws$ cd src/
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

> [!HINT]
> This example assumes the axis node_id is 0, and the CAN network interface is “can0”. These expected values can be changed in ./launch/example_launch.yaml



> [!NOTE]
> This example assumes the axis node_id is 0, and the CAN network interface is “can0”. These expected values can be changed in ./launch/example_launch.yaml

```
sudo systemctl isolate graphical.target
```
