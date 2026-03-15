
```
cd ~/ros2_ws/src
git clone --recurse-submodules https://github.com/legalaspro/so101-ros-physical-ai.git
sudo apt update
rosdep install --from-paths src/feetech_ros2_driver --ignore-src -y
cd ..
colcon build --symlink-install --packages-select \
    so101_bringup \
    so101_description \
    so101_teleop \
    so101_moveit_config \
    rosbag_to_lerobot \
    so101_inference \
    feetech_ros2_driver
```

```
---
Summary: 7 packages finished [17.8s]
```

```
colcon build --symlink-install --packages-select episode_recorder
```
```
Starting >>> episode_recorder
--- stderr: episode_recorder                             
CMake Deprecation Warning at CMakeLists.txt:1 (cmake_minimum_required):
  Compatibility with CMake < 3.10 will be removed from a future version of
  CMake.

  Update the VERSION argument <min> value.  Or, use the <min>...<max> syntax
  to tell CMake that the project requires at least <min> but has been updated
  to work with policies introduced by <max> or earlier.


/home/silenzio/ros2_ws/src/so101-ros-physical-ai/episode_recorder/src/episode_recorder.cpp: In member function ‘bool episode_recorder::EpisodeRecorder::start_episode()’:
/home/silenzio/ros2_ws/src/so101-ros-physical-ai/episode_recorder/src/episode_recorder.cpp:322:21: error: ‘struct rosbag2_storage::StorageOptions’ has no member named ‘custom_data’
  322 |     storage_options.custom_data["experiment_name"] = experiment_name_;
      |                     ^~~~~~~~~~~
/home/silenzio/ros2_ws/src/so101-ros-physical-ai/episode_recorder/src/episode_recorder.cpp:324:19: error: ‘struct rosbag2_storage::StorageOptions’ has no member named ‘custom_data’
  324 |   storage_options.custom_data["episode_index"] = std::to_string(next_episode_index_);
      |                   ^~~~~~~~~~~
/home/silenzio/ros2_ws/src/so101-ros-physical-ai/episode_recorder/src/episode_recorder.cpp:330:19: error: ‘struct rosbag2_storage::StorageOptions’ has no member named ‘custom_data’
  330 |   storage_options.custom_data["task"] = task_;
      |                   ^~~~~~~~~~~
gmake[2]: *** [CMakeFiles/episode_recorder_node.dir/build.make:93: CMakeFiles/episode_recorder_node.dir/src/episode_recorder.cpp.o] Error 1
gmake[1]: *** [CMakeFiles/Makefile2:156: CMakeFiles/episode_recorder_node.dir/all] Error 2
gmake: *** [Makefile:146: all] Error 2
```




___


### HARDWARE setup:

https://github.com/legalaspro/so101-ros-physical-ai/blob/main/docs/hardware.md#5-calibration-eeprom-and-optional-joint-config-overrides


```
# Arms — replace /dev/ttyACM0 with the device you see:
udevadm info --query=property --name=/dev/ttyACM0 | \
  egrep 'ID_VENDOR_ID|ID_MODEL_ID|ID_SERIAL_SHORT|ID_PATH'
```

```
  egrep 'ID_VENDOR_ID|ID_MODEL_ID|ID_SERIAL_SHORT|ID_PATH'
ID_VENDOR_ID=1a86
ID_MODEL_ID=55d3
ID_SERIAL_SHORT=58A6070029
ID_PATH=pci-0000:00:14.0-usb-0:4.2:1.0
ID_PATH_TAG=pci-0000_00_14_0-usb-0_4_2_1_0

```






