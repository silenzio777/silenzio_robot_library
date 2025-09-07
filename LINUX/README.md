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
### service stop/start

```
systemctl status  yahboom_oled.service
systemctl stop yahboom_oled.service
systemctl status  yahboom_oled.service
systemctl start yahboom_oled.service
```

### Clean the system 

```
sudo apt clean
sudo apt autoclean
```

Show logs:
```
journalctl --disk-usage
Archived and active journals take up 24.0M in the file system.
```

Clean old logs:
```
sudo journalctl --vacuum-time=7d # Delete older then 7 days
sudo journalctl --vacuum-size=500M # Delete bigger then 500 M
```

Clean user cache:
```
rm -rf ~/.cache/* 
rm -rf ~/.cache/thumbnails/*
sudo rm -rf ~/.local/share/Trash/*
```


Apt autoremove check, before run "sudo apt autoremove":
```
sudo apt autoremove --dry-run

Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
0 upgraded, 0 newly installed, 0 to remove and 432 not upgraded.
```

```
sudo apt autoremove
```

GUI app:

```
sudo apt install bleachbit
sudo bleachbit
```

```
sudo apt install stacer
stacer
```

Best!
```
sudo apt install ncdu

sudo ncdu /

sudo ncdu / --exclude /mnt --exclude /media
```

```
sudo apt install gdu
sudo gdu /
```

______

Чтобы сравнить два корневых каталога на HDD и SSD в Ubuntu, включая все вложенные файлы и папки, используйте следующие методы:
Сравнение с diff
Рекурсивное сравнение содержимого файлов и структуры:

```
diff -rq /путь/к/HDD/каталог /путь/к/SSD/каталог
```

Опции:

-r — рекурсивно (включая подкаталоги).
-q — краткий вывод (только имена различающихся файлов).

Пример вывода:
```
Files /путь/к/HDD/каталог/file.txt and /путь/к/SSD/каталог/file.txt differ
Only in /путь/к/HDD/каталог: unique_file
```

Сообщение Only in /home/silenzio/: .bash_profile означает, что файл (или директория) .bash_profile существует только в исходном каталоге (/home/silenzio/), но полностью отсутствует в целевом каталоге резервной копии (/mnt/SSD_BACKUP_512/...).

___

Да, стандартная утилита diff не сортирует вывод по размеру файлов, но вы можете комбинировать её с другими инструментами для достижения этого. Вот как это сделать:

1. Сначала получите список всех различающихся файлов:
```
diff -rq '/home/silenzio/' '/mnt/SSD_BACKUP_512/backup_2025-05-31/home/silenzio/' > all_diffs.txt
```

2. Извлеките пути к файлам и отсортируйте по размеру:
```
# Обрабатываем оба типа различий:
# 1. "Files A and B differ" -> берем первый путь
# 2. "Only in DIR: file" -> формируем полный путь
awk '
    /^Files / {print $2}
    /^Only in / {gsub(":$", "", $3); print $3 "/" $4}
' all_diffs.txt | \
xargs -I{} du -sh "{}" | \
sort -h > differences_by_size.txt
```

Пояснение:
awk обрабатывает вывод diff:

```
Для строк Files... извлекает путь (второе поле)
Для строк Only in... комбинирует директорию и имя файла
gsub удаляет двоеточие в конце пути директории
xargs передает каждый путь в du -sh для получения размера
sort -h сортирует вывод по размеру (human-readable):
Мелкие файлы вверху, крупные внизу
Для обратной сортировки добавьте -r: sort -rh
```

Пример вывода:
```
text
12K    /home/silenzio/.bash_history
4.0K   /home/silenzio/.bash_profile
1.2M   /home/silenzio/documents/report.pdf
```

Расшифровка операторов:

> differences_by_size.txt - создает/перезаписывает файл с результатами

2>/dev/null - подавляет ошибки "Нет такого файла" (если некоторые файлы были удалены после выполнения diff)

Для дозаписи в конец файла (вместо перезаписи):
```
... >> existing_file.txt
```


______

