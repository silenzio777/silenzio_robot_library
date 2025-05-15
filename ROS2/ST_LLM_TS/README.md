
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
### wget https://huggingface.co/ggerganov/whisper.cpp/resolve/main/ggml-small-ru-q5_k_m.bin
```
```
./whisper-cli -m /home/silenzio/lib/whisper.cpp/models/ggml-small-ru-q5_k_m.bin   -f '/home/silenzio/lib/whisper.cpp/samples/jfk.wav'    -l ru    -t 4
./whisper-cli -m /home/silenzio/lib/whisper.cpp/models/ggml-medium.bin   -f '/home/silenzio/lib/whisper.cpp/samples/jfk.wav'    -l ru    -t 4

```



