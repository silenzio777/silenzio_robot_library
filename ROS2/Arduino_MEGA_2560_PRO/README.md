
### Arduino Mega 2560 Pro setup on Jetson Orin NX

```
lsusb
Bus 002 Device 002: ID 2109:0822 VIA Labs, Inc. USB3.1 Hub             
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 003: ID 0bda:c822 Realtek Semiconductor Corp. Bluetooth Radio 
Bus 001 Device 004: ID 1a86:7523 QinHeng Electronics CH340 serial converter <<<---------
Bus 001 Device 002: ID 2109:2822 VIA Labs, Inc. USB2.0 Hub             
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```
```
ls /dev/ttyCH34*
...
```
### FIX:

STEP 1.

Install ch341 linux serial driver

Get here:

https://github.com/WCHSoftGroup/ch341ser_linux

Or here:

[ch341ser_linux-main.zip](/ROS2/Arduino_MEGA_2560_PRO/ch341ser_linux-main.zip)<br/>


```
cd ~/lib
git clone https://github.com/WCHSoftGroup/ch341ser_linux.git
cd driver/
sudo make install
sudo ldconfig 
```

```
Type "sudo make load" or "sudo insmod ch341.ko" to load the driver dynamically
Type "sudo make unload" or "sudo rmmod ch341.ko" to unload the driver
Type "sudo make install" to make the driver work permanently
Type "sudo make uninstall" to remove the driver
```

STEP 2.

~~For me it looks like the brltty driver is getting in the way. I don't have any sight problems myself and don't need a brail device. To fix I simply:~~

~~sudo apt-get autoremove brltty~~

~~And the next time I plugged in the ch340 it worked perfectly.~~

### WORK:
```
ls /dev/ttyCH34*
/dev/ttyCH341USB0
```
```
lsmod | grep ch34
ch341                  28672  0
```

### Give acsess:
```
sudo usermod -a -G dialout silenzio
sudo chmod a+rw /dev/ttyCH341USB0
```



_________


## https://xicro-ros2.readthedocs.io/en/latest/abstract.html

Coxsys Robotics and its researchers have developed the XICRO library as a communication tool between advanced software and robots. XICRO communicates through the ROS2 interface. XICRO libraries have been developed specifically for embedded systems, making efficient use of limited resources.



```
mkdir ~/xxx_ws
mkdir ~/xxx_ws/src
cd ~/xxx_ws/src      # cd to your workspace

git clone -b humble https://github.com/ament/ament_lint.git
colcon build

mkdir Xicro          # create metapackage
cd Xicro             # cd to metapackage
git clone https://github.com/imchin/Xicro .
cd ~/xxx_ws

colcon build
```

### Build ok

```
source ~/xxx_ws/install/setup.bash
```

### Generating Firmware library:

```
ros2 run xicro_pkg generate_library.py -mcu_type arduino
Get microcontroller.idmcu Done.
Get ros.publisher Done.
Get ros.srv_client Done.
Get microcontroller.idmcu Done.
Done load YAML srv_client.
Get ros.srv_server Done.
Get microcontroller.idmcu Done.
...
Get microcontroller.connection.type Done.
Get microcontroller.connection.type Done.
Get microcontroller.connection.type Done.
.cpp Done.
*******Create library arduino complete*******

```

### Generating Python Executable:

```
ros2 run xicro_pkg generate_xicro_node.py -mcu_type arduino
Get microcontroller.idmcu Done.
Get ros.subscriber Done.
Get microcontroller.namespace Done.
Get microcontroller.connection.type Done.
gennerate import module connection Done.
...
Get microcontroller.connection.type Done.
gennerate input argument Done.
----------------------generate xicro_node.py Done----------------------
Get microcontroller.namespace Done.
Get microcontroller.idmcu Done.
----------------------generate Entry_Point Done----------------------
```