Графический интерфейс (Meld)
Установите и запустите инструмент:

```
sudo apt install meld
```

```
meld /путь/к/HDD/каталог /путь/к/SSD/каталог
```

- Визуальное сравнение с подсветкой изменений.
- Поддержка синхронизации файлов.

______

## Python submodule fix by hands.
Install packet by localy, update the whisper.cpp and fix they CMakeLists.txt:

```
git clone https://github.com/carloscdias/whisper-cpp-python
cd whisper-cpp-python
```

### update the whisper.cpp
```
git submodule update --init --recursive
```

### fix they CMakeLists.txt:
```
sed -i '1s/3.0/3.5/' vendor/whisper.cpp/CMakeLists.txt
```

### install python package from local copy:
```
pip install .
```


__________
### "git clone" a repo, including its submodules:

```
git clone --recurse-submodules -j8 https://github.com/OpenNMT/CTranslate2
```

_______

### Change external SSD from UID (de820c0d-...) to custom name "SSD_BACKUP_512"

```
sudo mkdir /mnt/SSD_BACKUP_512
sudo umount /dev/sda2
```

```
sudo mount /dev/sda2 /mnt/SSD_BACKUP_512
```

Edit /etc/fstab:

```
sudo nano /etc/fstab
```

Add at the end of file:

```
# Custom mount for backup SSD
UUID=de820c0d-4633-407e-a630-6ce97a3cab64 /mnt/SSD_BACKUP_512 ext4 defaults 0 2
```

Remount all mounted disk:
```
sudo mount -a
```

Check new disk%
```
df -h | grep sda2
ls /mnt/SSD_BACKUP_512
```

_____

## Backup with Rsync:

```
mount | grep sda2
```

You should see:
```
/dev/sda2 on /mnt/SSD_BACKUP_512 type ext4 (rw,relatime)
```

2. Создание точки для бэкапа

На SSD создадим отдельную папку для бэкапа (например, с текущей датой):

```
sudo mkdir -p /mnt/SSD_BACKUP_512/backup_$(date +%Y-%m-%d)
```

3. Команда rsync для полного бэкапа
Выполните следующую команду (важно! запускайте через sudo):

```
sudo rsync -aAXHv --delete \
--exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} \
/ /mnt/SSD_BACKUP_512/backup_$(date +%Y-%m-%d)
```

Check backup copy:
```
df -h /dev/sda2
ls -lh /mnt/SSD_BACKUP_512/backup_$(date +%Y-%m-%d)
```

____

## Restory from backup with Rsync:

Важные замечания:
Первый запуск займет много времени (зависит от объема данных)

Последующие бэкапы будут быстрее (копируются только изменения)

Для восстановления:

Разметить новый диск

Скопировать данные обратно через rsync (смена источника и приемника)

Установить загрузчик (grub-install)

Дополнительные советы:
Автоматизация: Добавьте команду в cron для регулярных бэкапов

Проверка: Периодически проверяйте целостность бэкапа

Хранение: Храните SSD отдельно от устройства

Пример команды для инкрементного бэкапа (только изменения):

```
sudo rsync -aAXHv --delete / /путь/к/бэкапу
```

Для восстановления загрузчика после копирования данных:

```
sudo chroot /target
mount /dev/nvme0n1p1 /boot
grub-install /dev/nvme0n1
update-grub
exit
```

_______

Для создания полного, восстанавливаемого бэкапа системы на NVIDIA Jetson Orin NX (включая загрузчик, системные файлы и конфигурации) нужно учитывать особенности архитектуры ARM и специфику загрузки Jetson. Вот надежный метод:

Полный бэкап системы Jetson Orin NX (с возможностью восстановления "как было")
1. Бэкап загрузчика и таблицы разделов (критически важно!)

```
sudo -i
BACKUP_DIR="/mnt/SSD_BACKUP_512/full_system_backup_$(date +%Y-%m-%d)"
mkdir -p $BACKUP_DIR
```

# Сохраняем таблицу разделов
```
sfdisk -d /dev/nvme0n1 > $BACKUP_DIR/partition_table_backup.txt
```

