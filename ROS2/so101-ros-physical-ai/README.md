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

colcon build --symlink-install --packages-select episode_recorder






