### Logitech Cordless RumblePad 2 driver for ROS2 humble

<img src="LogitechCordlessRumblePad_2_front.png" title="LogitechCordlessRumblePad_2_front" width="461">

<img src="LogitechCordlessRumblePad_2_back.png" title="LogitechCordlessRumblePad_2_front" width="461">

## Ubuntu PC

```
ls /dev/input/js0
```
```
/dev/input/js0
```

```
sudo dmesg
```
```
...
 2348.847108] usb 1-8: new low-speed USB device number 4 using xhci_hcd
[ 2349.036631] usb 1-8: New USB device found, idVendor=046d, idProduct=c219, bcdDevice= 2.00
[ 2349.036635] usb 1-8: New USB device strings: Mfr=3, Product=1, SerialNumber=0
[ 2349.036637] usb 1-8: Product: Logitech Cordless RumblePad 2
[ 2349.036638] usb 1-8: Manufacturer: Logitech
[ 2349.090665] input: Logitech Logitech Cordless RumblePad 2 as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/0003:046D:C219.0005/input/input23
[ 2349.090800] logitech 0003:046D:C219.0005: input,hidraw4: USB HID v1.10 Gamepad [Logitech Logitech Cordless RumblePad 2] on usb-0000:00:14.0-8/input0
[ 2349.090805] hid_logitech: Force feedback for Logitech force feedback devices by Johann Deneux <johann.deneux@it.uu.se>
```

```
ros2 run joy joy_enumerate_devices
```
```
ID : GUID                             : GamePad : Mapped : Joystick Device Name
-------------------------------------------------------------------------------
 0 : 030000006d04000019c2000010010000 :    true :   true : Logitech Cordless RumblePad 2
```

Run:

```
ros2 run joy joy_node
```
```
[INFO] [1743585994.034319024] [joy_node]: Opened joystick: Logitech Cordless RumblePad 2.  deadzone: 0.050000
```
```
ros2 topic echo joy
```
```
header:
  stamp:
    sec: 1743586634
    nanosec: 892524077
  frame_id: joy
axes:
- -0.0257849283516407
- -0.0
- -0.0
- -0.0
- 0.0
- 0.0
buttons:
- 0
- 0
- 0
- 0
- 0
- 0
- 0
- 0
- 0
- 0
- 0
- 0
---
```
_____

### ros2/teleop_twist_joy

https://github.com/ros2/teleop_twist_joy/tree/humble

The purpose of this package is to provide a generic facility for tele-operating Twist-based ROS 2 robots with a standard joystick. It converts joy messages to velocity commands.
This node provides no rate limiting or autorepeat functionality. It is expected that you take advantage of the features built into joy for this.

Executables:
The package comes with the teleop_node that republishes sensor_msgs/msg/Joy messages as scaled geometry_msgs/msg/Twist messages. The message type can be changed to geometry_msgs/msg/TwistStamped by the publish_stamped_twist parameter.

Subscribed Topics:
- joy (sensor_msgs/msg/Joy)
   - Joystick messages to be translated to velocity commands.
 
Published Topics:

- cmd_vel (geometry_msgs/msg/Twist or geometry_msgs/msg/TwistStamped)
   - Command velocity messages arising from Joystick commands.


Install:
```
sudo apt-get install ros-$ROS_DISTRO-teleop-twist-joy
```

Run:
A launch file has been provided which has three arguments which can be changed in the terminal or via your own launch file. To configure the node to match your joystick a config file can be used. There are several common ones provided in this package (atk3, ps3-holonomic, ps3, xbox, xd3), located here: https://github.com/ros2/teleop_twist_joy/tree/humble/config.

PS3 is default, to run for another config (e.g. xbox) use this:
```
ros2 launch teleop_twist_joy teleop-launch.py joy_config:='xbox'
```
Note: this launch file also launches the joy node so do not run it separately.

Arguments:

- joy_config (string, default: 'ps3')
   - Config file to use
- joy_dev (string, default: '0')
   - Joystick device to use
- config_filepath (string, default: '/opt/ros/<rosdistro>/share/teleop_twist_joy/config/' + LaunchConfig('joy_config') + '.config.yaml')
   - Path to config files
- publish_stamped_twist (bool, default: false)
  - Whether to publish geometry_msgs/msg/TwistStamped for command velocity messages.