# Сохраняем загрузочный сектор (MBR)
```
dd if=/dev/nvme0n1 bs=512 count=1 of=$BACKUP_DIR/mbr_backup.bin
```

# Сохраняем загрузчик (UEFI/TrustedOS разделы)
``` 
dd if=/dev/nvme0n1p1 of=$BACKUP_DIR/bootloader_partition.img
```

2. Бэкап корневой файловой системы

```
rsync -aAXHv --delete \
--exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/var/log/*"} \
/ $BACKUP_DIR/rootfs
```

3. Бэкап метаданных системы

# Информация о блочных устройствах
```
lsblk > $BACKUP_DIR/lsblk.txt
```

# UUID разделов
```
blkid > $BACKUP_DIR/blkid.txt
```

# Список установленных пакетов
```
dpkg --get-selections > $BACKUP_DIR/package_list.txt
```

Восстановление системы из бэкапа (краткий алгоритм)
Создать разделы на новом диске по сохраненной таблице (sfdisk /dev/nvme0n1 < partition_table_backup.txt)

Восстановить загрузочный сектор: dd if=mbr_backup.bin of=/dev/nvme0n1

Восстановить загрузчик: dd if=bootloader_partition.img of=/dev/nvme0n1p1

Восстановить файловую систему: rsync -aAXHv rootfs/ /

Обновить конфигурацию загрузчика: chroot / update-grub

Особенности для NVIDIA Jetson
Для полного восстановления Jetson вам дополнительно понадобится:

Сохранить образы BSP:

```
cp /boot/Image $BACKUP_DIR/
cp /boot/initrd $BACKUP_DIR/
cp -r /boot/dtb $BACKUP_DIR/
```

Бэкап NVIDIA-specific разделов:

```
dd if=/dev/nvme0n1p7 of=$BACKUP_DIR/APP_boot.img  # BOOT раздел
dd if=/dev/nvme0n1p8 of=$BACKUP_DIR/APP_root.img  # ROOT раздел
```

Автоматизированный скрипт для бэкапа
Создайте файл /usr/local/bin/full_jetson_backup.sh:

bash
#!/bin/bash

BACKUP_ROOT="/mnt/SSD_BACKUP_512"
DATE=$(date +%Y%m%d)
BACKUP_DIR="$BACKUP_ROOT/jetson_full_$DATE"

mkdir -p $BACKUP_DIR/{boot,partitions}

# 1. Backup partition table
sfdisk -d /dev/nvme0n1 > $BACKUP_DIR/partition_table.sfdisk

# 2. Backup critical partitions
dd if=/dev/nvme0n1p1  of=$BACKUP_DIR/partitions/bootloader.img
dd if=/dev/nvme0n1p7  of=$BACKUP_DIR/partitions/APP_boot.img
dd if=/dev/nvme0n1p8  of=$BACKUP_DIR/partitions/APP_root.img

# 3. Backup kernel and initrd
cp /boot/Image $BACKUP_DIR/boot/
cp /boot/initrd $BACKUP_DIR/boot/
cp -r /boot/dtb $BACKUP_DIR/boot/

