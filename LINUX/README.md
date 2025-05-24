### Ubuntu 22.04 commands:

______

- [How to switch boot target to text or GUI in systemd Linux:](#text-or-gui)<br/>
- [WiFi show spots](#wifi-show-spots)<br/>
- [spci](#spci)<br/>
- [lsblk](#lsblk)<br/> 
- [lscpu](#lscpu)<br/>
- [dmesg](#dmesg)<br/>
- [dpkg](#dpkg)<br/>
- [apt-cache search](#apt-cache-search)<br/>
- [nmap](#nmap)<br/>
- [openssl](#openssl)<br/>
- [uninstall package build from source](#uninstall-package-build-from-source)<br/>
- [shutdown](#shutdown)<br/>


```
echo $(uname -r)
5.15.148-tegra
```


### Text or GUI
[source link]([HARDWARE/README.md](https://www.cyberciti.biz/faq/switch-boot-target-to-text-gui-in-systemd-linux/))<br/>
[systemctl info](https://tokmakov.msk.ru/blog/item/464)

### To text mode:
```
sudo systemctl isolate multi-user.target
```

### To grahics mode:
```
sudo systemctl isolate graphical.target
```

Switching boot target to text
The procedure is as follows to change into a text mode runlevel under systemd:

Open the terminal application.
For remote Linux servers, use the ssh command.
Find which target unit is used by default:
```
systemctl get-default
```
```
silenzio@ubuntuPC:~/ros2_ws$ systemctl get-default
graphical.target

```
To change boot target to the text mode:
```
sudo systemctl set-default multi-user.target
```

Reboot the system using the reboot command:
```
sudo systemctl reboot
```

How to switch boot target to GUI (graphical UI)
Want to revert change boot to GUI instead of console/text mode? Try:

Open the Linux terminal application.
Again, for remote Linux servers, use the ssh command.
Find which target unit is used by default:
```
systemctl get-default
```
To change boot target to the GUI mode:
```
sudo systemctl set-default graphical.target
```
Make sure you reboot the Linux box using the reboot command:
```
sudo reboot
```

### Jetson NX:
```
silenzio@jetsonnx:~/ros2_ws$ systemctl list-units --type=target
  UNIT                    LOAD   ACTIVE SUB    DESCRIPTION                        
  basic.target            loaded active active Basic System
  bluetooth.target        loaded active active Bluetooth Support
  cryptsetup.target       loaded active active Local Encrypted Volumes
  getty-pre.target        loaded active active Preparation for Logins
  getty.target            loaded active active Login Prompts
  graphical.target        loaded active active Graphical Interface
  local-fs-pre.target     loaded active active Preparation for Local File Systems
  local-fs.target         loaded active active Local File Systems
  multi-user.target       loaded active active Multi-User System
  network-online.target   loaded active active Network is Online
  network-pre.target      loaded active active Preparation for Network
  network.target          loaded active active Network
  nss-lookup.target       loaded active active Host and Network Name Lookups
  nss-user-lookup.target  loaded active active User and Group Name Lookups
  paths.target            loaded active active Path Units
  remote-fs-pre.target    loaded active active Preparation for Remote File Systems
  remote-fs.target        loaded active active Remote File Systems
  rpcbind.target          loaded active active RPC Port Mapper
  slices.target           loaded active active Slice Units
  snapd.mounts-pre.target loaded active active Mounting snaps
  snapd.mounts.target     loaded active active Mounted snaps
  sockets.target          loaded active active Socket Units
  sound.target            loaded active active Sound Card
  swap.target             loaded active active Swaps
  sysinit.target          loaded active active System Initialization
  time-set.target         loaded active active System Time Set
  timers.target           loaded active active Timer Units
  usb-gadget.target       loaded active active Hardware activated USB gadget
  veritysetup.target      loaded active active Local Verity Protected Volumes

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.
29 loaded units listed. Pass --all to see loaded but inactive units, too.
To show all installed unit files use 'systemctl list-unit-files'.
```
### UbuntuPC:
```
silenzio@ubuntuPC:~/ros2_ws$ systemctl list-units --type=target
  UNIT                    LOAD   ACTIVE SUB    DESCRIPTION                       
  basic.target            loaded active active Basic System
  cryptsetup.target       loaded active active Local Encrypted Volumes
  getty-pre.target        loaded active active Preparation for Logins
  getty.target            loaded active active Login Prompts
  graphical.target        loaded active active Graphical Interface
  local-fs-pre.target     loaded active active Preparation for Local File Systems
  local-fs.target         loaded active active Local File Systems
  multi-user.target       loaded active active Multi-User System
  network-online.target   loaded active active Network is Online
  network-pre.target      loaded active active Preparation for Network
  network.target          loaded active active Network
  nss-lookup.target       loaded active active Host and Network Name Lookups
  nss-user-lookup.target  loaded active active User and Group Name Lookups
  paths.target            loaded active active Path Units
  remote-fs.target        loaded active active Remote File Systems
  slices.target           loaded active active Slice Units
  snapd.mounts-pre.target loaded active active Mounting snaps
  snapd.mounts.target     loaded active active Mounted snaps
  sockets.target          loaded active active Socket Units
  sound.target            loaded active active Sound Card
  swap.target             loaded active active Swaps
  sysinit.target          loaded active active System Initialization
  time-set.target         loaded active active System Time Set
  timers.target           loaded active active Timer Units
  veritysetup.target      loaded active active Local Verity Protected Volumes

LOAD   = Reflects whether the unit definition was properly loaded.
ACTIVE = The high-level unit activation state, i.e. generalization of SUB.
SUB    = The low-level unit activation state, values depend on unit type.
25 loaded units listed. Pass --all to see loaded but inactive units, too.
To show all installed unit files use 'systemctl list-unit-files'.

```

### WiFi show spots:
```
nmcli dev wifi
```
```
IN-USE  BSSID        SSID    MODE   CHAN   RATE        SIGNAL  BARS  SECURITY  
XX:XX:XX:XX:XX:XX    Plate   Infra  1      405 Mbit/s  97      |\/   WPAX
...
```
___________

### spci

```
0001:00:00.0 PCI bridge: NVIDIA Corporation Device 229e (rev a1)
0001:01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822CE 802.11ac PCIe Wireless Network Adapter
0004:00:00.0 PCI bridge: NVIDIA Corporation Device 229c (rev a1)
0004:01:00.0 Non-Volatile memory controller: Silicon Motion, Inc. SM2263EN/SM2263XT SSD Controller (rev 03)
0008:00:00.0 PCI bridge: NVIDIA Corporation Device 229c (rev a1)
0008:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)
```
___________

### lsblk


```
NAME         MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0          7:0    0     4K  1 loop /snap/bare/5
loop1          7:1    0 174.6M  1 loop /snap/chromium/3039
loop2          7:2    0  68.8M  1 loop /snap/core22/1752
loop3          7:3    0  64.7M  1 loop /snap/cups/1069
loop4          7:4    0 493.5M  1 loop /snap/gnome-42-2204/201
loop5          7:5    0  91.7M  1 loop /snap/gtk-common-themes/1535
loop6          7:6    0  38.7M  1 loop /snap/snapd/23546
loop7          7:7    0    16M  1 loop 
zram0        252:0    0 978.5M  0 disk [SWAP]
zram1        252:1    0 978.5M  0 disk [SWAP]
zram2        252:2    0 978.5M  0 disk [SWAP]
zram3        252:3    0 978.5M  0 disk [SWAP]
zram4        252:4    0 978.5M  0 disk [SWAP]
zram5        252:5    0 978.5M  0 disk [SWAP]
zram6        252:6    0 978.5M  0 disk [SWAP]
zram7        252:7    0 978.5M  0 disk [SWAP]
nvme0n1      259:0    0 238.5G  0 disk 
...
nvme0n1p10 259:10   0    64M  0 part /boot/efi
...
```
___________

### lscpu

```
Architecture:            aarch64
  CPU op-mode(s):        32-bit, 64-bit
  Byte Order:            Little Endian
CPU(s):                  8
  On-line CPU(s) list:   0-7
Vendor ID:               ARM
  Model name:            Cortex-A78AE
    Model:               1
    Thread(s) per core:  1
    Core(s) per cluster: 4
    Socket(s):           -
    Cluster(s):          2
    Stepping:            r0p1
    CPU max MHz:         1984.0000
    CPU min MHz:         115.2000
    BogoMIPS:            62.50
    Flags:               fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp uscat ilrcpc flagm paca pacg
Caches (sum of all):     
  L1d:                   512 KiB (8 instances)
  L1i:                   512 KiB (8 instances)
  L2:                    2 MiB (8 instances)
  L3:                    4 MiB (2 instances)
NUMA:                    
  NUMA node(s):          1
  NUMA node0 CPU(s):     0-7
Vulnerabilities:         
  Gather data sampling:  Not affected
  Itlb multihit:         Not affected
  L1tf:                  Not affected
  Mds:                   Not affected
  Meltdown:              Not affected
  Mmio stale data:       Not affected
  Retbleed:              Not affected
  Spec rstack overflow:  Not affected
  Spec store bypass:     Mitigation; Speculative Store Bypass disabled via prctl
  Spectre v1:            Mitigation; __user pointer sanitization
  Spectre v2:            Mitigation; CSV2, but not BHB
  Srbds:                 Not affected
  Tsx async abort:       Not affected
```
___________

### dmesg

Interactive command. You can see the plug and unplug USB device for example:
```
sudo dmesg -wT
```

```
[Wed Feb 26 00:24:40 2025] cpufreq: cpu0,cur:1429000,set:729600,delta:699400,set ndiv:57
[Wed Feb 26 00:24:44 2025] cpufreq: cpu0,cur:729000,set:1497600,delta:768600,set ndiv:117
[Wed Feb 26 00:25:00 2025] usb 2-1.1: Found UVC 1.50 device Intel(R) RealSense(TM) 515 (8086:0b64)
[Wed Feb 26 00:25:00 2025] input: Intel(R) RealSense(TM) 515: Int as /devices/platform/bus@0/3610000.usb/usb2/2-1/2-1.1/2-1.1:1.0/input/input153
[Wed Feb 26 00:25:00 2025] usb 2-1.1: Found UVC 1.50 device Intel(R) RealSense(TM) 515 (8086:0b64)
[Wed Feb 26 00:25:00 2025] input: Intel(R) RealSense(TM) 515: Int as /devices/platform/bus@0/3610000.usb/usb2/2-1/2-1.1/2-1.1:1.0/input/input154
[Wed Feb 26 00:25:00 2025] usb 2-1.1: Found UVC 1.50 device Intel(R) RealSense(TM) 515 (8086:0b64)
[Wed Feb 26 00:25:00 2025] input: Intel(R) RealSense(TM) 515: Int as /devices/platform/bus@0/3610000.usb/usb2/2-1/2-1.1/2-1.1:1.0/input/input155
[Wed Feb 26 00:25:01 2025] usb 2-1.1: Found UVC 1.50 device Intel(R) RealSense(TM) 515 (8086:0b64)
[Wed Feb 26 00:25:01 2025] input: Intel(R) RealSense(TM) 515: Int as /devices/platform/bus@0/3610000.usb/usb2/2-1/2-1.1/2-1.1:1.0/input/input156
[Wed Feb 26 00:25:01 2025] usb 2-1.1: Found UVC 1.50 device Intel(R) RealSense(TM) 515 (8086:0b64)
[Wed Feb 26 00:25:01 2025] input: Intel(R) RealSense(TM) 515: Int as /devices/platform/bus@0/3610000.usb/usb2/2-1/2-1.1/2-1.1:1.0/input/input157
[Wed Feb 26 00:25:01 2025] usb 2-1.1: Found UVC 1.50 device Intel(R) RealSense(TM) 515 (8086:0b64)
[Wed Feb 26 00:25:01 2025] cpufreq: cpu0,cur:869000,set:1497600,delta:628600,set ndiv:117
[Wed Feb 26 00:25:22 2025] cpufreq: cpu4,cur:1125000,set:1267200,delta:142200,set ndiv:99
[Wed Feb 26 00:25:24 2025] cpufreq: cpu0,cur:1200000,set:1497600,delta:297600,set ndiv:117

```
___________
Interactive command. Show the available disk space:
```
watch -n1 df
```
```
Every 1.05: df                        <machinename>: Wed Feb 26 00:37:22 2025
Filesystem       1K-blocks     Used        Available     Use%     Mounted on
/dev /nvme0n1p1  243521944     150986968   80091892       66%     /
tmpfs            8015648       3312        8012336         1%     /dev/shm
...
```

___________
Search in libs:

### dpkg

```
dpkg -l | grep "libre*"
```

> i librest-0.7-0:arm64 0.8.1-1.1build2

___________

### apt-cache search
Apt search:

```
apt-cache search gflags
```

```
libgflags-dev - commandline flags module for C++ (development files)
libgflags-doc - documentation of gflags
libgflags2.2 - commandline flags module for C++ (shared library)
python3-gflags - implementation of the Google command line flags module - Python 3.x
python3-typeshed - collection of library stubs for Python, with static types
ros-cmake-modules - Robot OS CMake Modules
```

```
sudo apt-get purge <PACKAGENAME>
sudo apt-get purge $(apt-cache depends <PACKAGENAME> | awk '{ print $2 }' | tr '\n' ' ')
sudo apt-get autoremove
sudo apt-get update
sudo apt-get check
sudo apt-get -f install
sudo apt-get autoclean
Restart if needed
```

___________
### nmap:
```
nmap 192.168.x.x
```
```
Starting Nmap 7.80 ( https://nmap.org ) at 2025-02-26 22:50 XXX
Nmap scan report for <machinename> (192.168.x.x)
Host is up (0.00024s latency).
Not shown: 996 closed ports
PORT     STATE SERVICE
XX/tcp   open  ssh
..
XX/tcp open  vnc
```

___________
### internal ip address:
```
ifconfig -a
```
```
eth0   link encap:Ethernet  HWaddr 00:06:4f:4a:66:f0
    BROADCAST MULTICAST  MTU:1500  Metric:1
    RX packets:0 errors:0 dropped:0 overruns:0 frame:0
    TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
    collisions:0 txqueuelen:1000
    RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth1   link encap:Ethernet  HWaddr 00:16:ec:05:c8:9c 
    BROADCAST MULTICAST  MTU:1500  Metric:1
    RX packets:0 errors:0 dropped:0 overruns:0 frame:0
    TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
    collisions:0 txqueuelen:1000
    RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

lo     Link encap:Local Loopback
    inet addr 127.0.0.1  Mask:255.0.0.0
    inet6 addr:  ::1/128 Scope:Host
    UP LOOPBACK RUNNING MTU:65536  Metric:1
    RX packets:1800 errors:0 dropped:0 overruns:0 frame:0
    Tx packets:1800 errors:0 dropped:0 overruns:0 carrier:0
    collisions:0 txqueuelen:0
    RX bytes:143896 (143.b KB)  TX bytes:143896 (143.8 KB)
```

```
hostname -I
```
_______

### openssl:

### V1: openssl

https://tombuntu.com/index.php/2007/12/12/simple-file-encryption-with-openssl/


To Encrypt:
```
openssl aes-256-cbc -a -salt -in archive.zip -out archive.zip.aes
```

To Decrypt:
```
openssl aes-256-cbc -d -a -in archive.zip.aes -out archive_.zip
```


### V2: Using GPG (Better Alternative to OpenSSL)

To Encrypt:

```
gpg --no-symkey-cache --output archive.zip.aes --symmetric --cipher-algo AES256 archive.zip
```


To Decrypt:

```
gpg --no-symkey-cache --output un_archive.zip --decrypt archive.zip.aes
```

Note: You will be prompted for a password when encrypting or decrypt. And use --no-symkey-cache flag for no cache.


______


### Uninstall package build from source

Q: If I build a package from source how can I uninstall or remove completely?

A: 
https://askubuntu.com/questions/87111/if-i-build-a-package-from-source-how-can-i-uninstall-or-remove-completely

Usually you can just use:
```
make uninstall
```
or
```
sudo make uninstall
```
if the app was installed as root.


But this will work only if the developer of the package has taken care of making a good uninstall rule.
You can also try to get a look at the steps used to install the software by running:

```
make -n install
```
And then try to reverse those steps manually.

In the future to avoid that kind of problems try to use checkinstall instead of make install whenever possible (AFAIK always unless you want to keep both the compiled and a packaged version at the same time). It will create and install a deb file that you can then uninstall using your favorite package manager.

make clean usually cleans the building directories, it doesn't uninstall the package. It's used when you want to be sure that the whole thing is compiled, not just the changed files.


____

### Install "deb" package:

Download filenane.deb package and install:
```
sudo dpkg -i filenane.deb
```
_______

### Record audio by MIC to WAV file:

```
sudo apt install sox
```
```
rec -c 1 -r 44100 audio.wav
```
`Control+C` to stop
_______

### WAV file info:
```
soxi jfk.wav
```

```
Input File     : 'jfk.wav'
Channels       : 1
Sample Rate    : 16000
Precision      : 16-bit
Duration       : 00:00:11.00 = 176000 samples ~ 825 CDDA sectors
File Size      : 352k
Bit Rate       : 256k
Sample Encoding: 16-bit Signed Integer PCM
```
_______

### All net traffic:

nload
```
sudo apt install nload
nload wlp1s0
```

nethogs
```
sudo apt install nethogs
sudo nethogs wlp1s0
```

iftop
```
sudo apt install iftop
sudo iftop -i wlp1s0
```

wireshark
```
sudo apt install wireshark
sudo tcpdump -i wlp1s0 -n
```

_______

### service check

```
systemctl list-units --type=service --state=running
```
```
UNIT                LOAD   ACTIVE SUB     DESCRIPTION
cron.service        loaded active running Regular background program processing daemon
networkd-dispatcher loaded active running Dispatcher daemon for systemd-networkd
...
```


_______

### reboot

```
sudo reboot
```

_______

### shutdown

```
sudo shutdown now
sudo shutdown -r now
```


