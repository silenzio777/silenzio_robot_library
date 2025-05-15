
## Intsall ST_LLM_TS

ROS2-nodes audio_capturer → whisper_ros → llama_ros → coqui_tts (in ROS2-node/script) → audio_player_node


'''
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
'''
