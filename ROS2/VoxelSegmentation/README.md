
### Install object_detection_rgbd:

```
cd ~/ros2_ws/src/
git clone https://github.com/IliaLarchenko/object_detection_rgbd.git
cd ..
colcon build --packages-select object_detection_rgbd
```

```
pip3 show numpy
Name: numpy
Version: 1.24.2
```

```
pip3 install numpy==1.26.3
pip3 install timm
```

```
ros2 launch object_detection_rgbd object_detection.launch.py
```
### Works
