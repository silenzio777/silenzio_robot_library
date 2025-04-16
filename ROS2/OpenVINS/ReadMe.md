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

```
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
```

```
ov_docker ov_ros2_22_04 bash
ov_docker ov_ros2_22_04 ros2
ov_docker ov_ros2_22_04 ros2 run rviz2 rviz2 -d /catkin_ws/src/open_vins/ov_msckf/launch/display_ros2.rviz
```

### ROS1 build:
```
ov_docker ov_ros2_22_04 bash
cd catkin_ws
colcon build --event-handlers console_cohesion+
```

### ROS1 run:
```
ov_docker ov_ros2_22_04 bash
cd catkin_ws
source install/setup.bash
ros2 run ov_eval plot_trajectories none src/open_vins/ov_data/sim/udel_gore.txt
ros2 run ov_eval plot_trajectories none src/open_vins/ov_data/sim/euroc_V1_01_easy.txt
ros2 run ov_msckf run_simulation src/open_vins/config/rpng_sim/estimator_config.yaml
ros2 run ov_msckf run_simulation src/open_vins/config/kaist_vio/estimator_config.yaml
```


### T0:
```
ov_docker ov_ros2_22_04 bash
cd catkin_ws
ros2 launch ov_msckf subscribe.launch.py config:=euroc_mav
```

### T1:
```
ov_docker ov_ros2_22_04 bash
ros2 bag play /datasets/V1_01_easy/V1_01_easy.db3
```

