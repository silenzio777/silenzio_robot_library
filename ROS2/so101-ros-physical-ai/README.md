
```
cd ~/ros2_ws/src
git clone --recurse-submodules https://github.com/legalaspro/so101-ros-physical-ai.git
sudo apt update
rosdep install --from-paths src/feetech_ros2_driver --ignore-src -y
cd ..
colcon build --symlink-install --packages-select \
    so101_bringup \
    so101_description \
    so101_teleop \
    so101_moveit_config \
    rosbag_to_lerobot \
    so101_inference \
    feetech_ros2_driver
```

```
---
Summary: 7 packages finished [17.8s]
```

```
colcon build --symlink-install --packages-select episode_recorder
```
```
Starting >>> episode_recorder
--- stderr: episode_recorder                             
CMake Deprecation Warning at CMakeLists.txt:1 (cmake_minimum_required):
  Compatibility with CMake < 3.10 will be removed from a future version of
  CMake.

  Update the VERSION argument <min> value.  Or, use the <min>...<max> syntax
  to tell CMake that the project requires at least <min> but has been updated
  to work with policies introduced by <max> or earlier.


/home/silenzio/ros2_ws/src/so101-ros-physical-ai/episode_recorder/src/episode_recorder.cpp: In member function ‘bool episode_recorder::EpisodeRecorder::start_episode()’:
/home/silenzio/ros2_ws/src/so101-ros-physical-ai/episode_recorder/src/episode_recorder.cpp:322:21: error: ‘struct rosbag2_storage::StorageOptions’ has no member named ‘custom_data’
  322 |     storage_options.custom_data["experiment_name"] = experiment_name_;
      |                     ^~~~~~~~~~~
/home/silenzio/ros2_ws/src/so101-ros-physical-ai/episode_recorder/src/episode_recorder.cpp:324:19: error: ‘struct rosbag2_storage::StorageOptions’ has no member named ‘custom_data’
  324 |   storage_options.custom_data["episode_index"] = std::to_string(next_episode_index_);
      |                   ^~~~~~~~~~~
/home/silenzio/ros2_ws/src/so101-ros-physical-ai/episode_recorder/src/episode_recorder.cpp:330:19: error: ‘struct rosbag2_storage::StorageOptions’ has no member named ‘custom_data’
  330 |   storage_options.custom_data["task"] = task_;
      |                   ^~~~~~~~~~~
gmake[2]: *** [CMakeFiles/episode_recorder_node.dir/build.make:93: CMakeFiles/episode_recorder_node.dir/src/episode_recorder.cpp.o] Error 1
gmake[1]: *** [CMakeFiles/Makefile2:156: CMakeFiles/episode_recorder_node.dir/all] Error 2
gmake: *** [Makefile:146: all] Error 2
```


___

```
pip3 install feetech-servo-sdk
~/lib$ git clone https://github.com/Adam-Software/Feetech-Servo-SDK.git
```

```
$ python3 ping.py
```

```python
# Default setting
SCS_ID                  = 101                # SCServo ID : 1
BAUDRATE                = 1000000           # SCServo default baudrate : 1000000
DEVICENAME              = '/dev/ttyACM0'    # Check which port is being used on your controller
                                            # ex) Windows: "COM1"   Linux: "/dev/ttyUSB0" Mac: "/dev/tty.usbserial-*"
protocol_end            = 0                 # SCServo bit end(STS/SMS=0, SCS=1)
```


```
~/lib/Feetech-Servo-SDK/scsservo_sdk_example$ python3 ping.py 
Succeeded to open the port
Succeeded to change the baudrate
[ID:101] ping Succeeded. SCServo model number : 777

```
___
```
lerobot-find-cameras opencv
```

