
## Jetson Orin NX
________
### Install llama_ros:
https://github.com/mgonzs13/llama_ros

To run llama_ros with CUDA, first, you must install the CUDA Toolkit. Then, you can compile llama_ros with --cmake-args -DGGML_CUDA=ON to enable CUDA support.

```
cd ~/ros2_ws/src
git clone https://github.com/mgonzs13/llama_ros.git
pip3 install -r llama_ros/requirements.txt
cd ~/ros2_ws
rosdep install --from-paths src --ignore-src -r -y
colcon build --cmake-args -DGGML_CUDA=ON # add this for CUDA
```

### ERROR:
```
--- stderr: llama_cpp_vendor                         
CMake Error in /home/silenzio/ros2_ws/build/llama_cpp_vendor/CMakeFiles/CMakeScratch/TryCompile-iaTCW4/CMakeLists.txt:
  CUDA_ARCHITECTURES is set to "native", but no NVIDIA GPU was detected.
```
## FIX:
### https://github.com/mgonzs13/llama_ros/issues/8
### https://github.com/jetsonhacks/buildLibrealsense2TX/issues/13

```
colcon build --cmake-args -DGGML_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES=87
```




> [!NOTE]
>
