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
    episode_recorder \
    rosbag_to_lerobot \
    so101_inference \
    feetech_ros2_driver
```

```
---
Finished <<< so101_teleop [13.0s]

Summary: 6 packages finished [13.7s]
  3 packages had stderr output: so101_bringup so101_description so101_teleop
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




