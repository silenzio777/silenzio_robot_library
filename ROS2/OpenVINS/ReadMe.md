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

nano ~/.bashrc # add to the bashrc file
xhost + &> /dev/null
export DOCKER_CATKINWS=/home/username/workspace/catkin_ws_ov
export DOCKER_DATASETS=/home/username/datasets
alias ov_docker="docker run -it --net=host --gpus all \
    --env=\"NVIDIA_DRIVER_CAPABILITIES=all\" --env=\"DISPLAY\" \
    --env=\"QT_X11_NO_MITSHM=1\" --volume=\"/tmp/.X11-unix:/tmp/.X11-unix:rw\" \
    --mount type=bind,source=$DOCKER_CATKINWS,target=/catkin_ws \
    --mount type=bind,source=$DOCKER_DATASETS,target=/datasets $1"
source ~/.bashrc # after you save and exit
