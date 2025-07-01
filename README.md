# silenzio_robot_library


- [Hardware](HARDWARE/README.md)<br/>
- [Ubuntu Setup and Commands](LINUX/README.md)<br/>
- [Docker Setup and Commands](LINUX/Docker/README.md)<br/>
- [ROS1 noetic](ROS1/README.md)<br/>
- [ROS2 humble](ROS2/README.md)<br/>
- [ROS2/MECANUM](ROS2/MECANUM)<br/>

____

### Current Hardware & Software Setup


```
?ipe.z3sd@bfewtsgn2e:$ neofetch
            .-/+oossssoo+/-.               ?ipe.z3sd@bfewtsgn2e 
        `:+ssssssssssssssssss+:`           ----------------- 
      -+ssssssssssssssssssyyssss+-         OS: Ubuntu 22.04.5 LTS aarch64 
    .ossssssssssssssssssdMMMNysssso.       Host: NVIDIA Jetson Orin NX Engineering Reference Developer Kit Super 
   /ssssssssssshdmmNNmmyNMMMMhssssss/      Kernel: 5.15.148-tegra 
  +ssssssssshmydMMMMMMMNddddyssssssss+     Uptime: 13 hours, 33 mins 
 /sssssssshNMMMyhhyyyyhmNMMMNhssssssss/    Packages: 3711 (dpkg), 11 (snap) 
.ssssssssdMMMNhsssssssssshNMMMdssssssss.   Shell: bash 5.1.16 
+sssshhhyNMMNyssssssssssssyNMMMysssssss+   Resolution: 2560x1440 
ossyNMMMNyMMhsssssssssssssshmmmhssssssso   DE: GNOME 42.9 
ossyNMMMNyMMhsssssssssssssshmmmhssssssso   WM: Mutter 
+sssshhhyNMMNyssssssssssssyNMMMysssssss+   WM Theme: Adwaita 
.ssssssssdMMMNhsssssssssshNMMMdssssssss.   Theme: Yaru-dark [GTK2/3] 
 /sssssssshNMMMyhhyyyyhdNMMMNhssssssss/    Icons: Yaru [GTK2/3] 
  +sssssssssdmydMMMMMMMMddddyssssssss+     Terminal: gnome-terminal 
   /ssssssssssshdmNNNNmyNMMMMhssssss/      CPU: ARMv8 rev 1 (v8l) (8) @ 1.984GHz 
    .ossssssssssssssssssdMMMNysssso.       Memory: 8251MiB / 15655MiB 
      -+sssssssssssssssssyyyssss+-
        `:+ssssssssssssssssss+:`                                   
            .-/+oossssoo+/-.                                       
```

### Dev-board: nVIDIA Jetson Orin NX 16GB

Platform:
- Machine: aarch64
- System: Linux
- Distribution: Ubuntu 22.04 Jammy Jellyfish
- Release: 5.15.148-tegra
- Python: 3.10.12

Libraries:
- CUDA: 12.6.68
- CUDNN: 9.3.0.75
- TensorT: 10.3.0.30
- VPI: 3.2.4
- Vulkan: 1.3.204
- OpenCV: 4.10.0 with CUDA: YES

Hardware:
- Model: NVIDIA Jetson Orin NX Engineering Reference Developer Kit Super
- 699-level Part Number: 699-13767-0000-301 G.1
- P-Number: p3767-0000
- Module: NVIDIA Jetson Orin NX (16GB ram)
- Soc: tegra234
- LAT: 36.4.3
- Jetpack: 6.2

```
$ cat /etc/nv_tegra_release
```
```
# R36 (release), REVISION: 4.3, GCID: 38968081, BOARD: generic, EABI: aarch64, DATE: Wed Jan  8 01:49:37 UTC 2025
# KERNEL_VARIANT: oot
TARGET_USERSPACE_LIB_DIR=nvidia
TARGET_USERSPACE_LIB_DIR_PATH=usr/lib/aarch64-linux-gnu/nvidia
```
```
$ docker info | grep -i runtime
```

```
 Runtimes: io.containerd.runc.v2 nvidia runc
 Default Runtime: nvidia
```
__________

### Dev-board: nVIDIA Jetson Nano 4GB

