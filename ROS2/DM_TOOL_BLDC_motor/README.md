
https://github.com/enactic/openarm_can

sudo apt-get update
sudo apt-get install libfuse2

sudo modprobe slcan
sudo modprobe can
sudo ip link set can0 down
 sudo ip link set can0 type can bitrate 1000000
 sudo ip link set can0 up

Terminal 2 - Send commands: In Terminal 2, send a motor enable command to motor #1:
cansend can0 001#FFFFFFFFFFFFFFFC

candump can0
can0  011   [8]  XX XX XX XX XX XX XX XX

# Disable motor #1
cansend can0 001#FFFFFFFFFFFFFFFD

ls /dev/ttyACM0

sudo chmod 777 /dev/ttyACM0

cd /home/silenzio/lib/dm-tools-master
chmod a+x DM-USB2FDCAN-x86_64.AppImage
./DM-USB2FDCAN-x86_64.AppImage

https://docs.openarm.dev/software/setup/motor-id

Joint	Sender CAN ID	Receiver (Master) ID
J1		0x01			0x11


______

### Install USBtoCAN (DM tools) on Jetson Orin NX:

### Put in the PCAN board
```
lsusb
...
Bus 001 Device 004: ID 2e88:4603 HDSC CDC Device 
...
```
### Install software:
```
~/lib$ git clone https://github.com/enactic/openarm_can.git
```
## Setup CAN Interface

### Configure:
```
cd '/home/silenzio/lib/openarm_can'
setup/configure_socketcan.sh can0
```
```
Configuring can0...
[sudo] password for silenzio: 
can0 is now set to CAN 2.0 mode (1000000 bps)
✓ can0 is active
```
```
ifconfig
can0: flags=193<UP,RUNNING,NOARP>  mtu 16
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 10  (UNSPEC)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 200  
```
## C++ Library

### Build & Install:
```
sudo apt-get install ninja-build
cd openarm_can
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build
sudo cmake --install build
```
### Done


Python (🚧 EXPERIMENTAL - TEMPORARY 🚧)
⚠️ WARNING: UNSTABLE API ⚠️ Python bindings are currently a direct low level temporary port, and will change DRASTICALLY. The interface is may break between versions.Use at your own risk! Discussions on the interface are welcomed.

### Build & Install:

Please ensure that you build and install the C++ library first, as described above.
```
cd python
```
###  Create and activate virtual environment (recommended)
```
python3 -m venv venv
source venv/bin/activate
./build.sh
```
```
Building OpenArm Python bindings...
Script directory: /home/silenzio/lib/openarm_can/python
Project root: /home/silenzio/lib/openarm_can
Using virtual environment (venv): /home/silenzio/lib/openarm_can/python/venv
Installing in development mode...
Processing /home/silenzio/lib/openarm_can/python
  Installing build dependencies ... done
  Getting requirements to build wheel ... done
  Installing backend dependencies ... done
  Preparing metadata (pyproject.toml) ... done
Building wheels for collected packages: openarm_can
  Building wheel for openarm_can (pyproject.toml) ... done
  Created wheel for openarm_can: filename=openarm_can-1.0.0-cp310-cp310-linux_aarch64.whl size=108064 sha256=d39bed85d2fc00701d7ea775bd92291ba392f4f64536ddd925911ee0b489f515
  Stored in directory: /tmp/pip-ephem-wheel-cache-tm9lm70s/wheels/39/f5/6a/3c9a1a3cdbe46e9aef6f93fc0dac065395a32ae2a0cf80d7f3
Successfully built openarm_can
Installing collected packages: openarm_can
Successfully installed openarm_can-1.0.0
Build completed successfully!

To test the installation, run:
  python -c 'import openarm; print(openarm.__version__)'

See examples/ directory for usage examples.
```
### Done


## Usage:

### WARNING: This API is unstable and will change!

```
cd ~/lib/openarm_can/python
source venv/bin/activate
```

```python
import openarm_can as oa

arm = oa.OpenArm("can0", True)  # CAN-FD enabled
arm.init_arm_motors([oa.MotorType.DM4310], [0x01], [0x11])
arm.enable_all()
```


_________
