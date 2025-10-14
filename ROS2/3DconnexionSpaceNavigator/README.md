```
$ cd ~/lib/
```

```
silenzio@ubuntuPC:~/lib$ git clone https://github.com/ros-drivers/joystick_drivers.git
```

```
Cloning into 'joystick_drivers'...
remote: Enumerating objects: 3365, done.
remote: Counting objects: 100% (394/394), done.
remote: Compressing objects: 100% (130/130), done.
remote: Total 3365 (delta 327), reused 264 (delta 264), pack-reused 2971 (from 2)
Receiving objects: 100% (3365/3365), 812.13 KiB | 3.49 MiB/s, done.
Resolving deltas: 100% (2040/2040), done.
```
```
silenzio@ubuntuPC:~/lib$ rosdep install --from-paths /home/silenzio/lib/joystick_drivers/spacenav
```
```
executing command [sudo -H apt-get install libspnav-dev]
[sudo] password for silenzio: 
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following packages were automatically installed and are no longer required:
...
Use 'sudo apt autoremove' to remove them.
The following NEW packages will be installed:
  libspnav-dev
0 upgraded, 1 newly installed, 0 to remove and 784 not upgraded.
Need to get 13.9 kB of archives.
After this operation, 81.9 kB of additional disk space will be used.
Get:1 http://us.archive.ubuntu.com/ubuntu jammy/universe amd64 libspnav-dev amd64 0.2.3-1 [13.9 kB]
Fetched 13.9 kB in 0s (28.0 kB/s)       
Selecting previously unselected package libspnav-dev.
(Reading database ... 403867 files and directories currently installed.)
Preparing to unpack .../libspnav-dev_0.2.3-1_amd64.deb ...
Unpacking libspnav-dev (0.2.3-1) ...
Setting up libspnav-dev (0.2.3-1) ...
executing command [sudo -H apt-get install spacenavd]
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
...
Use 'sudo apt autoremove' to remove them.
The following NEW packages will be installed:
  spacenavd
0 upgraded, 1 newly installed, 0 to remove and 784 not upgraded.
Need to get 35.6 kB of archives.
After this operation, 116 kB of additional disk space will be used.
Get:1 http://us.archive.ubuntu.com/ubuntu jammy/universe amd64 spacenavd amd64 0.7.1-1 [35.6 kB]
Fetched 35.6 kB in 0s (82.9 kB/s)   
Selecting previously unselected package spacenavd.
(Reading database ... 403886 files and directories currently installed.)
Preparing to unpack .../spacenavd_0.7.1-1_amd64.deb ...
Unpacking spacenavd (0.7.1-1) ...
Setting up spacenavd (0.7.1-1) ...
Created symlink /etc/systemd/system/graphical.target.wants/spacenavd.service → /lib/systemd/system/spacenavd.service.
Processing triggers for man-db (2.10.2-1) ...
#All required rosdeps installed successfully
```

```
cp ~/lib/spacenav ~/ros2_ws/src
```

```
cd ~/ros2_ws$
colcon build --packages-select spacenav
```

```
cd ~/ros2_ws && source install/setup.bash
```

```
ros2 run spacenav spacenav_node
```