```
            .-/+oossssoo+/-.               dj7dHd@09sKncj 
        `:+ssssssssssssssssss+:`           --------------- 
      -+ssssssssssssssssssyyssss+-         OS: Ubuntu 20.04.6 LTS aarch64 
    .ossssssssssssssssssdMMMNysssso.       Host: NVIDIA Jetson Nano Developer Kit 
   /ssssssssssshdmmNNmmyNMMMMhssssss/      Kernel: 4.9.253-tegra 
  +ssssssssshmydMMMMMMMNddddyssssssss+     Uptime: 1 hour, 5 mins 
 /sssssssshNMMMyhhyyyyhmNMMMNhssssssss/    Packages: 3498 (dpkg), 10 (snap) 
.ssssssssdMMMNhsssssssssshNMMMdssssssss.   Shell: bash 5.0.17 
+sssshhhyNMMNyssssssssssssyNMMMysssssss+   Resolution: 1280x1024 
ossyNMMMNyMMhsssssssssssssshmmmhssssssso   DE: GNOME 
ossyNMMMNyMMhsssssssssssssshmmmhssssssso   WM: Mutter 
+sssshhhyNMMNyssssssssssssyNMMMysssssss+   WM Theme: Adwaita 
.ssssssssdMMMNhsssssssssshNMMMdssssssss.   Theme: Yaru-dark [GTK2/3] 
 /sssssssshNMMMyhhyyyyhdNMMMNhssssssss/    Icons: Yaru [GTK2/3] 
  +sssssssssdmydMMMMMMMMddddyssssssss+     Terminal: gnome-terminal 
   /ssssssssssshdmNNNNmyNMMMMhssssss/      CPU: ARMv8 rev 1 (v8l) (4) @ 1.479GHz 
    .ossssssssssssssssssdMMMNysssso.       Memory: 1141MiB / 3962MiB 
      -+sssssssssssssssssyyyssss+-
        `:+ssssssssssssssssss+:`
            .-/+oossssoo+/-.
```

```
# R32 (release), REVISION: 6.1, GCID: 27863751, BOARD: t210ref, EABI: aarch64, DATE: Mon Jul 26 19:20:30 UTC 2021
```

Platform:
- Machine: aarch64
- System: Linux
- Distribution: Ubuntu 20.04 focal
- Release: 4.9.253-tegra
- Python: 3.8.10
  
Libraries:
- CUDA: 10.2.300
- CUDNN: 8.2.1.32
- TensorRT: 8.0.1.6
- VPI: 1.1.15
- Vulkan: 1.2.141
- OpencV: 4.6.0 with CUDA: YES

Hardware:
- Model: NVIDIA Jetson Nano Developer Kit
- 699-level Part Number: 699-13448-0000-402 K.0
- P-Number: p3448-0000
- Module: NVIDIA Jetson Nano (4 GB ram)
- Soc: tegra210
- CUDA Arch BIN: 5.3
- Codename: Porg
- LAT: 32.6.1
- Jetpack: 4.6

________________

### Ubuntu PC:

```
            .-/+oossssoo+/-.               kjd6dfH@nchdJYE82
        `:+ssssssssssssssssss+:`           ----------------- 
      -+ssssssssssssssssssyyssss+-         OS: Ubuntu 22.04.5 LTS x86_64 
    .ossssssssssssssssssdMMMNysssso.       Host: Z370 AORUS Gaming 3 
   /ssssssssssshdmmNNmmyNMMMMhssssss/      Kernel: 6.8.0-60-generic 
  +ssssssssshmydMMMMMMMNddddyssssssss+     Uptime: 1 hour, 15 mins 
 /sssssssshNMMMyhhyyyyhmNMMMNhssssssss/    Packages: 4186 (dpkg), 17 (snap) 
.ssssssssdMMMNhsssssssssshNMMMdssssssss.   Shell: bash 5.1.16 
+sssshhhyNMMNyssssssssssssyNMMMysssssss+   Resolution: 2560x1440 
ossyNMMMNyMMhsssssssssssssshmmmhssssssso   DE: GNOME 42.9 
ossyNMMMNyMMhsssssssssssssshmmmhssssssso   WM: Mutter 
+sssshhhyNMMNyssssssssssssyNMMMysssssss+   WM Theme: Adwaita 
.ssssssssdMMMNhsssssssssshNMMMdssssssss.   Theme: Yaru-dark [GTK2/3] 
 /sssssssshNMMMyhhyyyyhdNMMMNhssssssss/    Icons: Yaru [GTK2/3] 
  +sssssssssdmydMMMMMMMMddddyssssssss+     Terminal: gnome-terminal 
   /ssssssssssshdmNNNNmyNMMMMhssssss/      CPU: Intel i7-8700K (12) @ 4.700GHz 
    .ossssssssssssssssssdMMMNysssso.       GPU: NVIDIA GeForce GTX 1050 Ti 
      -+sssssssssssssssssyyyssss+-         Memory: 1828MiB / 32036MiB 
        `:+ssssssssssssssssss+:`
            .-/+oossssoo+/-.

```

Platform:
- Machine: ×86_64
- System: Linux
- Distribution: Ubuntu 22.04 Jammy Jellyfish
- Release: 6.8.0-60-generic
- Python: 3.10.12

Libraries:
- CUDA: 12.8.93
- CUDNN: 9.8.0
- TensorRT: MISSING
- VPI: MISSING
- OpenCV: 4.5.4 with CUDA: NO

Hardware:
- Bios date: 07/05/2018
- Bios vendor: American Megatrends Inc.
- Bios version: F7
- Board name: Z370 AORUS Gaming 3
- Board vendor: Gigabyte Technology Co., Ltd.
- Board version: X.X
- Product name: Z370 AORUS Gaming 3
- Sys vendor: Gigabyte Technology Co., Ltd.
