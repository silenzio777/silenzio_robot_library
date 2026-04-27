# LeRobot

https://github.com/huggingface/lerobot




```
$ lerobot-info
- LeRobot version: 0.4.4
- Platform: Linux-6.8.0-110-generic-x86_64-with-glibc2.35
- Python version: 3.10.12
- Huggingface Hub version: 0.35.3
- Datasets version: 4.1.1
- Numpy version: 2.2.6
- FFmpeg version: 4.4.2-0ubuntu0.22.04.1
- PyTorch version: 2.11.0+cu126
- Is PyTorch built with CUDA support?: True
- Cuda version: 12.6
- GPU model: NVIDIA GeForce RTX 4080
- Using GPU in script?: <fill in>
- lerobot scripts: ['lerobot-calibrate', 'lerobot-dataset-viz', 'lerobot-edit-dataset', 'lerobot-eval', 'lerobot-find-cameras', 'lerobot-find-joint-limits', 'lerobot-find-port', 'lerobot-imgtransform-viz', 'lerobot-info', 'lerobot-record', 'lerobot-replay', 'lerobot-setup-can', 'lerobot-setup-motors', 'lerobot-teleoperate', 'lerobot-train', 'lerobot-train-tokenizer']
```

```
$ lerobot-setup-can --mode=test --interfaces=can0,can1
==================================================
CAN Motor Test
==================================================
Testing motors 0x01-0x08
Mode: CAN FD


can0: Interface not found
  ⚠ Interface is not UP. Run: lerobot-setup-can --mode=setup --interfaces can0

can1: Interface not found
  ⚠ Interface is not UP. Run: lerobot-setup-can --mode=setup --interfaces can1

==================================================
Summary
==================================================
Total motors found: 0

⚠ No motors found! Check:
  1. Motors are powered (24V)
  2. CAN wiring (CANH, CANL, GND)
  3. Motor timeout parameter > 0 (use Damiao tools)
  4. 120Ω termination at both cable ends
  5. Interface configured: lerobot-setup-can --mode=setup --interfaces can0
```

____________
____________


### install:

https://huggingface.co/docs/lerobot/installation

```
git clone https://github.com/huggingface/lerobot.git
cd lerobot
python3 -m venv venv
source venv/bin/activate
pip3 install -e .

pip3 install -e ".[damiao]"
pip3 install -e ".[pi0]"
```

### fix cv2
```
pip3 uninstall opencv-python-headless
pip3 install opencv-python
```

### install realsence2 
```
pip3 install realsence2 
```

### fix xformers:

```
$ python eval_pi0_aloha_live.py
WARNING:xformers:WARNING[XFORMERS]: xFormers can't load C++/CUDA extensions. xFormers was built for:
    PyTorch 2.5.1+cu121 with CUDA 1201 (you have 2.7.1+cu126)
    Python  3.10.15 (you have 3.10.12)
  Please reinstall xformers (see https://github.com/facebookresearch/xformers#installing-xformers)
  Memory-efficient attention, SwiGLU, sparse and more won't be available.
  Set XFORMERS_MORE_DETAILS=1 for more details

```

```
# [linux & win] cuda 12.6 version
pip3 install -U xformers --index-url https://download.pytorch.org/whl/cu126
```

## fix torchvision:

```
$ python eval_pi0_aloha_live.py
...
if torch._C._dispatch_has_kernel_for_dispatch_key(self.qualname, "Meta"):
RuntimeError: operator torchvision::nms does not exist
```

```
### pip3 uninstall torch torchvision torchaudio -y
## pip3 uninstall torch torchvision torchaudio
pip3 uninstall torch torchvision torchaudio --no-deps
## pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126
pip3 install torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126 --no-deps
```

__________
## CUDA driver mismach, fix:

```
python -c "import torch; print(torch.version.cuda); import torchvision; print(torchvision.version.cuda); print('CUDA:', torch.version.cuda)"
# 12.6
# 12060
# CUDA: 12.6
```

```
$ nvcc --version
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2025 NVIDIA Corporation
Built on Fri_Feb_21_20:23:50_PST_2025
Cuda compilation tools, release 12.8, V12.8.93
Build cuda_12.8.r12.8/compiler.35583870_0
```

```
ls /usr/local/ | grep cuda

cuda
cuda-12
cuda-12.8
```

### fix, install CUDA Toolkit 12.6:
https://developer.nvidia.com/cuda-12-6-0-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=22.04&target_type=runfile_local

### download:
```
wget https://developer.download.nvidia.com/compute/cuda/12.6.0/local_installers/cuda_12.6.0_560.28.03_linux.run
```

### run install:
```
sudo sh cuda_12.6.0_560.28.03_linux.run
```

Когда вы запустите `.run` файл, через несколько секунд (после распаковки) появится текстовый интерфейс в терминале.

1.  **Accept EULA**: Сначала появится лицензионное соглашение. Нужно набрать `accept` и нажать **Enter**.
2.  **Меню выбора компонентов**: Появится список с крестиками `[X]`.
3.  **Снятие галочки**:
    * С помощью стрелок на клавиатуре наведите курсор на строку **Driver**.
    * Нажмите **Space** (Пробел), чтобы убрать крестик. Должно стать **`[ ] Driver`**.
    * Убедитесь, что на строке **CUDA Toolkit 12.6** крестик стоит: **`[X] CUDA Toolkit 12.6`**.
