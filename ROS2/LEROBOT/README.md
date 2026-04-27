# LeRobot

https://github.com/huggingface/lerobot

### install:

https://huggingface.co/docs/lerobot/installation

```
git clone https://github.com/huggingface/lerobot.git
cd lerobot
python3 -m venv venv
source venv/bin/activate
pip3 install -e .
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
pip uninstall torch torchvision torchaudio -y
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126
```

```
python -c "import torch; print(torch.version.cuda); import torchvision; print(torchvision.version.cuda); print('CUDA:', torch.version.cuda)"
#12.6
#12060
#
```

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
pip install flash-attn --no-build-isolation --extra-index-url https://download.pytorch.org/whl/cu126
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

