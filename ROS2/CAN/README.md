### Install PCAN (CANable board) on Jetson Orin NX:

### Put in the PCAN board
```
lsusb
...
Bus 001 Device 010: ID 0c72:000c PEAK System PCAN-USB.
...
```

### go to ~/lib
```
cd '/home/silenzio/lib'
mkdir PCAN
cd PCAN
```

### get PCAN version checker from site: 
https://www.peak-system.com/fileadmin/media/linux/files/pcan-kernel-version.sh.tar.gz

```
tar -xzf pcan-kernel-version.sh.tar.gz
./pcan-kernel-version.sh
```
- Bus 001 Device 010: ID 0c72:000c PEAK System PCAN-USB needs Linux 3.4

### get PCAN driver from site:
https://www.peak-system.com/fileadmin/media/linux/index.php
https://www.peak-system.com/quick/PCAN-Linux-Driver

```
tar -xzf peak-linux-driver-8.20.0.tar.gz
cd '/home/silenzio/lib/peak-linux-driver-8.20.0'
make clean
make
sudo make install
```
### done

### Start driver:
```
sudo modprobe pcan
```

```
sudo dmesg | grep pcan 
[19251.479209] pcan: module verification failed: signature and/or required key missing - tainting kernel
[19251.481355] pcan: Release_20250213_n (le)
[19251.481359] pcan: driver config [mod] [isa] [pci] [pec] [usb] 
[19251.484000] pcan 1-2.4.3:1.0: PCAN-USB (MCU00h) fw v8.4.0
[19251.536908] pcan: - usb device minor 32 found
[19251.537025] usbcore: registered new interface driver pcan
[19251.537039] pcan: major 486.
```







________________


### Install CAN on Jetson Orin NX:

- [CAN interface setup](#can-interface-setup)<br/>
- [Installing the ros_odrive Package](#installing-the-ros-odrive-package)<br/>


### CAN interface setup:
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

### Check can interface
```
ifconfig
```

```
can0: flags=193<UP,RUNNING,NOARP>  mtu 16
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 10  (UNSPEC)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

### Display CAN statistics:
```
ip -details -statistics link show can0
```
```
2: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
    link/can  promiscuity 0 minmtu 0 maxmtu 0 
    can <LOOPBACK,BERR-REPORTING,FD> state ERROR-WARNING (berr-counter tx 118 rx 0) restart-ms 0 
	  bitrate 500000 sample-point 0.870 
	  tq 20 prop-seg 43 phase-seg1 43 phase-seg2 13 sjw 1
	  mttcan: tseg1 2..255 tseg2 0..127 sjw 1..127 brp 1..511 brp-inc 1
	  dbitrate 1000000 dsample-point 0.720 
	  dtq 40 dprop-seg 8 dphase-seg1 9 dphase-seg2 7 dsjw 1
	  mttcan: dtseg1 1..31 dtseg2 0..15 dsjw 1..15 dbrp 1..15 dbrp-inc 1
	  clock 50000000 
	  re-started bus-errors arbit-lost error-warn error-pass bus-off
	  0          1134813    0          1          1          0         numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 parentbus platform parentdev c310000.mttcan 
    RX:  bytes packets  errors dropped  missed   mcast           
       9078560 1134825 1134813       0       0       0 
    TX:  bytes packets  errors dropped carrier collsns           
            40      10       0       4       0       0 
```


### To perform a loopback test

1. Short the Tx and Rx pins of the Jetson carrier board`s CAN0.
2. Enable the CAN drivers. (See Kernel Drivers for more information.)

```
sudo ip link set can0 down
sudo ip link set can0 type can bitrate 500000 loopback on
sudo ip link set can0 up
candump can0 &
```
```
[4] 10509
```

### Send test commnd:
```
cansend can0 123#abcdabcd
```

### Show smthng like this:
```
jetson@ubuntu:~$   can0  RX - -  123   [4]  AB CD AB CD
  can0  TX - -  123   [4]  AB CD AB CD
  can0  123   [4]  AB CD AB CD
  can0  RX - -  123   [4]  AB CD AB CD
  can0  123   [4]  AB CD AB CD
  can0  TX - -  123   [4]  AB CD AB CD
  can0  RX - -  123   [4]  AB CD AB CD
  can0  TX - -  123   [4]  AB CD AB CD
```

### Verify these messages are working properly with:

```
candump can0 -xct z -n 10
```
```
python3 -m can.viewer -c "can0" -i "socketcan".

```


### Installing the ros_odrive Package:
[Source link](https://docs.odriverobotics.com/v/latest/guides/ros-package.html)<br/>


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
```
silenzio@jetsonnx:~/ros2_ws$ ros2 launch odrive_can example_launch.yaml
[INFO] [launch]: All log files can be found below /home/silenzio/.ros/log/2025-03-28-16-36-54-398518-jetsonnx-167569
[INFO] [launch]: Default logging verbosity is set to INFO
[INFO] [odrive_can_node-1]: process started with pid [167604]
[odrive_can_node-1] [INFO] [1743169014.693833715] [odrive_axis0.can_node]: node_id: 0
[odrive_can_node-1] [INFO] [1743169014.694022072] [odrive_axis0.can_node]: interface: can0
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

[Full list of control_mode codes: ControlMode](https://docs.odriverobotics.com/v/latest/fibre_types/com_odriverobotics_ODrive.html#ODrive.Controller.ControlMode)<br/>

[Full list of input_mode codes: InputMode](https://docs.odriverobotics.com/v/latest/fibre_types/com_odriverobotics_ODrive.html#ODrive.Controller.InputMode)<br/>

