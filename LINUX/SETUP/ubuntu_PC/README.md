### System Torch and Torchvision with GPU

- Ubuntu 22.04 Jammy
- Python 3.10.12
- Torch 2.5.0
- Torchvision 0.20.0
- CUDA: 12.8.93
- cuDNN: 9.8.0
- TensorRT:
- VPI:
- OpemCV: 4.5.4 with CUDA: No
_____

### System setup:

```
$ python3
Python 3.10.12 (main, Feb  4 2025, 14:57:36) [GCC 11.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> 

sudo add-apt-repository universe

sudo apt update

sudo apt-get install chromium-browser

sudo apt-get install python3-pip

sudo apt install curl git wget nano

```
### NVidia driver:
```

sudo apt-get install dbus-x11 zlib1g

sudo apt update && sudo apt upgrade

sudo apt install nvidia-driver-550

$ nvidia-smi
Fri Mar  7 19:41:25 2025       
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 550.120                Driver Version: 550.120        CUDA Version: 12.4     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce GTX 1050 Ti     Off |   00000000:01:00.0  On |                  N/A |
|  0%   49C    P0             N/A /   72W |     182MiB /   4096MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+                                                     
+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A      1878      G   /usr/lib/xorg/Xorg                             47MiB |
|    0   N/A  N/A      2027      G   /usr/bin/gnome-shell                          131MiB |
+-----------------------------------------------------------------------------------------+
```

### Vino server:

```
sudo apt install vino

gsettings set org.gnome.Vino vnc-password $(echo -n 'mypasswd'|base64)

gsettings set org.gnome.Vino authentication-methods "['vnc']" 

gsettings set org.gnome.Vino require-encryption false    

gsettings set org.gnome.Vino prompt-enabled false

## RUN:
/usr/lib/vino/vino-server    

## ERROR:
X11 is not detected

## FIX:
Disabling Wayland
Wayland is an alternative to the xorg windows system. One day, it will be terrific. For now, it does not work with x11vnc or other important applications like TeamViewer.

sudo nano /etc/gdm3/custom.conf
 
# Uncomment the line below to force the login screen to use Xorg
WaylandEnable=false

reboot

## RUN:
/usr/lib/vino/vino-server
## WORK
```

### Jtop:
```
sudo pip3 install jetson-stats

$ jtop
The jtop.service is not active. Please run:
sudo systemctl restart jtop.service

terminator -e 'exec jtop'
```
### Nvitop:
```
https://github.com/XuehaiPan/nvitop?tab=readme-ov-file

## install:
cd ~/lib
git clone --depth=1 https://github.com/XuehaiPan/nvitop.git
cd nvitop
pip3 install .

## run:
nvitop
python3 -m ~/lib/nvitop
```
### Btop:
```
#sudo snap install btop
#sudo snap purge btop

### Install btop:

cd ~/lib
git clone https://github.com/aristocratos/btop.git && cd btop
make
sudo make install

### Setup:
sudo nano $HOME/.config/btop/btop.conf

### Run:
/usr/local/bin/btop

### btop.sh file:
#!/bin/bash
terminator -e 'exec /usr/local/bin/btop' --geometry=1300x800
```

### CUDA and cuDNN:
```

https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_network
CUDA Toolkit Installer

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-8


https://developer.nvidia.com/cudnn-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=deb_network
cuDNN 9.8.0 Installer

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cudnn

pip install torch==2.5.0 
pip install torchvision==0.20.0 --no-deps
pip install torchaudio==2.5.0 --no-deps

pip3 install opencv-contrib-python==4.2.0
pip3 install PyGLM psutil matplotlib IPython scikit-learn pandas imageio

```

### Check:
```
silenzio@ubuntuPC:/lib$ python3
Python 3.10.12 (main, Feb  4 2025, 14:57:36) [GCC 11.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import torch; torch.cuda.is_available();torch.__version__
True
'2.5.0+cu124'
>>>

>>> import torchvision;torchvision.__version__
'0.20.0+cu124'
>>>

>>> import torchaudio
>>>torchaudio.__version__
'2.5.0+cu124'
>>> 

```

