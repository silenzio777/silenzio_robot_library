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

### Test:
```
##T1:
cd ~/ros2_ws && source install/setup.bash
silenzio@jetsonnx:~/ros2_ws$ ros2 launch whisper_bringup whisper.launch.py silero_vad_use_cuda:=True
[INFO] [launch]: All log files can be found below /home/silenzio/.ros/log/2025-03-17-22-10-15-941414-jetsonnx-293312
[INFO] [launch]: Default logging verbosity is set to INFO
[INFO] [whisper_server_node-1]: process started with pid [293345]
[INFO] [silero_vad_node-2]: process started with pid [293347]
[INFO] [audio_capturer_node-3]: process started with pid [293349]
...
[whisper_server_node-1] whisper_init_from_file_with_params_no_state: loading model from '/home/silenzio/.cache/huggingface/hub/models--ggerganov--whisper.cpp/snapshots/5359861c739e955e79d9a303bcbc70fb988958b1/ggml-large-v3-turbo-q5_0.bin'
[whisper_server_node-1] whisper_init_with_params_no_state: use gpu    = 1
[whisper_server_node-1] whisper_init_with_params_no_state: flash attn = 0
[whisper_server_node-1] whisper_init_with_params_no_state: gpu_device = 0
[whisper_server_node-1] whisper_init_with_params_no_state: dtw        = 0
[audio_capturer_node-3] [INFO] [1742238616.500073904] [audio.capturer_node]: AudioCapturer node started
[whisper_server_node-1] ggml_cuda_init: GGML_CUDA_FORCE_MMQ:    no
[whisper_server_node-1] ggml_cuda_init: GGML_CUDA_FORCE_CUBLAS: no
[whisper_server_node-1] ggml_cuda_init: found 1 CUDA devices:
[whisper_server_node-1]   Device 0: Orin, compute capability 8.7, VMM: yes
[whisper_server_node-1] whisper_init_with_params_no_state: devices    = 2
[whisper_server_node-1] whisper_init_with_params_no_state: backends   = 2
...
[whisper_server_node-1] whisper_default_buffer_type: using device CUDA0 (Orin)
[whisper_server_node-1] whisper_model_load:    CUDA0 total size =   573.45 MB
[silero_vad_node-2] [INFO] Downloading silero_vad.onnx from mgonzs13/silero-vad-onnx
[silero_vad_node-2] [INFO] Snapshot file exists. Skipping download...
[silero_vad_node-2] [INFO] [1742238617.040621260] [whisper.silero_vad_node]: [silero_vad_node] Configured
[silero_vad_node-2] [INFO] [1742238617.040875157] [whisper.silero_vad_node]: [silero_vad_node] Activating...
[silero_vad_node-2] [WARN] [vad_iterator.cpp:init_onnx_model:81] CUDA provider not available, using CPU provider
[silero_vad_node-2] [INFO] [vad_iterator.cpp:VadIterator:57] SileroVAD Iterator started
[silero_vad_node-2] [INFO] [1742238617.200778274] [whisper.silero_vad_node]: [silero_vad_node] Activated
[whisper_server_node-1] whisper_model_load: model size    =  573.40 MB
[whisper_server_node-1] whisper_backend_init_gpu: using CUDA0 backend
...
[whisper_server_node-1] [INFO] [1742238617.237366322] [whisper.whisper_node]: [whisper_node] Activated
[silero_vad_node-2] [INFO] [1742238622.907622030] [whisper.silero_vad_node]: SileroVAD enabled
[silero_vad_node-2] [INFO] [1742238624.815809630] [whisper.silero_vad_node]: Speech starts...
[silero_vad_node-2] [INFO] [1742238626.872484008] [whisper.silero_vad_node]: Speech ends...
[whisper_server_node-1] [INFO] [1742238626.914057816] [whisper.whisper_node]: Transcribing
[silero_vad_node-2] [INFO] [1742238626.914381698] [whisper.silero_vad_node]: SileroVAD disabled
# >>>>>>>>>>>>>>>>>>>>>>>
[whisper_server_node-1] [INFO] [whisper.cpp:transcribe:100] [00:00:00.000 --> 00:00:30.000]:  1, 2, 3, 4, 5, and we'll see you next time.
[whisper_server_node-1] [INFO] [1742238630.156849971] [whisper.whisper_node]: Text heard: 1, 2, 3, 4, 5, and we'll see you next time.
# <<<<<<<<<<<<<<<<<<<<<<<
[silero_vad_node-2] [INFO] [1742238630.157555562] [whisper.silero_vad_node]: SileroVAD already disabled

##T2:
cd ~/ros2_ws && source install/setup.bash

silenzio@jetsonnx:~/ros2_ws$ ros2 run whisper_demos whisper_demo_node
[INFO] [1742239101.550514904] [whisper_demo_node]: SPEAK
[INFO] [1742239109.887262607] [whisper_demo_node]: I hear: 2, 12, 86, 14, 16, process.
[INFO] [1742239109.888455063] [whisper_demo_node]: Audio time: 3.0
[INFO] [1742239109.889415735] [whisper_demo_node]: Transcription time: 2.6296744346618652

or

##T2:
cd ~/ros2_ws && source install/setup.bash
silenzio@jetsonnx:~/ros2_ws$ ros2 action send_goal /whisper/listen whisper_msgs/action/STT "{}"
Waiting for an action server to become available...
Sending goal:
     prompt: ''
grammar_config:
  grammar: ''
  start_rule: ''
  grammar_penalty: 100.0

Goal accepted with ID: 600e26843eb44e0ba567733de4290df2

Result:
    transcription:
  # >>>>>>>>>>>>>>>>>>>>>>>
  text: 1, 2, 3, 4, 5, and we'll see you next time.
  # <<<<<<<<<<<<<<<<<<<<<<<
  audio_time: 2.0
  transcription_time: 3.242791175842285

Goal finished with status: SUCCEEDED
```
