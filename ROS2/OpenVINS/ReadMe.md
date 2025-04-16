## OpenVINS

https://github.com/rpng/open_vins

### Docker Install: 

```
mkdir -p ~/ws/catkin_ws_ov/src
cd ~/ws/catkin_ws_ov/src
git clone https://github.com/rpng/open_vins.git
cd open_vins
export VERSION=ros2_22_04 # which docker file version you want (ROS1 vs ROS2 and ubuntu version)
docker build -t ov_$VERSION -f Dockerfile_$VERSION .
```

### Get dataset: 
https://docs.openvins.com/gs-tutorial.html

```
https://drive.google.com/file/d/1LFrdiMU6UBjtFfXPHzjJ4L7iDIXcdhvh/view?usp=drive_link
```

### Run:

nano ~/.bashrc # add to the bashrc file

xhost + &> /dev/null
export DOCKER_CATKINWS=/home/silenzio/ws/catkin_ws_ov
export DOCKER_DATASETS=/home/silenzio/_dataset/ov

alias ov_docker="docker run -it --net=host --gpus all \
    --env=\"NVIDIA_DRIVER_CAPABILITIES=all\" --env=\"DISPLAY\" \
    --env=\"QT_X11_NO_MITSHM=1\" --volume=\"/tmp/.X11-unix:/tmp/.X11-unix:rw\" \
    --mount type=bind,source=$DOCKER_CATKINWS,target=/catkin_ws \
    --mount type=bind,source=$DOCKER_DATASETS,target=/datasets $1"
source ~/.bashrc # after you save and exit


ov_docker ov_ros2_22_04 ros2
v_docker ov_ros2_22_04 ros2 run rviz2 rviz2 -d /catkin_ws/src/open_vins/ov_msckf/launch/display_ros2.rviz