4.  **Установка**: Спуститесь стрелками вниз до кнопки **Install** и нажмите **Enter**.

```
===========
= Summary =
===========

Driver:   Not Selected
Toolkit:  Installed in /usr/local/cuda-12.6/

Please make sure that
 -   PATH includes /usr/local/cuda-12.6/bin
 -   LD_LIBRARY_PATH includes /usr/local/cuda-12.6/lib64, or, add /usr/local/cuda-12.6/lib64 to /etc/ld.so.conf and run ldconfig as root
```
__

```
$ ls -l /usr/local/ | grep cuda
lrwxrwxrwx  1 root root   21 Apr 27 17:33 cuda -> /usr/local/cuda-12.6/
lrwxrwxrwx  1 root root   25 Mar  8  2025 cuda-12 -> /etc/alternatives/cuda-12
drwxr-xr-x 16 root root 4096 Apr 27 17:34 cuda-12.6
drwxr-xr-x 15 root root 4096 Mar  8  2025 cuda-12.8
```

```
CUDA_HOME=/usr/local/cuda-12.6 MAX_JOBS=1 pip install flash-attn --no-build-isolation -v
# ~ 2-3 ours...
```

### backup:
```
cp /home/silenzio/.cache/pip/wheels/f5/05/1e/a6726e9eee2e7ee6151dbfed113e89d220dd3964ba617ab32d/flash_attn-2.8.3-cp310-cp310-linux_x86_64.whl ~/flash_attn_backup.whl
```
### reinstall:

```
pip install flash_attn-2.8.3-cp310-cp310-linux_x86_64.whl

# Убираем право на запись (write) для всех
chmod -R a-w /home/silenzio/.local/lib/python3.10/site-packages/flash_attn*
# вернуть права: 
## chmod -R u+w /home/silenzio/.local/lib/python3.10/site-packages/flash_attn*
```

_________

```
python3 -m venv ~/lerobot_env
source ~/lerobot_env/bin/activate
pip install ~/flash_attn_backup.whl  # Ставим из нашего бэкапа
```


__________


### fix flash-attn:

```
$ python eval_pi0_aloha_live.py
...
import flash_attn_2_cuda as flash_attn_cuda
ImportError: /home/silenzio/.local/lib/python3.10/site-packages/flash_attn_2_cuda.cpython-310-x86_64-linux-gnu.so: undefined symbol: _ZN3c104cuda29c10_cuda_check_implementationEiPKcS2_ib
```

```
$ pip show flash-attn
Name: flash-attn
Version: 2.7.0.post2
```

```
pip uninstall flash-attn -y
### pip install flash-attn --no-build-isolation
##### pip install flash-attn --no-build-isolation --extra-index-url https://download.pytorch.org/whl/cu126
pip install https://github.com/Dao-AILab/flash-attention/releases/download/v2.7.0.post2/flash_attn-2.7.0.post2+cu12cxx-cp310-cp310-linux_x86_64.whl
```

### or:
```
# Ограничиваем сборку 1 или 2 потоками (самый безопасный вариант)
MAX_JOBS=1 pip install flash-attn --no-build-isolation
# Это будет долго (может занять 30–60 минут), но машина останется отзывчивой.
```




```
$ python3 eval_pi0_aloha_live.py
Traceback (most recent call last):
  File "/home/silenzio/lib/lerobot/eval_pi0_aloha_live.py", line 5, in <module>
    from lerobot.policies.pi0.policy import PI0Policy
ModuleNotFoundError: No module named 'lerobot.policies.pi0.policy'
```









________________________

## trlc-dk1

An Open Source Dev Kit for AI-native Robotics
https://github.com/robot-learning-co/trlc-dk1
```
git clone https://github.com/robot-learning-co/trlc-dk1.git
```

```
cd '/home/silenzio/lib/lerobot' 
silenzio@jetsonnx:~/lib/lerobot$ source venv/bin/activate
(venv) silenzio@jetsonnx:~/lib/lerobot$ cd ~/lib/trlc-dk1/lerobot_robot_trlc_dk1
(venv) silenzio@jetsonnx:~/lib/trlc-dk1/lerobot_robot_trlc_dk1$ python3 lerobot_realsense_01.py
~/lib/trlc-dk1/lerobot_robot_trlc_dk1$ python3 lerobot_realsense_01.py
```


