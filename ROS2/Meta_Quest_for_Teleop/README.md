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
_______

### Install the Unity Hub on Linux
Debian or Ubuntu
To install the Unity Hub on a Debian or Ubuntu Linux distribution, you need to add the Unity Hub Debian repository along with the public signing key to verify the integrity of the packages.

To add the public signing key, run the following command:

```
wget -qO - https://hub.unity3d.com/linux/keys/public | gpg --dearmor | sudo tee /usr/share/keyrings/Unity_Technologies_ApS.gpg > /dev/null
```

To add the Unity Hub repository, you need an entry in /etc/apt/sources.list.d. Run the following command to add the Unity Hub repository:

```
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/Unity_Technologies_ApS.gpg] https://hub.unity3d.com/linux/repos/deb stable main" > /etc/apt/sources.list.d/unityhub.list'
```

Update the package cache and install the package:
```
sudo apt update
sudo apt-get install unityhub
```
**Note: For some systems, you may need to ensure the following:

- The directory /usr/share/keyrings exists.
- The user or group installing the Hub has write permissions to the /usr/share/keyrings directory.
- The user or group installing Hub has at least read permissions to the resulting file Unity_Technologies_ApS.gpg.**
To remove the Unity Hub from the system, run the following command:

```
sudo apt-get remove unityhub
```

### run:
```
unityhub
```
_______

3. Open the project from the github repository, or from a local folder if cloned already. It should prompt you with the requisite Unity Editor version you'll need to open the project. Install this version.
https://github.com/PickNikRobotics/meta_quest_teleoperation

4. The app needs the Android SDK to be built. In File -> Build Profiles enable “Android”. This may require downloading the Android SDK if you haven’t already.
5. In Edit->Project Settings, go to the “XR Plugin Management” section and disable “OpenXR”, enable “Oculus”.
6. Under XR Plugin Management->Oculus, make sure your device is checked in “Target Devices”. If you have a Quest 1, make sure to disable “Quest 3”, otherwise, support for the Quest 1 won’t be enabled 🤷
7. In the main menu, Robotics->ROS Settings, set the IP address of the computer where you will be running all the ROS2 nodes, e.g., where MoveIt Pro runs.
8. Connect the Meta Quest to your computer via a USB cable. You should see a message in your headset asking to confirm the debug connection to the computer and data sharing.
9. Under File->Build Profiles->Android->Run Device, you should see your Meta Quest device listed. Select it.
10. Click Build and Run, which should build the application, push it to the device, and run it.


### Run the Meta Quest APK
To run the Meta Quest app after it has already been installed:

1. Put the headset on
2. Open the App Library
3. Choose “Unknown sources”. That should show the app.
4. Click on the app.

When you run the app, you should see a blue sky, a grid, and the two remote controllers.


### Connect to ROS
- note
- This app collects the state of the Meta Quest controllers and publishes it to ROS via the Unity ROS TCP Connector.
https://github.com/Unity-Technologies/ROS-TCP-Endpoint

To be able to see the topics and data published by the Meta Quest app, you will need a dedicated ROS2 node running on the host computer. This node will be the host endpoint for the connection to the Meta Quest.

Clone Unity’s ROS-TCP-Endpoint repo (main-ros2 branch) in your workspace and build it with the rest of your ROS2 packages.

If you are running a firewall, you will have to allow the port used by the Meta Quest. For example, with UFW, you can run:

sudo ufw allow 10000

Start the endpoint with the following command, using the IP of the host computer, where you are running the ROS ecosystem, e.g:

ros2 run ros_tcp_endpoint default_server_endpoint --ros-args -p ROS_IP:=192.168.86.25

You should now be able to see the topics published by the headset, including TF.
