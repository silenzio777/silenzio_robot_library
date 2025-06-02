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
- P- Number: p3767-0000
- Module: NVIDIA Jetson Orin NX (16GB ram)
- Soc: tegra234
- LAT: 36.4.3
- Jetpack: 6.2


$ cat /etc/nv_tegra_release
> # R36 (release), REVISION: 4.3, GCID: 38968081, BOARD: generic, EABI: aarch64, DATE: Wed Jan  8 01:49:37 UTC 2025
  # KERNEL_VARIANT: oot
  TARGET_USERSPACE_LIB_DIR=nvidia
  TARGET_USERSPACE_LIB_DIR_PATH=usr/lib/aarch64-linux-gnu/nvidia