<details> 
  <summary>opencv</summary>
    
    $ lerobot-find-cameras opencv
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (2075) handleMessage OpenCV | GStreamer warning: Embedded video playback halted; module source reported: Could not read from resource.
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (1053) open OpenCV | GStreamer warning: unable to start pipeline
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (616) isPipelinePlaying OpenCV | GStreamer warning: GStreamer: pipeline have not been created
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (2075) handleMessage OpenCV | GStreamer warning: Embedded video playback halted; module source reported: Could not read from resource.
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (1053) open OpenCV | GStreamer warning: unable to start pipeline
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (616) isPipelinePlaying OpenCV | GStreamer warning: GStreamer: pipeline have not been created
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (2075) handleMessage OpenCV | GStreamer warning: Embedded video playback halted; module source reported: Could not read from resource.
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (1053) open OpenCV | GStreamer warning: unable to start pipeline
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (616) isPipelinePlaying OpenCV | GStreamer warning: GStreamer: pipeline have not been created
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (2075) handleMessage OpenCV | GStreamer warning: Embedded video playback halted; module source reported: Could not read from resource.
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (1053) open OpenCV | GStreamer warning: unable to start pipeline
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (616) isPipelinePlaying OpenCV | GStreamer warning: GStreamer: pipeline have not been created
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (2075) handleMessage OpenCV | GStreamer warning: Embedded video playback halted; module source reported: Could not read from resource.
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (1053) open OpenCV | GStreamer warning: unable to start pipeline
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (616) isPipelinePlaying OpenCV | GStreamer warning: GStreamer: pipeline have not been created
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (2075) handleMessage OpenCV | GStreamer warning: Embedded video playback halted; module source reported: Could not read from resource.
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (1053) open OpenCV | GStreamer warning: unable to start pipeline
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (616) isPipelinePlaying OpenCV | GStreamer warning: GStreamer: pipeline have not been created
    --- Detected Cameras ---
    Camera #0:
      Name: OpenCV Camera @ /dev/video2
      Type: OpenCV
      Id: /dev/video2
      Backend api: V4L2
      Default stream profile:
        Format: 16.0
        Fourcc: UYVY
        Width: 640
        Height: 480
        Fps: 30.0
    --------------------
    Camera #1:
      Name: OpenCV Camera @ /dev/video4
      Type: OpenCV
      Id: /dev/video4
      Backend api: V4L2
      Default stream profile:
        Format: 16.0
        Fourcc: YUYV
        Width: 640
        Height: 480
        Fps: 30.0
    --------------------
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (2075) handleMessage OpenCV | GStreamer warning: Embedded video playback halted; module source reported: Could not read from resource.
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (1053) open OpenCV | GStreamer warning: unable to start pipeline
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (616) isPipelinePlaying OpenCV | GStreamer warning: GStreamer: pipeline have not been created
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (2075) handleMessage OpenCV | GStreamer warning: Embedded video playback halted; module source reported: Could not read from resource.
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (1053) open OpenCV | GStreamer warning: unable to start pipeline
    [ WARN:0] global ./modules/videoio/src/cap_gstreamer.cpp (616) isPipelinePlaying OpenCV | GStreamer warning: GStreamer: pipeline have not been created
    
    Finalizing image saving...
    Image capture finished. Images saved to outputs/captured_images
    
</details>


```
lerobot-find-cameras realsense
```

<details> 
  <summary>realsense</summary>


    --- Detected Cameras ---
    Camera #0:
      Name: Intel RealSense D435
      Type: RealSense
      Id: 944622071791
      Firmware version: 5.17.0.10
      Usb type descriptor: 2.1
      Physical port: /sys/devices/pci0000:00/0000:00:14.0/usb1/1-4/1-4.3/1-4.3:1.0/video4linux/video0
      Product id: 0B07
      Product line: D400
      Default stream profile:
        Stream_type: Color
        Format: rgb8
        Width: 640
        Height: 480
        Fps: 15
    --------------------
    
    Finalizing image saving...
    Image capture finished. Images saved to outputs/captured_images

</details>

___


### HARDWARE setup:

https://github.com/legalaspro/so101-ros-physical-ai/blob/main/docs/hardware.md#5-calibration-eeprom-and-optional-joint-config-overrides


```
# Arms — replace /dev/ttyACM0 with the device you see:
udevadm info --query=property --name=/dev/ttyACM0 | \
  egrep 'ID_VENDOR_ID|ID_MODEL_ID|ID_SERIAL_SHORT|ID_PATH'
```

```
  egrep 'ID_VENDOR_ID|ID_MODEL_ID|ID_SERIAL_SHORT|ID_PATH'
ID_VENDOR_ID=1a86
ID_MODEL_ID=55d3
ID_SERIAL_SHORT=58A6070029
ID_PATH=pci-0000:00:14.0-usb-0:4.2:1.0
ID_PATH_TAG=pci-0000_00_14_0-usb-0_4_2_1_0

```






