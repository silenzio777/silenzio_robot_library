






### Install sublime text:

```
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.sublimetext.com/sublimehq-pub.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/sublimehq-archive.gpg
echo "deb [signed-by=/etc/apt/keyrings/sublimehq-archive.gpg] https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt update
sudo apt install -y sublime-text
```
_________

### Install ros-humble-desktop-full:

```
sudo apt update
sudo apt install -y software-properties-common curl
sudo add-apt-repository -y universe
```
```
ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
CODENAME=$(. /etc/os-release && echo "$VERSION_CODENAME")
curl -L -o /tmp/ros2-apt-source.deb \
  "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.${CODENAME}_all.deb"
sudo apt install -y /tmp/ros2-apt-source.deb
```
```
sudo apt update
sudo apt install -y ros-humble-desktop-full python3-colcon-common-extensions
```
```
echo 'source /opt/ros/humble/setup.bash' >> ~/.bashrc
source /opt/ros/humble/setup.bash
python3 -c "import rclpy; from geometry_msgs.msg import Twist; print('rclpy OK')"
```


### Fresh system install:

```
sudo add-apt-repository universe
sudo apt update
sudo apt-get install chromium-browser
sudo apt-get install python3-pip
sudo apt install curl git wget nano
```


### Disabling Wayland:
- Wayland is an alternative to the xorg windows system. One day, it will be terrific. For now, it does not work with x11vnc or other important applications like TeamViewer.

```
sudo nano /etc/gdm3/custom.conf
```
`#` Uncomment the line below to force the login screen to use Xorg

```
WaylandEnable=false
```

reboot


___________

### Install amnezia kvn:

```
sudo apt update
sudo apt autoremove -y
sudo apt update
sudo apt install -y qt6-base-dev libqt6widgets6
sudo apt install -y libxcb-cursor0 libxcb-xinerama0 libxcb-icccm4 libxcb-keysyms1 libopengl0 libxkbcommon-x11-0
```
### get AmneziaVPN_4.8.11.4_linux_x64.tar.zip from amnezia github:
[AmneziaVPN_4.8.11.4_linux_x64.tar.zip](https://github.com/amnezia-vpn/amnezia-client/releases/download/4.8.11.4/AmneziaVPN_4.8.11.4_linux_x64.tar.zip)


