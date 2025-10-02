
## Run DM-JXXX-2EC motor via PEAK System USB-CAN adapter.
(DM-J4310-2EC, DM-J4340-2EC, DM-J4340P-2EC)

_______
### UBUNTU PC | CANable V1.0 Nano (PEAK System PCAN-USB)
_______

Connection diagram.

Before CAN interface start:

<img src="https://github.com/user-attachments/assets/698a4982-4901-47e5-bbca-b82ebc973ec4" width="640">

After CAN interface start:

<img src="https://github.com/user-attachments/assets/8aec6259-52d2-4593-8edf-f54b4c5bfc21" width="640">

### 120R termination must be enable.

From https://canable.io/getting-started.html site:

```
The original CANable has two jumpers: "Boot" and "Term".

Jumper towards the screw terminals: the onboard 120R termination is enabled. 
Jumper away from the screw terminals: termination is disabled.

Connect to the Bus:
Connect the CANH, CANL, and GND pins of your CANable to your target CAN bus. 
You must connect ground for the CAN bus to function properly.
```

<img src="https://github.com/user-attachments/assets/ff71e87d-2a98-421c-a0cb-8e264f413d35" width="640">

<img src="https://github.com/user-attachments/assets/5b29acd0-adbf-40ef-b3ef-a2509759dad4" width="640">

_____

Attach the motor via DM-tools USBtoCAN board (UART interface).

### Run DM-USB2FDCAN-x86_64.AppImage
```
ls /dev/ttyACM0
sudo chmod 777 /dev/ttyACM0
cd /home/silenzio/lib/dm-tools-master
chmod a+x DM-USB2FDCAN-x86_64.AppImage
./DM-USB2FDCAN-x86_64.AppImage
```

The motor is visible and controlled via the developer program DM-USB2FDCAN-x86_64.AppImage:

<img src="https://github.com/user-attachments/assets/34d3cd1c-aecb-4321-86d3-a7586b3cb0c0" width="640">

<img src="https://github.com/user-attachments/assets/280250f2-4887-4b2e-b68c-e5c1477a4052" width="640">

<img src="https://github.com/user-attachments/assets/383da361-1931-4643-a084-7e886613d4a8" width="640">

<details> 
  <summary>DM-J4340P-2EC</summary>

   DMBOT Motor Driver--V3.0
  
   Debug Info:
  
  Firmware Version: 5117
  Sub Version: 003
  Imax: 10.261194
   I_U Offset:     2047.1090
   I_V Offset:     2109.7710
   I_W Offset:     2103.6509
   Position Sensor Electrical Offset:   -0.9162
  
   Mechanical Offset:   
   0.0000
  
   Output Position:  -0.6097
  
   CAN ID:     0x001
  
   MASTER ID:  0x000
  
   CAN Baud: 1.00Mbps
  
  
   Motor Info:
  
   Rs  = 846.7125 mΩ
  
   Ls  = 346.4771 μH
  
   Ψf = 0.0046 Wb
  
  V_BUS=24.1230
  
   Control Mode : 
  1:MIT Mode <----
  
  2:position-speed cascade Mode
  
  3:speed Mode
  
  4:Hybrid control Mode 

</details>


### Set Sender CAN ID	and Receiver (motor) ID

https://wiki.seeedstudio.com/damiao_series/

https://docs.openarm.dev/software/setup/motor-id
```
Joint	Sender CAN ID	Receiver (Master) ID
J1		0x01			0x11
```

____

## CAN interface install process:

```
lsusb
```
```
Bus 001 Device 002: ID 0c72:000c PEAK System PCAN-USB
```

## Kernel driver:
```
sudo modprobe pcan
```
```
sudo dmesg | grep pcan 
```
```
[  376.264297] pcan: Release_20250213_n (le)
[  376.264303] pcan: driver config [mod] [isa] [pci] [pec] [usb] [net] 
[  376.264898] pcan 1-7:1.0: PCAN-USB (MCU00h) fw v8.4.0
[  376.315828] pcan: registered CAN netdevice can0 for usb hw (511,32)
[  376.315831] pcan: - usb device minor 32 found
[  376.315855] usbcore: registered new interface driver pcan
[  376.315860] pcan: major 511.
```

### Set up CAN interface:
On motor red LED is on.
```
sudo ip link set can0 down
sudo ip link set can0 up type can bitrate 1000000
```
Turn motor ON:

T1:
```
cansend can0 001#FFFFFFFFFFFFFFFC
```

T2:
```
candump can0
```
```
  can0  TX - -  001   [8]  FF FF FF FF FF FF FF FC
  can0  RX - -  011   [8]  11 83 27 7F F7 FF 00 00

```
The red LED on motor change to green LED.

Turn motor OFF:
```
cansend can0 001#FFFFFFFFFFFFFFFD
```

