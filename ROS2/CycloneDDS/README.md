
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
export CYCLONEDDS_URI=~/.ros/cyclonedds.xml
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
nano ~/.ros/cyclonedds.xml
```

Check active network interface:
```
ip -br a | grep UP
```

> enp6s0           UP             192.168.X.XX/XX xxxxxxxxxxxxxx


```xml
<?xml version="1.0" encoding="UTF-8"?>
<CycloneDDS
    xmlns="https://cdds.io/config"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="https://cdds.io/config https://raw.githubusercontent.com/eclipse-cyclonedds/cyclonedds/master/etc/cyclonedds.xsd">
  <Domain id="0">
    <General>
      <Interfaces>
        <NetworkInterface name="enp6s0" />
      </Interfaces>
      <AllowMulticast>false</AllowMulticast>
      <MaxMessageSize>65500B</MaxMessageSize>
    </General>

    <Discovery>
      <ParticipantIndex>auto</ParticipantIndex>
      <MaxAutoParticipantIndex>50</MaxAutoParticipantIndex>
      <Peers>
        <Peer Address="192.168.JN.IP"/>  <!-- Jetson Nano -->
        <Peer Address="192.168.JO.IP"/>  <!-- Jetson Orin NX -->
        <Peer Address="192.168.PC.IP"/>  <!-- Ubuntu PC x86 -->
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

## Jetson Orin NX ROS2 humble:
```
export CYCLONEDDS_URI=~/.ros/cyclonedds.xml
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
nano ~/.ros/cyclonedds.xml
```

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<CycloneDDS
    xmlns="https://cdds.io/config"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="https://cdds.io/config https://raw.githubusercontent.com/eclipse-cyclonedds/cyclonedds/master/etc/cyclonedds.xsd">
    <Domain id="0">
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
             <Peer Address="192.168.JN.IP"/>  <!-- Jetson Nano -->
             <Peer Address="192.168.JO.IP"/>  <!-- Jetson Orin NX -->
             <Peer Address="192.168.PC.IP"/>  <!-- Ubuntu PC x86 -->
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

## Jetson Nano ROS2 foxy:
```
export CYCLONEDDS_URI=~/.ros/cyclonedds.xml
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
nano ~/.ros/cyclonedds.xml
```

```xml
<CycloneDDS
    xmlns="https://cdds.io/config"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="https://cdds.io/config https://raw.githubusercontent.com/eclipse-cyclonedds/cyclonedds/master/etc/cyclonedds.xsd">

  <Domain id="0">
    <General>
      <NetworkInterfaceAddress>auto</NetworkInterfaceAddress>
      <AllowMulticast>false</AllowMulticast>
      <MaxMessageSize>65500B</MaxMessageSize>
    </General>

    <Discovery>
      <ParticipantIndex>auto</ParticipantIndex>
      <MaxAutoParticipantIndex>50</MaxAutoParticipantIndex>
      <Peers>
        <Peer Address="192.168.JN.IP"/>  <!-- Jetson Nano -->
        <Peer Address="192.168.JO.IP"/>  <!-- Jetson Orin NX -->
        <Peer Address="192.168.PC.IP"/>  <!-- Ubuntu PC x86 -->
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


