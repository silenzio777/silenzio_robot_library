### LINKS

### ROS2 Arduino

https://github.com/openvmp/microcontroller

ROS2 interface to I/O of an attached microcontroller ( Arduino Mega2560 )




### Install:
```
mkdir src
git clone https://github.com/openvmp/actuator.git src/remote_actuator
git clone https://github.com/openvmp/encoder.git src/remote_encoder
git clone https://github.com/openvmp/switch.git src/remote_switch
git clone https://github.com/openvmp/serial.git src/remote_serial
git clone https://github.com/openvmp/remote_stepper_driver.git src/remote_stepper_driver
git clone https://github.com/openvmp/stepper_driver src/remote_stepper_driver
git clone https://github.com/openvmp/microcontroller.git src/remote_microcontroller
```
### Build:
```

colcon build --packages-select remote_actuator
colcon build --packages-select remote_encoder
colcon build --packages-select remote_switch
colcon build --packages-select remote_serial
colcon build --packages-select remote_hardware_interface
colcon build --packages-select remote_stepper_driver
colcon build --packages-select remote_microcontroller

```



https://github.com/openvmp/microcontroller

```
cd ~/ros2_ws
git clone https://github.com/openvmp/serial.git src/remote_serial
```

### Run:

https://github.com/openvmp/serial/blob/main/README.md

```
ros2 run remote_serial remote_serial_standalone
```

```
ros2 run remote_serial remote_serial_standalone \
  --ros-args \
  --remap serial:__node:=serial_com1 \
  -p serial_is_remote:=false \
  -p serial_prefix:=/serial/com1 \
  -p serial_dev_name:=/dev/ttyS0 \
  -p serial_baud_rate:=115200 \
  -p serial_data:=8 \
  -p serial_parity:=false \
  -p serial_stop:=1 \
  -p serial_flow_control:=true
```

Here is an example of the configuration file for controlling a single servo:

```
pwm:
  - channel: 0 # maps to pin 2 on Arduino Mega2560 and pin 3 on Arduino Uno
    type: simple_pwm # fixed value, one of several supported types
    name: actuator0 # this will be used to produce the node name, no need to match with any other values
    prefix: /pwm0 # where to expose ROS2 interfaces
    pwm_min: 0
    pwm_max: 255
```

If this configuration file is used, then the following command can be used to control the servo motor:

```
ros2 topic pub /pwm0/pwm std_msgs/msg/UInt16 '{"data":150}'
```

__





______________________
https://github.com/AnrdyShmrdy/ros2_serial_interface
ROS2 Serial Interface
______________________

https://github.com/RozaGkliva/ros2_serial
Serial interface for ROS 2
-humble

__
https://robotics.stackexchange.com/questions/104890/ros2-humble-with-arduino-uno

arduino mega 
https://robotics.stackexchange.com/questions/63666/arduino-mega-and-rosserial-problem
https://github.com/ros-drivers/rosserial/issues/143
https://robotics.stackexchange.com/questions/62758/rosserial-arduino-use-progmem-in-ros-lib

The replacement for rosserial is micro-ROS
or
If you want to keep using ROS 1 rosserial without changing your firmware, it would make more sense to run a small ROS 1 master + an instance of ros1_bridge than to integrate message translation into any part of rosserial itself.

https://github.com/ros-drivers/rosserial/issues/589

Node MCU ESP8266 Support




https://github.com/anasderkaoui/ROS2-and-Arduino-serial-communication

https://github.com/ROBOTIS-GIT/ros2arduino

https://github.com/strothmw/rosserial


https://github.com/erenkarakis/Aros2duino


https://codefile.io/f/4IXZDzj67q


______


https://github.com/OPR-Project/OpenPlaceRecognition-ROS2


### 3D VOXEL:
https://nvidia.github.io/MinkowskiEngine/overview.html

https://github.com/NVIDIA/MinkowskiEngine/tree/master



### 3D NN:
https://habr.com/ru/articles/800949/


https://habr.com/ru/companies/innopolis/articles/653929/



### OMNI:

https://github.com/nguyen-v/omnibot_ros2_control


https://github.com/nguyen-v/omni_wheel_controller?tab=readme-ov-file


https://github.com/hijimasa/omni_wheel_controller_sample




_____
BLDC drivers

https://wiki.ros.org/Motor%20Controller%20Drivers

https://github.com/chiprobotics/chip_bldc_driver

https://github.com/silenzio777/ros_odrive_gim6010-8



________
https://automaticaddison.com/autonomous-docking-with-apriltags-using-nav2-ros-2-jazzy/

Autonomous Docking with AprilTags Using Nav2 – ROS 2 Jazzy

https://github.com/automaticaddison/yahboom_rosmaster