```
  can0  TX - -  001   [8]  FF FF FF FF FF FF FF FD
  can0  RX - -  011   [8]  01 83 27 7F E7 FF 1A 19
```
On motor red LED is on.

### Check CAN interface:
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

## Python code:

### Install:
Create and activate virtual environment (recommended)
```
python3 -m venv venv
source venv/bin/activate
./build.sh
```

### Run:

```
cd ~/lib/openarm_can/python/
source venv/bin/activate
```

```python
python3
Python 3.10.12 (main, May 27 2025, 17:12:29) [GCC 11.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import openarm_can as oa
>>> arm = oa.OpenArm("can0", False)
>>> arm.init_arm_motors([oa.MotorType.DM4310], [0x01], [0x11])
>>> arm.enable_all()
```

<details> 
  <summary>Pure python code without python venv, for ROS2 node:</summary>

## Pure python code without python venv, for ROS2 node:

Check works:

```
python3 -c "import openarm_can" || echo "Библиотека не найдена"
```
```
Traceback (most recent call last):
  File "<string>", line 1, in <module>
ModuleNotFoundError: No module named 'openarm_can'
```

### Set lib to system path:
```
/usr/local/lib/python3.10/dist-packages/
/usr/lib/python3/dist-packages/ <<<<<<<<<
```


Copy .so files:

UBUNTU PC
```
sudo cp /home/silenzio/lib/openarm_can/python/venv/lib/python3.10/site-packages/openarm_can.cpython-310-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/
```
JETSON NX
```
sudo cp /home/silenzio/lib/openarm_can/python/venv/lib/python3.10/site-packages/openarm_can.cpython-310-aarch64-linux-gnu.so /usr/lib/python3/dist-packages/
```

Copy openarm modules:
```
sudo cp -r /home/silenzio/lib/openarm_can/python/venv/lib/python3.10/site-packages/openarm /usr/lib/python3/dist-packages/
```

Give right permissions:

UBUNTU PC
```
sudo chmod 644 /usr/lib/python3/dist-packages/openarm_can.cpython-310-x86_64-linux-gnu.so
```
JETSON NX
```
sudo chmod 644 /usr/lib/python3/dist-packages/openarm_can.cpython-310-aarch64-linux-gnu.so
```


```
sudo chmod -R 755 /usr/lib/python3/dist-packages/openarm
```

Check install:
```
python3 -c "import openarm_can; print('Success! Library is system now')"
Success! Library is system now
```
```
python3 -c "import openarm_can; print(openarm_can.__file__)"
/usr/lib/python3/dist-packages/openarm_can.cpython-310-x86_64-linux-gnu.so
```

Run:
```
python3
Python 3.10.12 (main, May 27 2025, 17:12:29) [GCC 11.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import openarm_can as oa
>>> arm = oa.OpenArm("can0", False)
>>> arm.init_arm_motors([oa.MotorType.DM4310], [0x01], [0x11])
>>> arm.enable_all()
>>> exit()
```
### works

</details>

_______
### UBUNTU PC | CANable V2.0 Pro (MCS CANable2 b158aa7 github.com/normaldotcom/canable2.git)
_______

```
lsusb
```
```
Bus 001 Device 002: ID 16d0:117e MCS CANable2 b158aa7 github.com/normaldotcom/canable2.git
```

```
ls /dev/ttyACM*
```
- /dev/ttyACM0
```
sudo chmod 777 /dev/ttyACM0
```
```
sudo modprobe slcan
```
```
sudo slcan_attach -f -s8 -o /dev/ttyACM0
```
- attached tty /dev/ttyACM0 to netdevice can0
```
sudo slcand ttyACM0 can0
sudo ip link set can0 up type can bitrate 1000000
```
Turn on motor:
```
cansend can0 001#FFFFFFFFFFFFFFFC
```
Turn off motor:
```
cansend can0 001#FFFFFFFFFFFFFFFD
```
```
~/lib/openarm_can/build$ ./motor-check 1 17 can0
```

```
=== OpenArm Motor Control Script ===
Send CAN ID: 1
Receive CAN ID: 17
CAN Interface: can0
CAN-FD Enabled: No

Initializing OpenArm CAN...
Initializing motor...
Reading motor parameters...

=== Motor Parameters ===
Send CAN ID: 1
Queried Master ID: 17
Queried Baudrate (1-9): 4
✓ Master ID verification passed

=== Enabling Motor ===

=== Refreshing Motor Status (10Hz for 1 second) ===

--- Refresh 1/10 ---
Motor ID: 1
  Position: 0.195888 rad
  Velocity: -0.021978 rad/s
  Torque: -0.002442 Nm
  Temperature (MOS): 27 °C
  Temperature (Rotor): 25 °C
...
=== Script Completed Successfully ===
```