### ROS2 hubmle:
```
sudo apt update && sudo apt install locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale 

sudo apt install software-properties-common
sudo add-apt-repository universe

sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

## Install ROS 2 packages
sudo apt update && sudo apt upgrade
sudo apt install ros-humble-desktop

source /opt/ros/humble/setup.bash

## Check:
#T1:
source /opt/ros/humble/setup.bash
ros2 run demo_nodes_cpp talker

#T2:
source /opt/ros/humble/setup.bash
ros2 run demo_nodes_py listener
```

_____
### Conda Torch and Torchvision with GPU

- Ubuntu 22.04 Jammy
- Python 3.6.13
- Torch 1.10.1+cu111
- Torchvision 0.11.2+cu111
- CUDA: 12.8.93
- cuDNN:
- TensorRT:
- VPI:
- OpemCV: 4.5.4 with CUDA: NO
_____

```
nano ~/.bashrc

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
export conda_enable='' #'false'
if [ -n "$conda_enable" ]; then
    __conda_setup="$('/home/silenzio/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/silenzio/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/silenzio/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/silenzio/miniconda3/bin:$PATH"
        fi
    fi
fi
    unset __conda_setup
# <<< conda initialize <<<

source ~/.bashrc

(base) silenzio@ubuntuPC:~$ conda activate pt

(pt) silenzio@ubuntuPC:~$ pip3 show torch
Name: torch
Version: 1.10.1+cu111
Summary: Tensors and Dynamic neural networks in Python with strong GPU acceleration
Home-page: https://pytorch.org/
Author: PyTorch Team
Author-email: packages@pytorch.org
License: BSD-3
Location: /home/silenzio/miniconda3/envs/pt/lib/python3.6/site-packages
Requires: typing-extensions, dataclasses
Required-by: torchvision, torchaudio

(pt) silenzio@ubuntuPC:~$ pip3 show torchvision
Name: torchvision
Version: 0.11.2+cu111
Summary: image and video datasets and models for torch deep learning
Home-page: https://github.com/pytorch/vision
Author: PyTorch Core Team
Author-email: soumith@pytorch.org
License: BSD
Location: /home/silenzio/miniconda3/envs/pt/lib/python3.6/site-packages
Requires: numpy, pillow, torch
Required-by: 

(pt) silenzio@ubuntuPC:~$ python3
Python 3.6.13 |Anaconda, Inc.| (default, Jun  4 2021, 14:25:59) 
[GCC 7.5.0] on linux
Type "help", "copyright", "credits" or "license" for more information.

>>> import torch
>>> import torch; torch.cuda.is_available();torch.__version__
True
'1.10.1+cu111'

>>> import torchvision;torchvision.__version__
'0.11.2+cu111'

>>> import torch;print(torch.nn.Conv2d(3, 3, 3).cuda()(torch.rand(1, 3, 6, 6, device='cuda')))
tensor([[[[-0.1617, -0.2088, -0.1004, -0.1646],
          [-0.2828, -0.1115,  0.0105, -0.0419],
          [-0.0576, -0.2302, -0.1868, -0.4420],
          [-0.2701, -0.3303, -0.1618, -0.1709]],

         [[-0.1428, -0.1416, -0.3596, -0.1518],
          [-0.0637,  0.2389, -0.3343, -0.0137],
          [ 0.0023,  0.0447,  0.0640,  0.0520],
          [ 0.1127, -0.2811, -0.1451, -0.0514]],

         [[-0.1702, -0.1214, -0.1733, -0.2559],
          [-0.3840, -0.1761, -0.1356,  0.1061],
          [-0.2147,  0.0781, -0.3182, -0.2179],
          [-0.1958, -0.2622, -0.0784, -0.0208]]]], device='cuda:0',
       grad_fn=<AddBackward0>)
>>> 

(pt) silenzio@ubuntuPC:~/jNano/onBoardNNetwork/06.20_VAE_GPU$ python3 VAE_CNN_60_60_JNNX.py
__CUDNN VERSION: 8005
__Number CUDA Devices: 1
__CUDA Device Name: NVIDIA GeForce GTX 1050 Ti
__CUDA Device Total Memory [GB]: 4.22445056
device: cuda

__platform: Linux  os.name: posix  release: 6.8.0-52-generic
>modelType:  CVAE
>condList.shape:  (503, 5)
classes len:  250
>latent_dim:  16
>condNum:  5
>size_inp_images:  128
>train_dataLen:  250
>batch_size:  220
>numCategories:  250
>dsDirDeep:  1
>time:  2025-03-16 19:36:08.667040

```
