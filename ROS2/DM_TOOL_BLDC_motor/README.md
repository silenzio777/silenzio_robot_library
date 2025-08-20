

sudo modprobe can
sudo modprobe can-raw
sudo modprobe slcan
sudo modprobe slcan

sudo slcand -o -s8 -t hw -S 500000 /dev/ttyUSBx
sudo ip link set up slcan0

a:

Your CAN bitrate is wrong. To setup 500kbit/s you need to invoke following commands:

sudo chmod 777 /dev/ttyACM0

## sudo slcand -o -s6 -t hw -S 3000000 /dev/ttyUSBx

sudo slcan_attach -f -s8 -o /dev/ttyACM1


sudo ip link set up slcan0

-s6 means CAN bitrate 500kbit/s, 
-s8 means 1Mbit/s.
-S parameter is used to setup serial speed to the USB-to-serial controller in the USB-to-CAN cable. 

The full CAN bitrate table for slcan can be found here - http://elinux.org/Bringing_CAN_interface_up#SLCAN_based_Interfaces


_____


https://docs.openarm.dev/software/
https://github.com/enactic/openarm_can
https://wiki.seeedstudio.com/damiao_series/


```
lsusb
...
Bus 001 Device 002: ID 2e88:4603 HDSC CDC Device
...
```

```
sudo dmesg | grep -i can

[  807.166041] can: controller area network core
[  807.166066] NET: Registered PF_CAN protocol family
[  820.957493] CAN device driver interface
[  820.962446] slcan: serial line CAN interface driver
```

```
lsmod | grep cdc_acm
cdc_acm                45056  0
```


```
sudo dmesg | grep -i "cdc\|tty"
[sudo] password for silenzio: 
[    0.129620] printk: legacy console [tty0] enabled
[   55.229906] usb 1-7: Product: CDC Device
[   55.253677] cdc_acm 1-7:1.0: ttyACM0: USB ACM device
[   55.253699] usbcore: registered new interface driver cdc_acm
[   55.253701] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
```
```
sudo modprobe slcan
```
```
ls /dev/ttyACM*
```
`/dev/ttyACM0

```
sudo chmod 777 /dev/ttyACM0
```

### Attach port to CAN interface
```
sudo slcan_attach -f -s6 -o /dev/ttyACM0
```
`attached tty /dev/ttyACM0 to netdevice can0

###  Up interface
```
sudo slcand ttyACM0 can0
```

###  Set CAN-interface speed (1000000 bit/s)
```
sudo ip link set can0 up type can bitrate 1000000
```

```
ip link show

5: can0: <NOARP,UP,LOWER_UP> mtu 16 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
    link/can 
```

```
ifconfig
can0: flags=193<UP,RUNNING,NOARP>  mtu 16
        unspec 00-00-00-00-00-00-00-00-00-00-00-00-00-00-00-00  txqueuelen 10  (UNSPEC)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 8  bytes 64 (64.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

```
lsusb -v -d 2e88:4603 | grep -i can
```
`Couldn't open device, some information will be missing

```
sudo lsusb -v -d 2e88:4603 | grep -i can
```
`>>>> Green led start blinking on USBtoCAN dmbot board. Before it was red. <<<<


sudo lsusb -v -d 2e88:4603 | head -20

Bus 001 Device 002: ID 2e88:4603 HDSC CDC Device
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x2e88 
  idProduct          0x4603 
  bcdDevice            2.00
  iManufacturer           1 HDSC
  iProduct                2 CDC Device
  iSerial                 3 00000000050C
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2




### Create service
```
sudo nano /etc/systemd/system/slcan.service
```
```
[Unit]
Description=SLCAN configuration for USB-CAN adapter
After=syslog.target network.target

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/slcand -o -s6 -S 1000000 /dev/ttyACM0 can0
ExecStartPost=/bin/sleep 2
ExecStartPost=/sbin/ip link set can0 up type can bitrate 1000000

[Install]
WantedBy=multi-user.target
```

### Activate service
```
sudo systemctl daemon-reload
sudo systemctl enable slcan.service
```

### Stop prev setup
```
sudo pkill slcand
sudo ip link set can0 down 2>/dev/null
```

```
Автоматическая настройка при загрузке
Для автоматической настройки при подключении устройства создайте udev-правило:

1. Создайте файл правил udev
bash
sudo nano /etc/udev/rules.d/80-can.rules
2. Добавьте содержимое
text
SUBSYSTEM=="tty", ATTRS{idVendor}=="2e88", ATTRS{idProduct}=="4603", SYMLINK+="can_adapter", RUN+="/usr/bin/slcand -o -s6 -S 3000000 /dev/%k can0", RUN+="/bin/sleep 2", RUN+="/sbin/ip link set can0 up type can bitrate 500000"
3. Перезагрузите правила udev
bash
sudo udevadm control --reload-rules
sudo udevadm trigger
```


____

```
sudo apt-get update
sudo apt-get install libfuse2
```

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
