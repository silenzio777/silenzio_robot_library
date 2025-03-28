

https://github.com/automaticaddison/yahboom_rosmaster/issues/1


### Q______:

I am trying to set up and run the Yahboom Rosmaster repository on my Jetson device using a Docker-based ROS 2 Humble environment.

Dockerfile:

```
FROM docker.io/arm64v8/ubuntu:22.04

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES all

ARG UID=1000
ARG GID=1000

# add new sudo user
ENV USERNAME jetson
ENV HOME /home/$USERNAME
RUN useradd -m $USERNAME && \
        echo "$USERNAME:$USERNAME" | chpasswd && \
        usermod --shell /bin/bash $USERNAME && \
        usermod -aG sudo $USERNAME && \
        mkdir /etc/sudoers.d && \
        echo "$USERNAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USERNAME && \
        chmod 0440 /etc/sudoers.d/$USERNAME && \
        usermod  --uid $UID $USERNAME && \
        groupmod --gid $GID $USERNAME
RUN gpasswd -a $USERNAME video

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -qq -y --no-install-recommends \
        bash-completion \
        build-essential \
        curl \
        git \
        python3 \
        python3-pip \
        sudo \
        wget \
        ros-humble-desktop \
        ros-humble-rmw-cyclonedds-cpp \
        python3-colcon-common-extensions \
        python3-rosdep \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

```
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

RUN sudo rosdep init && rosdep update
```

Steps Taken to Set Up Yahboom Rosmaster
Cloned the repository
```
cd ~/ros2_ws/src
git clone https://github.com/automaticaddison/yahboom_rosmaster.git

```
Installed dependencies
```
cd ~/ros2_ws
rosdep update
rosdep install --from-paths src --ignore-src -r -y

```
Tried building the repository

```
colcon build --symlink-install
source install/setup.bash
```

Tried launching the simulation
```
ros2 launch yahboom_rosmaster_gazebo yahboom_rosmaster.gazebo.launch.py
```

❌ Error: Package 'yahboom_rosmaster_gazebo' not found
Checked missing dependencies (mecanum_drive_controller and gz_ros2_control_demos)

```
colcon build --symlink-install --packages-select mecanum_drive_controller gz_ros2_control_demos
```

❌ Error: Build fails due to deprecated ROS API usage in mecanum_drive_controller.cpp

Issues Encountered

```
mecanum_drive_controller uses deprecated ROS 2 APIs (get_lifecycle_state() should be get_current_state()).
set_value() in LoanedCommandInterface does not return bool, causing build failures.
realtime_tools headers are outdated (realtime_box.h should be realtime_box.hpp).
Gazebo simulation package is not recognized after successful build.
What’s the expected way to move the bot after a successful setup?
```

### A______:

automaticaddison
on Feb 24
Owner

HI @Aasthaengg Thanks for reaching out. The entire package is compatible with ROS 2 Jazzy in an Ubuntu (amd64) environment. If you need personalized help on getting it compatible with ROS 2 Humble and NVIDIA, you can contact me by clicking the "Need Help?" button on my website. Thanks!

