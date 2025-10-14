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
  chromium-codecs-ffmpeg-extra libbenchmark-dev libbenchmark1 libgraphics-magick-perl libgraphicsmagick++-q16-12
  libgraphicsmagick++1-dev libgraphicsmagick-q16-3 libgraphicsmagick1-dev libxtensor-dev nvidia-firmware-550-550.120
  python3-rosdistro ros-humble-behaviortree-cpp-v3 ros-humble-bond ros-humble-bondcpp ros-humble-costmap-queue
  ros-humble-dwb-core ros-humble-dwb-critics ros-humble-dwb-msgs ros-humble-dwb-plugins ros-humble-nav-2d-msgs
  ros-humble-nav-2d-utils ros-humble-nav2-amcl ros-humble-nav2-behavior-tree ros-humble-nav2-behaviors
  ros-humble-nav2-bt-navigator ros-humble-nav2-collision-monitor ros-humble-nav2-common
  ros-humble-nav2-constrained-smoother ros-humble-nav2-controller ros-humble-nav2-core ros-humble-nav2-costmap-2d
  ros-humble-nav2-dwb-controller ros-humble-nav2-lifecycle-manager ros-humble-nav2-mppi-controller
  ros-humble-nav2-msgs ros-humble-nav2-navfn-planner ros-humble-nav2-planner
  ros-humble-nav2-regulated-pure-pursuit-controller ros-humble-nav2-rotation-shim-controller
  ros-humble-nav2-rviz-plugins ros-humble-nav2-simple-commander ros-humble-nav2-smac-planner ros-humble-nav2-smoother
  ros-humble-nav2-theta-star-planner ros-humble-nav2-util ros-humble-nav2-velocity-smoother ros-humble-nav2-voxel-grid
  ros-humble-nav2-waypoint-follower ros-humble-smclib xtl-dev
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
The following packages were automatically installed and are no longer required:
  chromium-codecs-ffmpeg-extra libbenchmark-dev libbenchmark1 libgraphics-magick-perl libgraphicsmagick++-q16-12 libgraphicsmagick++1-dev
  libgraphicsmagick-q16-3 libgraphicsmagick1-dev libxtensor-dev nvidia-firmware-550-550.120 python3-rosdistro ros-humble-behaviortree-cpp-v3
  ros-humble-bond ros-humble-bondcpp ros-humble-costmap-queue ros-humble-dwb-core ros-humble-dwb-critics ros-humble-dwb-msgs
  ros-humble-dwb-plugins ros-humble-nav-2d-msgs ros-humble-nav-2d-utils ros-humble-nav2-amcl ros-humble-nav2-behavior-tree
  ros-humble-nav2-behaviors ros-humble-nav2-bt-navigator ros-humble-nav2-collision-monitor ros-humble-nav2-common
  ros-humble-nav2-constrained-smoother ros-humble-nav2-controller ros-humble-nav2-core ros-humble-nav2-costmap-2d
  ros-humble-nav2-dwb-controller ros-humble-nav2-lifecycle-manager ros-humble-nav2-mppi-controller ros-humble-nav2-msgs
  ros-humble-nav2-navfn-planner ros-humble-nav2-planner ros-humble-nav2-regulated-pure-pursuit-controller
  ros-humble-nav2-rotation-shim-controller ros-humble-nav2-rviz-plugins ros-humble-nav2-simple-commander ros-humble-nav2-smac-planner
  ros-humble-nav2-smoother ros-humble-nav2-theta-star-planner ros-humble-nav2-util ros-humble-nav2-velocity-smoother
  ros-humble-nav2-voxel-grid ros-humble-nav2-waypoint-follower ros-humble-smclib xtl-dev
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
