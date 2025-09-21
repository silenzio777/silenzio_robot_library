

------------------------------------------------------------------------------------------
## ROS2 stella_vslam_ros2
------------------------------------------------------------------------------------------

https://github.com/stella-cv/stella_vslam_ros
https://stella-cv.readthedocs.io/en/latest/ros2_package.html

## INSTALL dependencies:

Tested for Ubuntu 22.04. 
ROS2 : humble or later.

(If using PangolinViewer)

```
sudo apt install -y libglew-dev
git clone https://github.com/stevenlovegrove/Pangolin.git
cd Pangolin
git checkout ad8b5f83
sed -i -e "193,198d" ./src/utils/file_utils.cpp
mkdir -p build
cd build
cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_EXAMPLES=OFF \
    -DBUILD_PANGOLIN_DEPTHSENSE=OFF \
    -DBUILD_PANGOLIN_FFMPEG=OFF \
    -DBUILD_PANGOLIN_LIBDC1394=OFF \
    -DBUILD_PANGOLIN_LIBJPEG=OFF \
    -DBUILD_PANGOLIN_LIBOPENEXR=OFF \
    -DBUILD_PANGOLIN_LIBPNG=OFF \
    -DBUILD_PANGOLIN_LIBREALSENSE=OFF \
    -DBUILD_PANGOLIN_LIBREALSENSE2=OFF \
    -DBUILD_PANGOLIN_LIBTIFF=OFF \
    -DBUILD_PANGOLIN_LIBUVC=OFF \
    -DBUILD_PANGOLIN_LZ4=OFF \
    -DBUILD_PANGOLIN_OPENNI=OFF \
    -DBUILD_PANGOLIN_OPENNI2=OFF \
    -DBUILD_PANGOLIN_PLEORA=OFF \
    -DBUILD_PANGOLIN_PYTHON=OFF \
    -DBUILD_PANGOLIN_TELICAM=OFF \
    -DBUILD_PANGOLIN_TOON=OFF \
    -DBUILD_PANGOLIN_UVC_MEDIAFOUNDATION=OFF \
    -DBUILD_PANGOLIN_V4L=OFF \
    -DBUILD_PANGOLIN_VIDEO=OFF \
    -DBUILD_PANGOLIN_ZSTD=OFF \
    -DBUILD_PYPANGOLIN_MODULE=OFF \
    ..
make -j$(($(nproc) / 2))
make install
```

## BULD OK


## INSTALL g2o
https://github.com/rubengooj/pl-slam/issues/1
https://github.com/RainerKuemmerle/g2o

```
git clone https://github.com/RainerKuemmerle/g2o.git
cd g2o
mkdir build
cd build
cmake ..
make -j 7
sudo make install
```

#LIST( APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake_modules )
#SET( G2O_ROOT /usr/local/include/g2o )
#FIND_PACKAGE( G2O )
#i did like it and solved the problem

```
### sudo cp /home/jetson/ros2_ws/src/slam_toolbox/CMake/FindG2O.cmake /usr/share/cmake-3.16/Modules/
sudo cp /home/silenzio/lib/g2o/cmake_modules/FindG2O.cmake /usr/share/cmake-3.22/Modules/
```

sudo ldconfig

## BULD OK


## INSTALL CORE 

```
rosdep update
sudo apt update
mkdir -p ~/lib
cd ~/lib
git clone --recursive --depth 1 https://github.com/stella-cv/stella_vslam.git
rosdep install -y -i --from-paths ~/lib
```
```
cd ~/lib/stella_vslam
mkdir -p ~/lib/stella_vslam/build
cd ~/lib/stella_vslam/build
source /opt/ros/${ROS_DISTRO}/setup.bash
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ..
make -j 7
sudo make install
```
## BULD OK



# When building with support for PangolinViewer
```
cd ~/lib
git clone --recursive https://github.com/stella-cv/pangolin_viewer.git
mkdir -p pangolin_viewer/build
cd pangolin_viewer/build
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo ..
make -j 7
sudo make install
```

## INSTALL ROS2 WRAPPER

```
cd ~/ros2_ws/src
git clone --recursive -b ros2 --depth 1 https://github.com/stella-cv/stella_vslam_ros.git
cd ~/ros2_ws
rosdep install -y -i --from-paths ~/ros2_ws/src --skip-keys=stella_vslam
colcon build --symlink-install
```


## RUN:

```
source /opt/ros/humble/setup.bash
source install/setup.bash
```

```
ros2 run stella_vslam_ros run_slam \
-v /home/silenzio/lib/stella_vslam/vocab/orb_vocab.fbow \
-c /home/silenzio/lib/stella_vslam/example/kitti/mono_03.yaml \
--map-db-out /home/silenzio/ros2_ws/src/omni/map/stella_vslam/map.msg 
```

__________
## RUN T265:

T1:
```
new terminal
cd foxy/
docker run -it --rm -v /dev:/dev --device-cgroup-rule "c 81:* rmw" --device-cgroup-rule "c 189:* rmw" -v .:/foxy ros_foxy_librealsense2 bash
in docker:
./ros_entrypoint.sh
cd foxy/catkin_ws/
. install/local_setup.bash
#ros2 launch realsense2_camera rs_launch.py
ros2 launch realsense2_camera rs_t265_launch.py
```

T2:
```
source /opt/ros/humble/setup.bash
ros2 run image_transport republish raw in:=/camera/fisheye1/image_raw raw out:=/camera/image_raw
```

T3:
```
source /opt/ros/humble/setup.bash
cd ~/ros2_ws
source install/setup.bash
```

```
ros2 run stella_vslam_ros run_slam \
-v /home/silenzio/lib/stella_vslam/vocab/orb_vocab.fbow \
-c /home/silenzio/lib/stella_vslam/example/tum_vi/mono.yaml \
--map-db-out /home/silenzio/ros2_ws/src/omni/map/stella_vslam/map.msg 
```

__

slam.launch

```
<?xml version="1.0"?>
<launch>

    <node name="stella_vslam_ros" pkg="stella_vslam_ros" exec="run_slam" args="-v /home/silenzio/lib/stella_vslam/vocab/orb_vocab.fbow -c /home/silenzio/lib/stella_vslam/example/tum_vi/T265_mono.yaml -map-db /home/silenzio/ros2_ws/src/omni/map/stella_vslam/map.msg" output="screen">
     <remap from="/camera/image_raw" to="/T265/fisheye1/image_raw"/>
    </node>

</launch>
```

### Run:
```
ros2 launch stella_vslam_ros slam.launch

```