``` python
import sys
import cv2
import numpy as np
from lerobot.cameras.realsense.configuration_realsense import RealSenseCameraConfig
from lerobot.cameras.realsense.camera_realsense import RealSenseCamera
from lerobot.cameras.configs import ColorMode, Cv2Rotation

print("cv2 version:", cv2.__version__)

DEPTH_MAP = False # False True

# Create a `RealSenseCameraConfig` specifying your camera’s serial number and enabling depth.
config = RealSenseCameraConfig(
    serial_number_or_name="xxxxxxxxx",
    fps=30, #15,
    #width=640, height=480,
    #width=1280, height=720,
    width=1920, height=1080,
    color_mode=ColorMode.BGR, #RGB,
    use_depth=DEPTH_MAP, # False True
    rotation=Cv2Rotation.NO_ROTATION
)

# Instantiate and connect a `RealSenseCamera` with warm-up read (default).
camera = RealSenseCamera(config)
camera.connect()


# Capture a color frame via `read()` and a depth map via `read_depth()`.
try:
    color_frame = camera.read()
    if DEPTH_MAP: depth_map = camera.read_depth()
    print("Color frame shape:", color_frame.shape)
    if DEPTH_MAP: print("Depth map shape:", depth_map.shape)
    if DEPTH_MAP: print(f"Data type: {depth_map.dtype}")

finally:
    #camera.disconnect()
    pass

def read_cam():

    try:
        
        #cv2.namedWindow("demo", cv2.WINDOW_AUTOSIZE) 

        while True:
            color_frame = camera.read()

            if DEPTH_MAP:
                depth_map_img16 = camera.read_depth()
                img8 = (depth_map_img16 / 256.0).astype('uint8')

                #alpha = (255.0 / 65535.0) 
                #img8 = cv2.convertScaleAbs(depth_map_img16, alpha=alpha)

                ## cv2.normalize(depth_map_img16, img8, 0, 255, cv2.NORM_MINMAX)

                heatmap_image = cv2.applyColorMap(img8, cv2.COLORMAP_JET ) #cv2.COLORMAP_HOT) # cv2.COLORMAP_RAINBOW)

                #img2 = cv2.cvtColor(img, cv2.COLOR_YUV2BGR_I420);

            cv2.imshow('color_frame',color_frame)
            if DEPTH_MAP: cv2.imshow('depth_map',heatmap_image)

            keyCode = cv2.waitKey(10) & 0xFF
            if keyCode == 27 or keyCode == ord('q'):
                break

    finally:
        cv2.destroyAllWindows()


if __name__ == '__main__':

    read_cam()
    camera.disconnect()
    
```




__________

## OpenArm

https://huggingface.co/docs/lerobot/openarm?follower=Command


### Quick setup:

```
# Setup CAN interfaces
lerobot-setup-can --mode=setup --interfaces=can0,can1
```

```
# Test motor communication
lerobot-setup-can --mode=test --interfaces=can0,can1
```


```
lerobot-setup-can --mode=setup --interfaces can0
```
```
==================================================
CAN Interface Setup
==================================================
Mode: CAN FD
Bitrate: 1.0 Mbps
Data bitrate: 5.0 Mbps

Configuring can0...
  ✓ can0: UP

Setup complete!

Next: Test motors with:
  lerobot-setup-can --mode=test --interfaces can0
```


```
lerobot-setup-can --mode=test --interfaces can0
```

```
==================================================
CAN Motor Test
==================================================
Testing motors 0x01-0x08
Mode: CAN FD


can0: UP
  Motor 0x01 (joint_1): ✓ FOUND
    → Response 0x04: 0000000000000000
  Motor 0x02 (joint_2): ✗ No response
  Motor 0x03 (joint_3): ✗ No response
  Motor 0x04 (joint_4): ✗ No response
  Motor 0x05 (joint_5): ✗ No response
  Motor 0x06 (joint_6): ✗ No response
  Motor 0x07 (joint_7): ✗ No response
  Motor 0x08 (gripper): ✗ No response

  Summary: 1/8 motors found

==================================================
Summary
==================================================
Total motors found: 1
```

```
can0  001   [8]  FF FF FF FF FF FF FF FD
  can0  002   [8]  FF FF FF FF FF FF FF FD
  can0  003   [8]  FF FF FF FF FF FF FF FD
  can0  004   [8]  FF FF FF FF FF FF FF FD
  can0  005   [8]  FF FF FF FF FF FF FF FD
  can0  011   [8]  01 7E EB 80 07 E8 1E 1C
  can0  012   [8]  02 70 41 7F F8 00 1E 1C
  can0  013   [8]  03 80 DF 80 08 11 1F 1C
  can0  014   [8]  04 80 B5 7F E8 14 1E 1D
  can0  015   [8]  05 7F 8D 7F F7 FF 1F 1E
```


___

```
ip -d link show can0
```
```
20: can0: <NOARP,UP,LOWER_UP> mtu 72 qdisc pfifo_fast state UP mode DEFAULT group default qlen 10
    link/can  promiscuity 0 minmtu 0 maxmtu 0 
    can <FD> state ERROR-PASSIVE (berr-counter tx 0 rx 0) restart-ms 0 
	  bitrate 1000000 sample-point 0.750 
	  tq 12 prop-seg 29 phase-seg1 30 phase-seg2 20 sjw 10
	  pcan: tseg1 1..256 tseg2 1..128 sjw 1..128 brp 1..1024 brp-inc 1
	  dbitrate 5000000 dsample-point 0.750 
	  dtq 12 dprop-seg 5 dphase-seg1 6 dphase-seg2 4 dsjw 2
	  pcan: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..1024 dbrp-inc 1
	  clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 
```

