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





