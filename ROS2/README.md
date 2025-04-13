
- [JetsonOrin NX](JetsonOrinNX16Gb/README.md)<br/>
- [UbuntuPC](UbuntuPC)<br/>
- [DDSConfig](#ddsconfig)<br/>
- [teleop_keyboard](#turtlebot3-turtlebot3-teleop-teleop-keyboard)<br/>



## ROS2 command:
```
nano ~/.bashrc
source ~/.bashrc

source /opt/ros/$ROS_DISTRO/setup.bash
source /opt/ros/humble/setup.bash
cd ~/ros2_ws && source install/setup.bash

colcon_cd

colcon build

rqt_graph

ros2 topic list
ros2 topic list -t

ros2 topic info /cmd_vel -v

ros2 topic echo odom --no-arr

ros2 run tf2_tools view_frames

ros2 topic hz /camera/color/image_raw

ros2 doctor --report | grep middleware


## PACKAGES:

## Lidar lfcd_lds:
sudo chmod a+rw /dev/ttyUSB0
ros2 launch hls_lfcd_lds_driver hlds_laser.launch.py

## Turtlebot3 teleop:

ros2 run turtlebot3_teleop teleop_keyboard

## REMAP:
##ros2 run demo_nodes_cpp listener --ros-args --remap /chatter:=/alt_chatter

--ros-args --remap /odom:=/T265/pose/sample 

## Publisher:
ros2 run tf2_ros static_transform_publisher 0 0 0 0 0 0 1 base_link camera_link
ros2 run tf2_ros static_transform_publisher 0.1 0 0.2 0 0 0 base_link base_laser


ros2 run tf2_ros tf2_echo base_link base_laser

At time 0.0
- Translation: [0.100, 0.000, 0.200]
- Rotation: in Quaternion [0.000, 0.000, 0.000, 1.000]

ros2 run py_pubsub publisher_member_function
ros2 run py_pubsub subscriber_member_function

ros2 run csi_cam_opencv impub
ros2 run csi_cam_opencv imsubs

sudo apt install ros-${ROS_DISTRO}-rqt*
rqt
ros2 run <plugin_name> <plugin_name>  # i.e. ros2 run rqt_graph rqt_graph
ros2 run rqt_console rqt_console
ros2 run rqt_reconfigure rqt_reconfigure
ros2 run rqt_image_view rqt_image_view
ros2 run rqt_graph rqt_graph
ros2 run rqt_tf_tree rqt_tf_tree
ros2 run rqt_joint_trajectory_controller rqt_joint_trajectory_controller

sudo apt install ros-humble-moveit

```
__________

## Ubuntu PC ROS2 humble info:
```
dpkg -s ros-humble-ros2cli
Package: ros-humble-ros2cli
Status: install ok installed
Priority: optional
Section: misc
Installed-Size: 205
Maintainer: Aditya Pande <aditya.pande@openrobotics.org>
Architecture: amd64
Version: 0.18.11-1jammy.20241128.015950
Depends: python3-argcomplete, python3-importlib-metadata, python3-netifaces, python3-packaging, python3-pkg-resources, ros-humble-rclpy, ros-humble-ros-workspace
Description: Framework for ROS 2 command line tools.
```
```
ros2 --help
usage: ros2 [-h] [--use-python-default-buffering] Call `ros2 <command> -h` for more detailed usage. ...

ros2 is an extensible command-line tool for ROS 2.

options:
  -h, --help            show this help message and exit
  --use-python-default-buffering
                        Do not force line buffering in stdout and instead use the python default buffering, which might be affected by
                        PYTHONUNBUFFERED/-u and depends on whatever stdout is interactive or not
Commands:
  action     Various action related sub-commands
  bag        Various rosbag related sub-commands
  component  Various component related sub-commands
  control    Various control related sub-commands
  daemon     Various daemon related sub-commands
  doctor     Check ROS setup and other potential issues
  interface  Show information about ROS interfaces
  launch     Run a launch file
  lifecycle  Various lifecycle related sub-commands
  llama      
  multicast  Various multicast related sub-commands
  node       Various node related sub-commands
  param      Various param related sub-commands
  pkg        Various package related sub-commands
  run        Run a package specific executable
  security   Various security related sub-commands
  service    Various service related sub-commands
  test       Run a ROS2 launch test
  topic      Various topic related sub-commands
  wtf        Use `wtf` as alias to `doctor`

  Call `ros2 <command> -h` for more detailed usage.
```
```
ros2 status
usage: ros2 [-h] [--use-python-default-buffering] Call `ros2 <command> -h` for more detailed usage. ...
ros2: error: argument Call `ros2 <command> -h` for more detailed usage.: invalid choice: 'status' (choose from 'action', 'bag', 'component', 'control', 'daemon', 'doctor', 'extension_points', 'extensions', 'interface', 'launch', 'lifecycle', 'llama', 'multicast', 'node', 'param', 'pkg', 'run', 'security', 'service', 'test', 'topic', 'wtf')
```

___________

## Jetson NX ROS2 humble:
```
dpkg -s ros-humble-ros2cli
Package: ros-humble-ros2cli
Status: install ok installed
Priority: optional
Section: misc
Installed-Size: 205
Maintainer: Aditya Pande <aditya.pande@openrobotics.org>
Architecture: arm64
Version: 0.18.12-1jammy.20250326.001744
Depends: python3-argcomplete, python3-importlib-metadata, python3-netifaces, python3-packaging, python3-pkg-resources, ros-humble-rclpy, ros-humble-ros-workspace
Description: Framework for ROS 2 command line tools.
```



__________

### DDSConfig:
- [source link](https://gist.github.com/robosam2003/d5fcfaf4bfd55298d86c1460cb7fc60c)<br/>


# Configuring Cyclone DDS for Wifi + Ethernet connection on an Enterprise Network (for ROS2)

For communication between wifi and ethernet devices, the DDS layer in ROS2 relies on the _multicast_ ability of a given network. 

This is often **disabled** on enterprise networks (at university or work etc) for (I think) security reasons .

To get around this, you have to configure CycloneDDS to comunicate in a **unicast**  manner, and you must specify the local IPs
of all the participants you want to communicate.

_I am using CycloneDDS instead of the default (for ROS2 humble at least) FastDDS, because I ran into lots of issues trying to get topic 
discovery to work properly in a unicast manner._

### ROS2 setup with Cyclone DDS
- Install cyclonedds on your respective ros distro (replace `<ros-distro>` with your ros distribution, e.g. `humble`)
```
sudo apt install ros-$ROS_DISTRO-rmw-cyclonedds-cpp
```
- Switch to cyclone as your ros2 rmw (robot middle ware). I recommend placing this command in your .bashrc, so that it's called every 
time you launch your terminal.
```
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
```
- Add an environment variable to the cyclone configuration xml file (again, add this to your .bashrc)
```
export CYCLONEDDS_URI=/path/to/the/xml/profile
```
- Create a cyclone dds congiguration file called `cyclonedds.xml`, that disables multicast, and specifies the (static) IPs of the
devices in the network
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<CycloneDDS xmlns="https://cdds.io/config" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://cdds.io/config https://raw.githubusercontent.com/eclipse-cyclonedds/cyclonedds/master/etc/cyclonedds.xsd">
    <Domain Id="any">
        <General>
            <Interfaces>
                <NetworkInterface autodetermine="true" priority="default" />
            </Interfaces>
            <AllowMulticast>false</AllowMulticast>
            <MaxMessageSize>65500B</MaxMessageSize>
        </General>
        <Discovery>
            <EnableTopicDiscoveryEndpoints>true</EnableTopicDiscoveryEndpoints>
        <ParticipantIndex>auto</ParticipantIndex>
        <MaxAutoParticipantIndex>50</MaxAutoParticipantIndex>
            <Peers>
                <Peer Address="192.30.58.232"/>
                <Peer Address="143.167.46.22"/>
                <Peer Address="143.167.47.43"/>
            </Peers>
        </Discovery>
        <Internal>
            <Watermarks>
                <WhcHigh>500kB</WhcHigh>
            </Watermarks>
        </Internal>
    </Domain>
</CycloneDDS>
```

Now, even on an enterprise network, you can communicate with ROS2 between wifi and ethernet based devices. Enjoy /:) 


_____________


## Ubuntu PC ROS2 humble:
```
nano ~/.ros/cyclonedds.xml
export CYCLONEDDS_URI=~/.ros/cyclonedds.xml
```
```
<?xml version="1.0" encoding="UTF-8" ?>
<CycloneDDS xmlns="https://cdds.io/config" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://cdds.io/config https:>
    <Domain Id="any">
        <General>
            <Interfaces>
                <NetworkInterface autodetermine="true" priority="default" />
            </Interfaces>
            <AllowMulticast>false</AllowMulticast>
            <MaxMessageSize>65500B</MaxMessageSize>
        </General>
        <Discovery>
            <EnableTopicDiscoveryEndpoints>true</EnableTopicDiscoveryEndpoints>
        <ParticipantIndex>auto</ParticipantIndex>
        <MaxAutoParticipantIndex>50</MaxAutoParticipantIndex>
            <Peers>
                <Peer Address="192.168.JN.IP"/>
                <Peer Address="192.168.PC.IP"/>
                <!--Peer Address="172.17.0.1"/-->
            </Peers>
        </Discovery>
        <Internal>
            <Watermarks>
                <WhcHigh>500kB</WhcHigh>
            </Watermarks>
        </Internal>
    </Domain>
</CycloneDDS>

```

## Jetson NX ROS2 humble:
```
nano ~/.ros/cyclonedds.xml
export CYCLONEDDS_URI=~/.ros/cyclonedds.xml
```

```
<?xml version="1.0" encoding="UTF-8" ?>
<CycloneDDS xmlns="https://cdds.io/config" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="h>
    <Domain Id="any">
        <General>
            <Interfaces>
                <NetworkInterface autodetermine="true" priority="default" />
            </Interfaces>
            <!--NetworkInterfaceAddress>lo</NetworkInterfaceAddress-->
            <AllowMulticast>false</AllowMulticast>
            <MaxMessageSize>65500B</MaxMessageSize>
        </General>
        <Discovery>
            <EnableTopicDiscoveryEndpoints>true</EnableTopicDiscoveryEndpoints>
        <ParticipantIndex>auto</ParticipantIndex>
        <MaxAutoParticipantIndex>50</MaxAutoParticipantIndex>
            <Peers>
                <Peer Address="192.168.PC.IP"/>
                <Peer Address="192.168.JN.IP"/>
                <!--Peer Address="172.17.0.1"/-->
            </Peers>
        </Discovery>
        <Internal>
            <Watermarks>
                <WhcHigh>500kB</WhcHigh>
            </Watermarks>
        </Internal>
    </Domain>
</CycloneDDS>
```

## Jetson NX ROS2 foxy docker:
```
nano ~/.ros/cyclonedds_foxy.xml
export CYCLONEDDS_URI=/.ros/cyclonedds_foxy.xml
```

```
<?xml version="1.0" encoding="UTF-8" ?>
<CycloneDDS xmlns="https://cdds.io/config" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLoca>
    <Domain Id="any">
        <General>
            <!--Interfaces>
                <NetworkInterface autodetermine="true" priority="default" />
            </Interfaces-->
            <!--NetworkInterfaceAddress>lo</NetworkInterfaceAddress-->
            <AllowMulticast>false</AllowMulticast>
            <MaxMessageSize>65500B</MaxMessageSize>
        </General>
        <Discovery>
                <!--EnableTopicDiscoveryEndpoints>true</EnableTopicDiscoveryEndpoints-->
        <ParticipantIndex>auto</ParticipantIndex>
        <MaxAutoParticipantIndex>50</MaxAutoParticipantIndex>
            <Peers>
                <Peer Address="192.168.PC.IP"/>
                <Peer Address="192.168.JN.IP"/>
                <Peer Address="172.17.0.1"/>
            </Peers>
        </Discovery>
        <Internal>
            <Watermarks>
                <WhcHigh>500kB</WhcHigh>
            </Watermarks>
        </Internal>
    </Domain>

```

### turtlebot3 turtlebot3_teleop teleop_keyboard

teleop_keyboard node cannot be launched from a launch file, including .launch.py. If you try doing that, you will get an error (in Linux) termios.error: (25, 'Inappropriate ioctl for device').
```
silenzio@ubuntuPC:~/ros2_ws$ ros2 launch omni key_teleop.launch.py
[INFO] [launch]: All log files can be found below /home/silenzio/.ros/log/2025-03-31-14-38-16-258718-ubuntuPC-5551
[INFO] [launch]: Default logging verbosity is set to INFO
[INFO] [key_teleop-1]: process started with pid [5552]
[key_teleop-1] Traceback (most recent call last):
[key_teleop-1]   File "/home/silenzio/ros2_ws/install/omni/lib/omni/key_teleop", line 33, in <module>
[key_teleop-1]     sys.exit(load_entry_point('omni==0.0.0', 'console_scripts', 'key_teleop')())
[key_teleop-1]   File "/home/silenzio/ros2_ws/install/omni/lib/python3.10/site-packages/omni/key_teleop.py", line 141, in main
[key_teleop-1]     settings = termios.tcgetattr(sys.stdin)
[key_teleop-1] termios.error: (25, 'Inappropriate ioctl for device')
[ERROR] [key_teleop-1]: process has died [pid 5552, exit code 1, cmd '/home/silenzio/ros2_ws/install/omni/lib/omni/key_teleop --ros-args -r __node:=key_teleop'].
```
The error above because teleop_keyboard.py needs direct access to TTY STDIN device in order to capture keyboard strokes.
### Fix:

```
silenzio@ubuntuPC:~/ros2_ws$ ros2 run omni key_teleop

Control Your TurtleBot3!
---------------------------
Moving around:
        w
   a    s    d
        x

w/x : increase/decrease linear velocity (Burger : ~ 0.22, Waffle and Waffle Pi : ~ 0.26)
a/d : increase/decrease angular velocity (Burger : ~ 2.84, Waffle and Waffle Pi : ~ 1.82)

space key, s : force stop

CTRL-C to quit
```


_______
```
apt-cache showpkg ros-humble-ros2cli

Package: ros-humble-ros2cli
Versions: 
0.18.12-1jammy.20250326.001744 (/var/lib/apt/lists/packages.ros.org_ros2_ubuntu_dists_jammy_main_binary-arm64_Packages) (/var/lib/dpkg/status)
 Description Language: 
                 File: /var/lib/apt/lists/packages.ros.org_ros2_ubuntu_dists_jammy_main_binary-arm64_Packages
                  MD5: 0cc181a105f94f9956a32747924d8891
Reverse Depends: 

ros-humble-fogros2,ros-humble-ros2cli
  ros-humble-topic-tools,ros-humble-ros2cli
  ros-humble-system-fingerprint,ros-humble-ros2cli
  ros-humble-swri-cli-tools,ros-humble-ros2cli
  ros-humble-sros2-cmake,ros-humble-ros2cli
  ros-humble-sros2,ros-humble-ros2cli
  ros-humble-ros2trace-analysis,ros-humble-ros2cli
  ros-humble-ros2trace,ros-humble-ros2cli
  ros-humble-ros2topic,ros-humble-ros2cli
  ros-humble-ros2test,ros-humble-ros2cli
  ros-humble-ros2service,ros-humble-ros2cli
  ros-humble-ros2run,ros-humble-ros2cli
  ros-humble-ros2pkg,ros-humble-ros2cli
  ros-humble-ros2param,ros-humble-ros2cli
  ros-humble-ros2nodl,ros-humble-ros2cli
  ros-humble-ros2node,ros-humble-ros2cli
  ros-humble-ros2multicast,ros-humble-ros2cli
  ros-humble-ros2lifecycle,ros-humble-ros2cli
  ros-humble-ros2launch,ros-humble-ros2cli
  ros-humble-ros2interface,ros-humble-ros2cli
  ros-humble-ros2doctor,ros-humble-ros2cli
  ros-humble-ros2controlcli,ros-humble-ros2cli
  ros-humble-ros2component,ros-humble-ros2cli
  ros-humble-ros2cli-common-extensions,ros-humble-ros2cli
  ros-humble-ros2caret,ros-humble-ros2cli
  ros-humble-ros2bag,ros-humble-ros2cli
  ros-humble-ros2action,ros-humble-ros2cli
  ros-humble-ros2acceleration,ros-humble-ros2cli
  ros-humble-nodl-to-policy,ros-humble-ros2cli
  ros-humble-leo-fw,ros-humble-ros2cli
  ros-humble-lanelet2-examples,ros-humble-ros2cli
```

```
sudo apt install ros-$ROS_DISTRO-ros2topic
sudo apt install ros-$ROS_DISTRO-ros2action
sudo apt install ros-$ROS_DISTRO-ros2component
sudo apt install ros-$ROS_DISTRO-ros2doctor
sudo apt install ros-$ROS_DISTRO-ros2interface
sudo apt install ros-$ROS_DISTRO-ros2lifecycle
sudo apt install ros-$ROS_DISTRO-ros2multicast
...sudo apt install ros-$ROS_DISTRO-ros2security
sudo apt install ros-$ROS_DISTRO-ros2test
```

### rviz_2d_overlay_plugins:

screenshot_vel_overlay.png

Install the plugin:
```
sudo apt install ros-humble-rviz-2d-overlay-plugins
```

Then publish a message: 

this for text overlay: 
https://github.com/teamspatzenhirn/rviz_2d_overlay_plugins/blob/main/rviz_2d_overlay_msgs/msg/OverlayText.msg

this for gauge overlay: 

https://github.com/ros2/common_interfaces/blob/rolling/std_msgs/msg/Float32.msg

then select the topics in rviz

## Use: 
https://github.com/teamspatzenhirn/rviz_2d_overlay_plugins/tree/main/rviz_2d_overlay_plugins#using-a-string-topic

### Alignment and Positioning
To allow easy positioning of the overlay along the edges of the rviz window, and to support multiple/dynamic window sizes, the position is given by offsets from the respective border. Depending on whether the horizontal_alignment is LEFT, RIGHT or CENTER, the horizontal_distance field sets the distance to the left or right border, or the offset from center.

For LEFT and RIGHT alignment, a distance of zero means that the text is aligned to the border without any gap, a positive distance moves the overlay towards the center.

For CENTER alignment, a distance of zero means completely centered, positive values move the overlay towards the bottom right of the window.

TOP and BOTTOM for the vertical alignment work just like LEFT and RIGHT in the horizontal case.


### Using a string topic
A simple coverter node (rviz2d_from_string_node) is provided which can covert std_msgs/msg/String to rviz_2d_overlay_msgs/msg/OverlayText. The working principle is simple, it subscribes to a String topic, publishes the content as an OverlayText and the other proeries can be set from ROS parameters or by overtaking it in RViz2.

A launch file which runs this node and sets the parameters may look something like:

```
from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        Node(
            package='rviz_2d_overlay_plugins',
            executable='string_to_overlay_text',
            name='string_to_overlay_text_1',
            output='screen',
            parameters=[
                {"string_topic": "chatter"},
                {"fg_color": "b"}, # colors can be: r,g,b,w,k,p,y (red,green,blue,white,black,pink,yellow)
            ],
        ),
    ])
```

In case a /chatter topic is needed this can be published with a single command:

```
ros2 topic pub /chatter std_msgs/String "data: Hello world"
```


### Circular Gauge Overlay
Screenshot showing the PieChartDisplay, a circular gauge

screenshot_PieChartDisplay.png

The PieChartDisplay is a rather boring pie chart, as it only displays a single value. PieChartDisplay and "Circular Gauge" are used synonymously in this package. The gauge allows displaying a std_msgs/Float32 - https://github.com/ros2/common_interfaces/blob/rolling/std_msgs/msg/Float32.msg

Formatting and positioning, as well as setting the maximum value is only possible in the display options inside rviz.
