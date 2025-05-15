
## Intsall ST_LLM_TS

ROS2-nodes audio_capturer → whisper_ros → llama_ros → coqui_tts (in ROS2-node/script) → audio_player_node


```
cd ~/lib
git clone https://github.com/ggerganov/whisper.cpp
cd whisper.cpp
mkdir build && cd build
cmake .. \
    -DGGML_CUDA=ON \
    -DCMAKE_CUDA_ARCHITECTURES=87 \
    -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda \
    -DCMAKE_CUDA_COMPILER=/usr/local/cuda/bin/nvcc \
    -DWHISPER_CUBLAS=OFF 
make -j$(nproc)
```
```
[100%] Built target whisper-server
```
```
./main --help | grep cuda  # Should be "--cuda"
...empty...
```

```
### python3 -m pip install --upgrade \
    "sounddevice>=0.4.6" \
    "numpy<1.26" \
    "whispercpp==0.0.14" \
    "librosa==0.10.1" \
    "nvidia-cudnn-cu12==9.1.0.70" \
    "nvidia-tensorrt==10.0.1" \
    --extra-index-url https://download.pytorch.org/whl/cu121

pip install whispercpp librosa==0.10.1
```

```
cd ~/lib/whisper.cpp/models
wget https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-medium.bin
```

```
./whisper-cli -m /home/silenzio/lib/whisper.cpp/models/ggml-small-ru-q5_k_m.bin   -f '/home/silenzio/lib/whisper.cpp/samples/jfk.wav'    -l ru    -t 4
./build/bin/whisper-cli -m /home/silenzio/lib/whisper.cpp/models/ggml-medium.bin   -f '/home/silenzio/lib/whisper.cpp/samples/jfk.wav' -t 4
```
### Work:

```
whisper_init_from_file_with_params_no_state: loading model from '/home/silenzio/lib/whisper.cpp/models/ggml-medium.bin'
whisper_init_with_params_no_state: use gpu    = 1
whisper_init_with_params_no_state: flash attn = 0
whisper_init_with_params_no_state: gpu_device = 0
whisper_init_with_params_no_state: dtw        = 0
ggml_cuda_init: GGML_CUDA_FORCE_MMQ:    no
ggml_cuda_init: GGML_CUDA_FORCE_CUBLAS: no
ggml_cuda_init: found 1 CUDA devices:
  Device 0: Orin, compute capability 8.7, VMM: yes
whisper_init_with_params_no_state: devices    = 2
whisper_init_with_params_no_state: backends   = 2
whisper_model_load: loading model
whisper_model_load: n_vocab       = 51865
whisper_model_load: n_audio_ctx   = 1500
whisper_model_load: n_audio_state = 1024
whisper_model_load: n_audio_head  = 16
whisper_model_load: n_audio_layer = 24
whisper_model_load: n_text_ctx    = 448
whisper_model_load: n_text_state  = 1024
whisper_model_load: n_text_head   = 16
whisper_model_load: n_text_layer  = 24
whisper_model_load: n_mels        = 80
whisper_model_load: ftype         = 1
whisper_model_load: qntvr         = 0
whisper_model_load: type          = 4 (medium)
whisper_model_load: adding 1608 extra tokens
whisper_model_load: n_langs       = 99
whisper_default_buffer_type: using device CUDA0 (Orin)
whisper_model_load:    CUDA0 total size =  1533.14 MB
whisper_model_load: model size    = 1533.14 MB
whisper_backend_init_gpu: using CUDA0 backend
whisper_init_state: kv self size  =   50.33 MB
whisper_init_state: kv cross size =  150.99 MB
whisper_init_state: kv pad  size  =    6.29 MB
whisper_init_state: compute buffer (conv)   =   29.51 MB
whisper_init_state: compute buffer (encode) =  170.15 MB
whisper_init_state: compute buffer (cross)  =    7.72 MB
whisper_init_state: compute buffer (decode) =   99.11 MB

system_info: n_threads = 4 / 8 | AVX = 0 | AVX2 = 0 | AVX512 = 0 | FMA = 0 | NEON = 1 | ARM_FMA = 1 | F16C = 0 | FP16_VA = 1 | WASM_SIMD = 0 | SSE3 = 0 | SSSE3 = 0 | VSX = 0 | COREML = 0 | OPENVINO = 0 | 

main: processing '/home/silenzio/lib/whisper.cpp/samples/jfk.wav'
 (176000 samples, 11.0 sec), 4 threads, 1 processors, 5 beams + best of 5, lang = ru, task = transcribe, timestamps = 1 ...

[00:00:00.000 --> 00:00:11.000] И так, мои дорогие американцы, запросите, что ваш страна может сделать для вас, запросите, что вы можете сделать для вашей страны.

whisper_print_timings:     load time =  2303.32 ms
whisper_print_timings:     fallbacks =   0 p /   0 h
whisper_print_timings:      mel time =    13.42 ms
whisper_print_timings:   sample time =   179.33 ms /   199 runs (    0.90 ms per run)
whisper_print_timings:   encode time =  1057.34 ms /     1 runs ( 1057.34 ms per run)
whisper_print_timings:   decode time =     0.00 ms /     1 runs (    0.00 ms per run)
whisper_print_timings:   batchd time =  1287.01 ms /   197 runs (    6.53 ms per run)
whisper_print_timings:   prompt time =     0.00 ms /     1 runs (    0.00 ms per run)
whisper_print_timings:    total time =  5124.30 ms
```


```
lsusb
...
Bus 001 Device 006: ID 041e:324d Creative Technology, Ltd Sound Blaster Play! 3
...
```

```
### sudo apt install ros-humble-audio-common
cd ~/ros2_ws/src
gir clone -t ros2 https://github.com/ros-drivers/audio_common
cd ..
colcon build --packages-select audio_common
```

```
ros2 run audio_common audio_capturer_node

```


Make file "audio.repos":
```
repositories:
  audio_common:
    type: git
    url: https://github.com/knorth55/audio_common.git
    version: ros2-idl-bugfix
  rosidl:
    type: git
    url: https://github.com/ros2/rosidl.git
    version: 3.3.1
  rosidl_python:
    type: git
    url: https://github.com/knorth55/rosidl_python.git
    version: fix-141
```

```
cd ~/
mkdir tmp_ws/src -p
cd tmp_ws/src/
ls
vcs import < ~/audio.repos
```
