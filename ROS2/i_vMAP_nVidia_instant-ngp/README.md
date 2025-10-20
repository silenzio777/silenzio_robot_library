
## vMAP
Vectorised Object Mapping for Neural Field SLAM

https://github.com/Ifan24/vMAP


```
cd ~/lib/
git clone https://github.com/SrinjaySarkar/imap-Implicit-Mapping-and-Positioning-in-Real-Time.git
```
```
pip3 install torch torchvision torchaudio --upgrade --index-url https://download.pytorch.org/whl/cu118
```

use this requirements.txt file:
```
brotlipy==0.7.0
certifi==2022.9.24
cffi==1.15.1
charset-normalizer==2.0.4
cryptography==38.0.1
idna==3.4
numpy==1.23.4
pillow==9.2.0
pycparser==2.21
pyopenssl==22.0.0
pysocks==1.7.1
requests==2.28.1
six==1.16.0
typing_extensions==4.3.0
urllib3==1.26.12

## torch==1.12.1+cu113
## torchvision==0.13.1+cu113
## torchaudio==0.12.1+cu113

antlr4-python3-runtime==4.9.3
bidict==0.22.0
click==8.1.3
dash==2.7.0
dash-core-components==2.0.0
dash-html-components==2.0.0
dash-table==5.0.0
entrypoints==0.4
flask==2.2.2
functorch==0.2.0
fvcore==0.1.5.post20221122
h5py==3.7.0
imageio==2.22.4
importlib-metadata==5.1.0
iopath==0.1.10
itsdangerous==2.1.2
lpips==0.1.4
nbformat==5.5.0
omegaconf==2.2.3
open3d==0.16.0
pexpect==4.8.0
plotly==5.11.0
pycocotools==2.0.6
pyquaternion==0.9.9
scikit-image==0.19.3
tenacity==8.1.0
termcolor==2.1.1
timm==0.6.12
werkzeug==2.2.2
yacs==0.1.8
zipp==3.11.0
trimesh
opencv-python
imgviz
shapely
```

```
python3 -m venv .vMAP
source .vMAP/bin/activate
pip3 install -r requirements.txt --extra-index-url https://download.pytorch.org/whl/cu113
```


### Datasets:

Please download the following datasets to reproduce our results.

Replica Demo - Replica Room 0 only for faster experimentation. 
https://huggingface.co/datasets/kxic/vMAP/resolve/main/demo_replica_room_0.zip
    
Replica - All Pre-generated Replica sequences. For Replica data generation, please refer to directory data_generation.
https://huggingface.co/datasets/kxic/vMAP/resolve/main/vmap.zip

ScanNet - Official ScanNet sequences. 
https://github.com/ScanNet/ScanNet

Each dataset contains a sequence of RGB-D images, as well as their corresponding camera poses, and object instance labels. 
To extract data from ScanNet .sens files, run:

```
conda activate py2
python2 reader.py --filename ~/data/ScanNet/scannet/scans/scene0024_00/scene0024_00.sens --output_path ~/data/ScanNet/objnerf/ --export_depth_images --export_color_images --export_poses --export_intrinsics
```


### Config:

Then update the config files in configs/.json with your dataset paths, as well as other training hyper-parameters.
```
"dataset": {
        "path": "/home/silenzio/_dataset/RGBD/room_0",
    }
```

### Running vMAP / iMAP:

The following commands will run vMAP / iMAP in a single-thread setting.

vMAP
```
python3 ./train.py --config ./configs/Replica/config_replica_room0_vMAP.json --logdir ./logs/vMAP/room0 --save_ckpt True
```

iMAP
```
python3 ./train.py --config ./configs/Replica/config_replica_room0_iMAP.json --logdir ./logs/iMAP/room0 --save_ckpt True
```

____________
## Instant Neural Graphics Primitives 
https://github.com/NVlabs/instant-ngp

Instant neural graphics primitives: lightning fast NeRF and more 

### Install dep:
```
sudo apt-get install build-essential libopenexr-dev libxi-dev \
    libglfw3-dev libglew-dev libomp-dev libxinerama-dev libxcursor-dev
```
### get source code:
```
cd ~/lib/
git clone --recursive https://github.com/nvlabs/instant-ngp
```

### try build:

```
cd instant-ngp
cmake . -B build -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_POLICY_VERSION_MINIMUM=3.5
```
```
...
-- Build files have been written to: /home/silenzio/lib/instant-ngp/build
```

```
cmake --build build --config RelWithDebInfo -j
```
```
...
[100%] Linking CXX shared library pyngp.cpython-310-x86_64-linux-gnu.so
[100%] Built target pyngp
```

```
pip3 install commentjson imageio pybind11 pyquaternion scipy tqdm
```

### run:

```
cd build
./instant-ngp
```
```
19:06:09 SUCCESS  Initialized CUDA 12.8. Active GPU is #0: NVIDIA GeForce RTX 4080 [89]
19:06:09 WARNING  Vulkan instance validation layer is not available. Vulkan errors will be difficult to diagnose.
19:06:09 SUCCESS  Initialized Vulkan and NGX on GPU #0: NVIDIA GeForce RTX 4080
19:06:09 SUCCESS  Initialized OpenGL version 4.6.0 NVIDIA 580.65.06
```

```
cd build
python3 run.py --gui True files /home/silenzio/lib/instant-ngp/data/nerf/fox
```

### capture object on iPhone with Record3D and convert:

With an >=iPhone 12 Pro, one can use Record3D to collect data and avoid COLMAP. Record3D is an iOS app that relies on ARKit to estimate each image's camera pose. It is more robust than COLMAP for scenes that lack textures or contain repetitive patterns. To train instant-ngp with Record3D data, follow these steps:

- Record a video and export with the "Shareable/Internal format (.r3d)".

- Send the exported data to your computer.

- Replace the .r3d extension with .zip and unzip the file to get a directory path/to/data.

Run the preprocessing script:
```
instant-ngp$ python scripts/record3d2nerf.py --scene path/to/data
```
If you capture the scene in the landscape orientation, add --rotate.

Launch instant-ngp training:

```
instant-ngp$ ./instant-ngp path/to/data
```





