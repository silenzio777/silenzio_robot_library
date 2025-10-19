
## Nerfstudio

https://github.com/nerfstudio-project/nerfstudio

Nerfstudio provides a simple API that allows for a simplified end-to-end process of creating, training, and testing NeRFs. The library supports a more interpretable implementation of NeRFs by modularizing each component. With more modular NeRFs, we hope to create a more user-friendly experience in exploring the technology.

```
cd ~/lib/nerfstudio
python3 -m venv .nerfstudio
source .nerfstudio/bin/activate
```

### Install dependencies:
```
pip3 install torch==2.1.2+cu118 torchvision==0.16.2+cu118 --extra-index-url https://download.pytorch.org/whl/cu118
### pip3 install -c "nvidia/label/cuda-11.8.0" cuda-toolkit
pip3 install ninja git+https://github.com/NVlabs/tiny-cuda-nn/#subdirectory=bindings/torch
```

### Installing nerfstudio

Easy option:
```
pip3 install nerfstudio
```





