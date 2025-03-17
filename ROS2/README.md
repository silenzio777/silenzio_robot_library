## Ubuntu PC
________

### Install llama_ros:

```
cd ~/ros2_ws/src
git clone https://github.com/mgonzs13/llama_ros.git
pip3 install -r llama_ros/requirements.txt
cd ~/ros2_ws
rosdep install --from-paths src --ignore-src -r -y
```

### Add this lines of code to file: 
/home/silenzio/ros2_ws/src/llama_ros/llama_ros/CMakeLists.txt

```
option(LLAMA_CUDA "llama: use CUDA" ON)
add_compile_definitions(GGML_USE_CUDA)
```

```
colcon build --cmake-args -DGGML_CUDA=ON # add this for CUDA
```
> [!NOTE]
> Build, Run Ok
____

### Install whisper_ros:
https://github.com/mgonzs13/whisper_ros

### Installation:
To run whisper_ros with CUDA, first, you must install the CUDA Toolkit. To run SileroVAD with ONNX and CUDA, you must install the cuDNN.

```
cd ~/ros2_ws/src
git clone https://github.com/mgonzs13/audio_common.git
git clone https://github.com/mgonzs13/whisper_ros.git
cd ~/ros2_ws
rosdep install --from-paths src --ignore-src -r -y
colcon build --cmake-args -DGGML_CUDA=ON -DONNX_GPU=ON # To use CUDA on Whisper and on Silero, respectively
```
> [!NOTE]
> Build Ok

### Docker
Build the whisper_ros docker. Additionally, you can choose to build whisper_ros with CUDA (USE_CUDA) and choose the CUDA version (CUDA_VERSION). Remember that you have to use DOCKER_BUILDKIT=0 to compile whisper_ros with CUDA when building the image.
```
DOCKER_BUILDKIT=0 docker build -t whisper_ros --build-arg USE_CUDA=1 --build-arg CUDA_VERSION=12-6 .
```
Run the docker container. If you want to use CUDA, you have to install the NVIDIA Container Tollkit and add --gpus all.
```
docker run -it --rm --gpus all whisper_ros
```

### Usage:
Run Silero for VAD and Whisper for STT:

```
cd ~/ros2_ws && source install/setup.bash
ros2 launch whisper_bringup whisper.launch.py silero_vad_use_cuda:=True
```
Add the parameter silero_vad_use_cuda:=True to use Silero with CUDA.

### Demos:
Send a goal action to listen:

```
cd ~/ros2_ws && source install/setup.bash
ros2 action send_goal /whisper/listen whisper_msgs/action/STT "{}"
```

Or try the example of a whisper client:
```
cd ~/ros2_ws && source install/setup.bash
ros2 run whisper_demos whisper_demo_node
```

> [!NOTE]
> Run Ok

________

## Jetson Orin NX

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
https://github.com/mgonzs13/llama_ros/issues/8
https://github.com/jetsonhacks/buildLibrealsense2TX/issues/13

```
colcon build --cmake-args -DGGML_CUDA=ON -DCMAKE_CUDA_ARCHITECTURES=87
```

> [!NOTE]
> Run Ok

_____

### Install whisper_ros:
https://github.com/mgonzs13/whisper_ros


Installation
To run whisper_ros with CUDA, first, you must install the CUDA Toolkit. To run SileroVAD with ONNX and CUDA, you must install the cuDNN.

```
cd ~/ros2_ws/src
git clone https://github.com/mgonzs13/audio_common.git
git clone https://github.com/mgonzs13/whisper_ros.git
cd ~/ros2_ws
rosdep install --from-paths src --ignore-src -r -y
## colcon build --cmake-args -DGGML_CUDA=ON -DONNX_GPU=ON # To use CUDA on Whisper and on Silero, respectively
colcon build --cmake-args -DGGML_CUDA=ON -DONNX_GPU=ON -DCMAKE_CUDA_ARCHITECTURES=87
```
> [!NOTE]
> Build Ok

### Usage:
Run Silero for VAD and Whisper for STT:

```
cd ~/ros2_ws && source install/setup.bash
ros2 launch whisper_bringup whisper.launch.py
```
Add the parameter silero_vad_use_cuda:=True to use Silero with CUDA.

### Demos:
Send a goal action to listen:

```
cd ~/ros2_ws && source install/setup.bash
ros2 action send_goal /whisper/listen whisper_msgs/action/STT "{}"
```

Or try the example of a whisper client:
```
cd ~/ros2_ws && source install/setup.bash
ros2 run whisper_demos whisper_demo_node
```

> [!NOTE]
> Run Ok