### RUN:

Create file /opt/ros/humble/share/teleop_twist_joy/config/lg.config.yaml
```
# Logitech Cordless RumblePad 2
teleop_twist_joy_node:
  ros__parameters:
    axis_linear:  # Forward/Back
      x: -1
      y: 1
    scale_linear:
      y: 1.0
    scale_linear_turbo:
      y: 1.5

    axis_angular:  # Twist
      yaw: 0
    scale_angular:
      yaw: 1.0
    scale_angular_turbo:
      yaw: 1.0
    enable_button: 8  # Trigger
    enable_turbo_button: 10  # Button 2 aka thumb button
    require_enable_button: false
```

### Launch node:

T1:

```
ros2 launch teleop_twist_joy teleop-launch.py
```

```
[INFO] [launch]: All log files can be found below /home/silenzio/.ros/log/2025-04-02-15-32-04-071407-ubuntuPC-14596
[INFO] [launch]: Default logging verbosity is set to INFO
[INFO] [joy_node-1]: process started with pid [14597]
[INFO] [teleop_node-2]: process started with pid [14599]
[teleop_node-2] [INFO] [1743597124.133094962] [TeleopTwistJoy]: Turbo on button 10.
[teleop_node-2] [INFO] [1743597124.133129732] [TeleopTwistJoy]: Linear axis y on 1 at scale 1.000000.
[teleop_node-2] [INFO] [1743597124.133136544] [TeleopTwistJoy]: Turbo for linear axis y is scale 1.500000.
[teleop_node-2] [INFO] [1743597124.133140089] [TeleopTwistJoy]: Angular axis yaw on 0 at scale 1.000000.
[teleop_node-2] [INFO] [1743597124.133143190] [TeleopTwistJoy]: Turbo for angular axis yaw is scale 1.000000.
[joy_node-1] [INFO] [1743597124.448226776] [joy_node]: Opened joystick: Logitech Cordless RumblePad 2.  deadzone: 0.20000
```

```
ros2 topic echo /cmd_vel
```
```
---
linear:
  x: 0.0
  y: -0.3235190808773041
  z: 0.0
angular:
  x: 0.0
  y: 0.0
  z: 0.10786767303943634
```





_____
_____


### Joy2Twist

Dockerized ROS node allowing control of ROS-powered mobile robots with Logitech F710 gamepad. Joy2Twist node is converting sensor_msgs/Joy message to geometry_msgs/Twist or geometry_msgs/TwistStamped in order to provide velocity commands for the mobile robot. Therefore this package is compliant (but not supported by Husarion) with any other gamepad controller which is able to publish the sensor_msgs/Joy message.

https://github.com/husarion/joy2twist

<img src="gamepad-legend-panther.png" title="gamepad-legend-panther.png" width="1100">


_________

### Jetson NX
```
sudo dmesg
```
```
...
[ 1480.554675] usb 1-2.3: new low-speed USB device number 6 using tegra-xusb
[ 1480.759887] input: Logitech Logitech Cordless RumblePad 2 as /devices/platform/bus@0/3610000.usb/usb1/1-2/1-2.3/1-2.3:1.0/0003:046D:C219.0002/input/input6
[ 1480.760456] logitech 0003:046D:C219.0002: input,hidraw0: USB HID v1.10 Gamepad [Logitech Logitech Cordless RumblePad 2] on usb-3610000.usb-2.3/input0
[ 1480.795047] logitech: probe of 0003:046D:C219.0002 failed with error -1
```

```
sudo ls -la /dev/input/by-path/
```
```
total 0
drwxr-xr-x 2 root root  80 Jan  1  1970 .
drwxr-xr-x 3 root root 160 Nov 21  2023 ..
lrwxrwxrwx 1 root root   9 Jan  1  1970 platform-3510000.hda-event -> ../event4
lrwxrwxrwx 1 root root   9 Nov 21  2023 platform-gpio-keys-event -> ../event0
```

```
ros2 run joy joy_enumerate_devices
```
```
ID : GUID                             : GamePad : Mapped : Joystick Device Name
-------------------------------------------------------------------------------
```
### FIX:

https://forums.developer.nvidia.com/t/logitech-f710-does-not-show-up-in-dev-input/292637/4

