### Ubuntu 22.04 commands:

### How to switch boot target to text or GUI in systemd Linux:

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


___________
```
spci
```
```
0001:00:00.0 PCI bridge: NVIDIA Corporation Device 229e (rev a1)
0001:01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8822CE 802.11ac PCIe Wireless Network Adapter
0004:00:00.0 PCI bridge: NVIDIA Corporation Device 229c (rev a1)
0004:01:00.0 Non-Volatile memory controller: Silicon Motion, Inc. SM2263EN/SM2263XT SSD Controller (rev 03)
0008:00:00.0 PCI bridge: NVIDIA Corporation Device 229c (rev a1)
0008:01:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 15)
```
___________
```
lsblk
```

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
```
lscpu
```

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
Interactive command. Show the available disk space:
```
___________
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

```
dpkg -l | grep "libre*"
```

> i librest-0.7-0:arm64 0.8.1-1.1build2

___________
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
Copy
nmap 192.168.x.x
Copy
Starting Nmap 7.80 ( https://nmap.org ) at 2025-02-26 22:50 XXX
Nmap scan report for <machinename> (192.168.x.x)
Host is up (0.00024s latency).
Not shown: 996 closed ports
PORT     STATE SERVICE
XX/tcp   open  ssh
..
XX/tcp open  vnc
```
