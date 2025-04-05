
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
cd ~/lib
https://github.com/WCHSoftGroup/ch341ser_linux.git
cd driver/
sudo make install
sudo ldconfig 

STEP 2.
For me it looks like the brltty driver is getting in the way. I don't have any sight problems myself and don't need a brail device. To fix I simply:
```
sudo apt-get autoremove brltty
```
And the next time I plugged in the ch340 it worked perfectly.

### WORK:
```
ls /dev/ttyCH34*
/dev/ttyCH341USB0
```






_________

nanp nano /etc/udev/rules.d/99-usb-serial.rules

https://nvidia-jetson.piveral.com/jetson-orin-nano/ch340-driver-not-detected-on-jetson-orin-nano/

__
Try the instructions given in this repo: https://github.com/WCHSoftGroup/ch341ser_linux

It worked for me.

__



https://developer.nvidia.com/embedded/jetson-linux-r3643
