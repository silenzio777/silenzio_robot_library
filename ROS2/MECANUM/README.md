### LINKS


https://docs.clearpathrobotics.com/docs/robots/indoor_robots/dingo/user_manual_dingo/

https://github.com/clearpathrobotics/cpr-documentation

___


http://www.clearpathrobotics.com/assets/guides/melodic/ros/Driving%20Husky%20with%20ROSSerial.html

Driving Husky with ROSserial and an Arduino
The Arduino family of micro controllers has quickly become a go to board for hobbyist due to its simplicity and ease of use, however often times roboticists must create communication protocols to allow their embedded hardware to communicate with a computer. That’s where rosserial comes in! Rosserial is a general protocol for sending ROS messages over a serial interface, such as the UART on Arduino. This allows you to easily interface any sensors attached to Arduino into your ROS environment!

This tutorial will get you started by setting up the Arduino IDE and installing the rosserial libraries. Then, we’ll test it out by driving the Husky simulation using a neat trick with the Arduino board. It should goes without saying you’ll need an Arduino to complete this tutorial. We’ll also be using a Husky simulator, so make sure to run through our Drive a Husky tutorial if you haven’t done so yet.

Setup
The first step is to set up your Arduino environment, begin by installing the Arduino IDE and rosserial using:

sudo apt-get install arduino arduino-core ros-melodic-rosserial ros-melodic-rosserial-arduino
Once you open up the Arduino IDE for the first time, a directory named “sketchbook” will be created in your home directory. Now we need to import the rosserial library into your arduino IDE. If your sketchbook directory is empty, you may need to create a directory named “libraries” inside of it.

mkdir ~/sketchbook/libraries
cd ~/sketchbook/libraries
rosrun rosserial_arduino make_libraries.py .
Restart your Arduino IDE and you should see the ros_lib part of your libraries!

_images/ros_lib_check.PNG
You’ll want to ensure that your Ubuntu user is part of the “Dailout” group, which grants you access to serial ports. You can check by using

groups "username”
If you don’t see “dailout”, you can easily add yourself using

sudo gpasswd --add "username" dialout
One last step to make our lives easier will be to create udev rules so your Arduino is recognized when plugged in and the correct permissions are set. For more information on udev rules check out our udev article . Begin by plugging in your Arduino.

NOTE: If you are using a virtual machine, you will have to connect Arduino to the virtual machine after plugging it in.

_images/attaching_device.jpg
You can confirm your system is actually connected to Arduino by running

ls -l /dev
You should see a line similar to

Bus 002 Device 005: ID 2341:0043
To confirm this is indeed your Arduino, disconnect it and run the command again, taking note which entry has disappeared. Remember the ID numbers, in this case, 2341 is the vendor ID and 0043 is the product ID. Now venture over to your udev rules at:

cd /etc/udev/rules.d/
and create our new rules file, the naming conventions for rules files follows “##-name.rules”. Chose a number that isn’t in use!

sudo gedit 97-arduino.rules
Copy the following into your new rules file, replacing #### with your product ID and vendor ID. For more information about what these tags mean, check out our article on udev rules.

SUBSYSTEMS=="usb", ACTION=="add", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="00[0-f][0-f]", MODE="0666", SYMLINK+="arduino arduino_$attr{serial}", GROUP="dialout",
All that is left is to update your udev rules and reboot your system

sudo udevadm control --reload-rules && sudo service udev restart && sudo udevadm trigger
You should now see “arduino” as an entry in ls -l /dev with full permissions! (rw-rw-rw-)

Code
We’re now set to upload our code to Arduino! The code is fairly straight forward, however if you have any difficulties following along, check out our “Creating a publisher” tutorial. Copy the following code into the Arduino IDE and click upload. If your udev rules were set correctly you should be able to upload without any errors.

If you encounter any errors, verify your arduino is coming up as “arduino” in a ls -l /dev and proper permissions are set. You may also have to point the Arduino IDE towards the correct USB port in tools -> serial port.

#include <ArduinoHardware.h>
#include <ros.h>
#include <geometry_msgs/Twist.h>

ros::NodeHandle nh;

geometry_msgs::Twist msg;

ros::Publisher pub("husky/cmd_vel", &msg);

void setup()
{
 nh.initNode();
 nh.advertise(pub);
} void loop()
{
 if(digitalRead(8)==1)
 msg.linear.x=-0.25;

else if (digitalRead(4)==1)
msg.linear.x=0.25;

else if (digitalRead(8)==0 && digitalRead(4)==0)
msg.linear.x=0;

pub.publish(&msg);
nh.spinOnce();
}
Driving Husky
Now that Arduino is loaded with our code and publishing velocity commands, we can pass these messages along into our ROS environment. We’ll start by launching a Husky simulation:

roslaunch husky_gazebo husky_empty_world.launch
All that’s left is to attach the Arduino into our ROS environment using:

rosrun rosserial_python serial_node.py _port:=/dev/arduino
We’re ready to try it out! Go ahead and touch the digital pin 8 and you should see Husky drive forward! Similarly if you touch digital pin 4 Husky will drive backwards.

_images/ArduinoUno_r2_front450px.jpg
This trick is made possible by a phenomenon known as parasitic capacitance, which is usually an unwanted effect in electronics design, but serves nicely for the purpose of our example. That being said, this isn’t the most reliable method, and is intended to provide a simple example with minimal equipment. If you are having difficulties moving your simulated Husky, try using rostopic echo /husky/cmd_vel to verify some commands are in fact being sent to Husky when you touch the pins.

Be sure to go through the rest of our ROS tutorials on our knowledge base. If you want to learn more about ROSserial, be sure to visit the rosserial page of the ROS wiki.






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
git clone https://github.com/openvmp/remote_hardware_interface.git src/remote_hardware_interface
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

sudo chmod 777 /dev/ttyTHS1



https://github.com/openvmp/microcontroller

```
cd ~/ros2_ws
git clone https://github.com/openvmp/serial.git src/remote_serial
```

### Run remote_microcontroller:
```
ros2 run remote_microcontroller remote_microcontroller_standalone \
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