# 4. Backup rootfs
rsync -aAXH --info=progress2 --delete \
--exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/var/log/*"} \
/ $BACKUP_DIR/rootfs

# 5. System metadata
dpkg --get-selections > $BACKUP_DIR/installed_packages.txt
lsblk > $BACKUP_DIR/disk_layout.txt

echo "Full backup completed to $BACKUP_DIR"
Сделайте исполняемым:

bash
sudo chmod +x /usr/local/bin/full_jetson_backup.sh
Важные предупреждения
Для восстановления потребуется Live USB с Ubuntu for ARM

Размер бэкапа должен быть больше размера вашей системы

Всегда проверяйте бэкап:

bash
sudo chroot $BACKUP_DIR/rootfs /bin/bash -c "echo 'Backup verified'"
Для критических систем NVIDIA рекомендует использовать SDK Manager для создания официальных образов восстановления

Альтернатива: Инструменты NVIDIA
Для полного резервного копирования с гарантией восстановления:

bash
sudo apt install nvpmodel nvsysinfo
sudo nvpmodel -d full_backup.img --backup
Это создаст официальный образ системы, совместимый с JetPack SDK.

Рекомендую сочетать оба подхода: регулярные бэкапы через rsync и раз в месяц полный системный образ через nvpmodel.

______

### Install nomachine:

Get DEB:
https://downloads.nomachine.com/download/?id=30&platform=linux&distro=arm

```
sudo dpkg -i nomachine_9.0.188_11_arm64.deb
```
______

### Install compizconfig-settings-manager:

```
sudo apt-get install compizconfig-settings-manager
```
```
compizconfig-settings-manager
```

### disable the Super key:

```
gsettings set org.gnome.mutter overlay-key ''
```
_____

### Cursor.ai install WO Fuse:

Ubuntu 22.04 will break after sudo apt install fuse. Don't do it! It took me a half day to recover the OS. I saw many times the sudo apt install fuse libfuse2 advice (both fuse and libfuse2 packages). But as I was corrected in a comment the libfuse2 shouldn't break Ubuntu.

```
apt install --simulate fuse
```
The following packages will be REMOVED: fuse3 gnome-remote-desktop gnome-session gnome-shell-extension-desktop-icons-ng gnome-snapshot gvfs-fuse nautilus shotwell ubuntu-desktop ubuntu-desktop-minimal ubuntu-gnome-desktop ubuntu-session xdg-desktop-portal xdg-desktop-portal-gnome xdg-desktop-portal-gtk

Ubuntu 22.04 has fuse3 from the box and the installation of the old fuse lib removes many system packages and breaks the system.

Here are the save instructions for installing Cursor AI IDE on Ubuntu without any fuse package:

Make the downloaded image executable
```
chmod +x cursor-0.44.11-build-250103fqxdt5u9z-x86_64.AppImage
```

A: FRESH INSTALL:
Extract Cursor files without FUSE
```
mkdir -p ~/.local/bin/cursor
./cursor-0.44.11-build-250103fqxdt5u9z-x86_64.AppImage --appimage-extract
mv squashfs-root/* ~/.local/bin/cursor/
```

B: UPDATE:
Move old version (Or just delete):
```
sudo chown silenzio:silenzio '/home/silenzio/.local/bin/cursor' -R
sudo mv /home/silenzio/.local/bin/cursor/* /home/silenzio/tmp/cursor_old 
```


Install new versiom:
```
cp /home/silenzio/Downloads/Cursor-1.2.2-x86_64.AppImage /home/silenzio/.local/bin/cursor
chmod +x Cursor-1.2.2-x86_64.AppImage
./Cursor-1.2.2-x86_64.AppImage --appimage-extract
```


Fix the sandbox permissions
```
sudo chown root:root ~/.local/bin/cursor/chrome-sandbox
sudo chmod 4755 ~/.local/bin/cursor/chrome-sandbox
```

Run Cursor
```
./cursor/AppRun
```

Create a desktop shortcut
```
mkdir -p ~/.local/share/applications
echo "[Desktop Entry]
Name=Cursor
Exec=$HOME/.local/bin/cursor/AppRun
Icon=$HOME/.local/bin/cursor/cursor.png
Type=Application
Categories=Development;" > ~/.local/share/applications/cursor.desktop
```

_______

### aux, awk, top

Базовый вариант (с заголовком)

```
ps aux | awk 'NR==1 || $3 > 50.0'
```
NR==1: Выводит первую строку (заголовок).
$3 > 50.0: Фильтрует процессы, где 3-я колонка (%CPU) > 50%.
⚠️ Заголовок выводится всегда, даже если нет процессов > 50%.

Точный вариант (без лишних строк)
```
ps aux | awk '$3 > 50.0'
```

Сортировка по убыванию CPU
```
ps aux --sort=-%cpu | awk '$3 > 50.0'
```

ps aux выводит процессы в формате:
```
USER  PID  %CPU  %MEM  VSZ   RSS  TTY  STAT  START  TIME  COMMAND
```
awk анализирует колонки:
```
$3 → %CPU (3-я колонка)
$1 → пользователь
$2 → PID
$11 → команда (частично, см. примечание ниже)
```

Альтернатива: top
Если нужно интерактивное отслеживание:

```
top -o %CPU -c
```

-o %CPU: сортировка по CPU.
-c: показ полных команд.
______

### Wait for service start: jtop.service and run the command:

- file: /home/silenzio/lib/systemInfo/systemInfo.sh

```
#!/bin/bash

# Wait for start: jtop.service
while ! systemctl is-active --quiet jtop.service; do
    sleep 1
done

cd ~/ros2_ws && source install/setup.bash
xterm -bg black -fg white -hold -e python3 /home/silenzio/lib/systemInfo/systemInfo.py
```
_______

### Check version of system python
```
python3 --version
```

### Find out where system Python looks for packages
```
python3 -c "import sys; print('\n'.join(sys.path))"
```

# Find out where pip installs packages
```
python3 -c "import site; print(site.getsitepackages())"
```


_______

### wget with cookies%
```
wget --load-cookies ~/Downloads/cookies.txt --continue "https://site.com/large_file.zip"
wget --load-cookies ~/Downloads/cookies.txt --continue --content-disposition "https://site.com/large_file.zip"
```


_______

### get nvme ssd drive list :
```
$ sudo nvme list
```
```
Node                  SN                   Model                                    Namespace Usage                      Format           FW Rev  
--------------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
/dev/nvme0n1          AA00000000035        SSD 256GB                                1         256.06  GB / 256.06  GB    512   B +  0 B   T1103L0L
/dev/nvme1n1          180693800757         WDC WDS256G1X0C-00ENX0                   1         256.06  GB / 256.06  GB    512   B +  0 B   B35900WD
```
- smart info:
```
$ sudo nvme smart-log /dev/nvme1n1
Smart Log for NVME device:nvme1n1 namespace-id:ffffffff
critical_warning			: 0
temperature				: 40 C (313 Kelvin)
available_spare				: 100%
available_spare_threshold		: 4%
percentage_used				: 17%
endurance group critical warning summary: 0
data_units_read				: 16,338,028
data_units_written			: 54,329,341
host_read_commands			: 299,247,072
host_write_commands			: 1,424,914,546
controller_busy_time			: 330,178
power_cycles				: 208
power_on_hours				: 50,292
unsafe_shutdowns			: 24
media_errors				: 0
num_err_log_entries			: 1
Warning Temperature Time		: 0
Critical Composite Temperature Time	: 0
Thermal Management T1 Trans Count	: 0
Thermal Management T2 Trans Count	: 0
Thermal Management T1 Total Time	: 0
Thermal Management T2 Total Time	: 0
```
```
silenzio@jetsonnx:~/ros2_ws$ sudo nvme smart-log /dev/nvme0n1
Smart Log for NVME device:nvme0n1 namespace-id:ffffffff
critical_warning			: 0
temperature				: 45 C (318 Kelvin)
available_spare				: 100%
available_spare_threshold		: 10%
percentage_used				: 0%
endurance group critical warning summary: 0
data_units_read				: 6,089,028
data_units_written			: 4,454,575
host_read_commands			: 63,923,688
host_write_commands			: 24,033,367
controller_busy_time			: 2,708
power_cycles				: 242
power_on_hours				: 1,332
unsafe_shutdowns			: 43
media_errors				: 0
num_err_log_entries			: 0
Warning Temperature Time		: 0
Critical Composite Temperature Time	: 0
Thermal Management T1 Trans Count	: 5
Thermal Management T2 Trans Count	: 0
Thermal Management T1 Total Time	: 65
Thermal Management T2 Total Time	: 0
```

_______

### If you're on X11, gnome-shell should automatically restart:
```
killall -3 gnome-shell
```
_______

### Stop all Ollama models:

```
sudo systemctl stop ollama
```

### Run Ollama service again:
```
sudo systemctl start ollama
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


