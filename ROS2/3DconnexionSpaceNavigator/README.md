## Nindendo wiimote plus install:

```
git clone https://github.com/ros-drivers/joystick_drivers.git
```

```
cp ~/lib/wiimote ~/ros2_ws/src
cp ~/lib/wiimote_msgs ~/ros2_ws/src
```

```
colcon build --packages-select wiimote_msgs
```

```
colcon build --packages-select wiimote
```
### error:
- "bluetooth library not found"

### Install Bluetooth development libraries:
```
sudo apt update
sudo apt install libbluetooth-dev
```

### error:
- "cwiid library not found"

```
sudo apt update
sudo apt install libcwiid-dev
sudo ldconfig
```

### works

__________


## 3Dconnexion SpaceNavigator ROS2 driver install:

https://github.com/ros-drivers/joystick_drivers/tree/ros2/spacenav


```
$ cd ~/lib/
```

```
git clone https://github.com/ros-drivers/joystick_drivers.git
```

```
Cloning into 'joystick_drivers'...
remote: Enumerating objects: 3365, done.
remote: Counting objects: 100% (394/394), done.
remote: Compressing objects: 100% (130/130), done.
remote: Total 3365 (delta 327), reused 264 (delta 264), pack-reused 2971 (from 2)
Receiving objects: 100% (3365/3365), 812.13 KiB | 3.49 MiB/s, done.
Resolving deltas: 100% (2040/2040), done.
```
```
silenzio@ubuntuPC:~/lib$ rosdep install --from-paths /home/silenzio/lib/joystick_drivers/spacenav
```
```
executing command [sudo -H apt-get install libspnav-dev]
[sudo] password for silenzio: 
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages were automatically installed and are no longer required:
...
Use 'sudo apt autoremove' to remove them.
The following NEW packages will be installed:
  libspnav-dev
0 upgraded, 1 newly installed, 0 to remove and 784 not upgraded.
Need to get 13.9 kB of archives.
After this operation, 81.9 kB of additional disk space will be used.
Get:1 http://us.archive.ubuntu.com/ubuntu jammy/universe amd64 libspnav-dev amd64 0.2.3-1 [13.9 kB]
Fetched 13.9 kB in 0s (28.0 kB/s)       
Selecting previously unselected package libspnav-dev.
(Reading database ... 403867 files and directories currently installed.)
Preparing to unpack .../libspnav-dev_0.2.3-1_amd64.deb ...
Unpacking libspnav-dev (0.2.3-1) ...
Setting up libspnav-dev (0.2.3-1) ...
executing command [sudo -H apt-get install spacenavd]
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
...
Use 'sudo apt autoremove' to remove them.
The following NEW packages will be installed:
  spacenavd
0 upgraded, 1 newly installed, 0 to remove and 784 not upgraded.
Need to get 35.6 kB of archives.
After this operation, 116 kB of additional disk space will be used.
Get:1 http://us.archive.ubuntu.com/ubuntu jammy/universe amd64 spacenavd amd64 0.7.1-1 [35.6 kB]
Fetched 35.6 kB in 0s (82.9 kB/s)   
Selecting previously unselected package spacenavd.
(Reading database ... 403886 files and directories currently installed.)
Preparing to unpack .../spacenavd_0.7.1-1_amd64.deb ...
Unpacking spacenavd (0.7.1-1) ...
Setting up spacenavd (0.7.1-1) ...
Created symlink /etc/systemd/system/graphical.target.wants/spacenavd.service → /lib/systemd/system/spacenavd.service.
Processing triggers for man-db (2.10.2-1) ...
#All required rosdeps installed successfully
```

```
cp ~/lib/spacenav ~/ros2_ws/src
```

```
cd ~/ros2_ws
colcon build --packages-select spacenav
```

```
cd ~/ros2_ws && source install/setup.bash
```

```
ros2 run spacenav spacenav_node
```

```
$ ros2 topic list
/parameter_events
/rosout
/spacenav/joy
/spacenav/offset
/spacenav/rot_offset
/spacenav/twist
/tf
/tf_static
```



### Spacenav Node
### Published topics
* `spacenav/offset` (geometry_msgs/msg/Vector3)

   Publishes the linear component of the joystick's position. Approximately normalized to a range of -1 to 1.
* `spacenav/rot_offset`(geometry_msgs/msg/Vector3)

   Publishes the angular component of the joystick's position. Approximately normalized to a range of -1 to 1.
* `spacenav/twist` (geometry_msgs/msg/Twist)

   Combines offset and rot_offset into a single message.
* `spacenav/joy` (sensor_msgs/msg/Joy)

   Outputs the spacenav's six degrees of freedom and its buttons as a joystick message.

### Parameters
   sets values to zero when the spacenav is not moving
* `zero_when_static` (boolean, default: true)
* `static_count_threshold` (int, default: 30)

   The number of polls needed to be done before the device is considered "static"
* `static_trans_deadband` (float, default: 0.1)

   sets the translational deadband
* `static_rot_deadband` (float, default: 0.1)

   sets the rotational deadband
* `linear_scale/x` (float, default: 1)
* `linear_scale/y` (float, default: 1)
* `linear_scale/z` (float, default: 1)

   sets the scale of the linear output
* `angular_scale/x` (float, default: 1)
* `angular_scale/y` (float, default: 1)
* `angular_scale/z` (float, default: 1)
   sets the scale of the angular output

### Running the spacenav node

Running the node is straightforward
```
$ ros2 run spacenav spacenav_node
```
The node is now publishing to the topics listed above.

