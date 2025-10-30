## Meta Quest for Teleop Setup Guide

https://docs.picknik.ai/hardware_guides/setting_up_the_meta_quest_for_teleop/

The Meta Quest is a great tool for ML model data collection. It requires a little Unity app running on the Quest device. We will walk you through how to set this up in the following.


### Enable Developer Mode

1. Enable “Developer Mode” on your device so that it can run your own application.
- Run the “Meta Horizon” app on your phone
- Connect to the Meta device
- In the device settings->Headset Settings->Developer Mode, turn ‘Developer Mode’ on.
- Note: You may have to log in to your Facebook account and create an “organization” for you to be able to turn developer mode on.


### Build Meta Quest APK from source
If you need to build the Meta Quest app from source, follow these steps.

The app has been developed using Unity, and therefore, you will need to install Unity to build it.

1. Clone the app repository somewhere in your local system.
  https://github.com/PickNikRobotics/meta_quest_teleoperation

2. Install Unity Hub following these instructions. Start the hub and log in, but do not install the Unity editor yet.
  https://docs.unity3d.com/hub/manual/InstallHub.html#install-hub-linux

3. Open the project from the github repository, or from a local folder if cloned already. It should prompt you with the requisite Unity Editor version you'll need to open the project. Install this version.
https://github.com/PickNikRobotics/meta_quest_teleoperation

The app needs the Android SDK to be built. In File -> Build Profiles enable “Android”. This may require downloading the Android SDK if you haven’t already.
In Edit->Project Settings, go to the “XR Plugin Management” section and disable “OpenXR”, enable “Oculus”.
Under XR Plugin Management->Oculus, make sure your device is checked in “Target Devices”. If you have a Quest 1, make sure to disable “Quest 3”, otherwise, support for the Quest 1 won’t be enabled 🤷
In the main menu, Robotics->ROS Settings, set the IP address of the computer where you will be running all the ROS2 nodes, e.g., where MoveIt Pro runs.
Connect the Meta Quest to your computer via a USB cable. You should see a message in your headset asking to confirm the debug connection to the computer and data sharing.
Under File->Build Profiles->Android->Run Device, you should see your Meta Quest device listed. Select it.
Click Build and Run, which should build the application, push it to the device, and run it.
