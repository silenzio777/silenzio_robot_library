```
cd ~/ros2_ws/src
git clone --recurse-submodules https://github.com/legalaspro/so101-ros-physical-ai.git
sudo apt update
rosdep install --from-paths src/feetech_ros2_driver --ignore-src -y
cd ..
colcon build --packages-select so101-ros-physical-ai
```







