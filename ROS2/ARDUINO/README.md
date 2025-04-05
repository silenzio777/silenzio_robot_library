$ echo $(uname -r)
5.15.148-tegra

5.15.136-tegra


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
ls /dev/tty*
/dev/tty    /dev/tty14  /dev/tty20  /dev/tty27  /dev/tty33  /dev/tty4   /dev/tty46  /dev/tty52  /dev/tty59  /dev/tty8     /dev/ttyp3  /dev/ttypa  /dev/ttyS1
/dev/tty0   /dev/tty15  /dev/tty21  /dev/tty28  /dev/tty34  /dev/tty40  /dev/tty47  /dev/tty53  /dev/tty6   /dev/tty9     /dev/ttyp4  /dev/ttypb  /dev/ttyS2
/dev/tty1   /dev/tty16  /dev/tty22  /dev/tty29  /dev/tty35  /dev/tty41  /dev/tty48  /dev/tty54  /dev/tty60  /dev/ttyAMA0  /dev/ttyp5  /dev/ttypc  /dev/ttyS3
/dev/tty10  /dev/tty17  /dev/tty23  /dev/tty3   /dev/tty36  /dev/tty42  /dev/tty49  /dev/tty55  /dev/tty61  /dev/ttyGS0   /dev/ttyp6  /dev/ttypd  /dev/ttyTCU0
/dev/tty11  /dev/tty18  /dev/tty24  /dev/tty30  /dev/tty37  /dev/tty43  /dev/tty5   /dev/tty56  /dev/tty62  /dev/ttyp0    /dev/ttyp7  /dev/ttype  /dev/ttyTHS1
/dev/tty12  /dev/tty19  /dev/tty25  /dev/tty31  /dev/tty38  /dev/tty44  /dev/tty50  /dev/tty57  /dev/tty63  /dev/ttyp1    /dev/ttyp8  /dev/ttypf  /dev/ttyTHS2
/dev/tty13  /dev/tty2   /dev/tty26  /dev/tty32  /dev/tty39  /dev/tty45  /dev/tty51  /dev/tty58  /dev/tty7   /dev/ttyp2    /dev/ttyp9  /dev/ttyS0
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







_________

nanp nano /etc/udev/rules.d/99-usb-serial.rules

https://nvidia-jetson.piveral.com/jetson-orin-nano/ch340-driver-not-detected-on-jetson-orin-nano/

__
Try the instructions given in this repo: https://github.com/WCHSoftGroup/ch341ser_linux

It worked for me.

__



https://developer.nvidia.com/embedded/jetson-linux-r3643
