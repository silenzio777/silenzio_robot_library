
- [JetsonOrin NX](JetsonOrinNX16Gb/README.md)<br/>
- [UbuntuPC](UbuntuPC)<br/>
- [DDSConfig](#ddsconfig)<br/>



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

ros2 topic echo odom --no-arr

ros2 run tf2_tools view_frames

ros2 topic hz /camera/color/image_raw


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
sudo apt install ros-<ros-distro>-rmw-cyclonedds-cpp
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
