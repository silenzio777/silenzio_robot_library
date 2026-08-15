






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

- Update Ubuntu software in System `Software Updater`

```
sudo apt update
sudo apt autoremove -y
sudo apt update
sudo apt install -y qt6-base-dev libqt6widgets6
sudo apt install -y libxcb-cursor0 libxcb-xinerama0 libxcb-icccm4 libxcb-keysyms1 libopengl0 libxkbcommon-x11-0
```

### get AmneziaVPN_4.8.11.4_linux_x64.tar.zip from amnezia github:
[AmneziaVPN_4.8.11.4_linux_x64.tar.zip](https://github.com/amnezia-vpn/amnezia-client/releases/download/4.8.11.4/AmneziaVPN_4.8.11.4_linux_x64.tar.zip)

Unzip archive `AmneziaVPN_4.8.11.4_linux_x64.tar.zip`

```
chmod +x AmneziaVPN_Linux_Installer.bin
```

Install app, run:

```
`./AmneziaVPN_Linux_Installer.bin`
```
__________


### Как layout перенести на другую машину

1. Установить terminator (если не стоит):
```
sudo apt install terminator
```

2. Прописать layout. Открой ~/.config/terminator/config и вставь/слей это содержимое (секция [[tree]] внутри [layouts] — если файла ещё нет, можно взять целиком):

```
[global_config]
  suppress_multiple_term_dialog = True
[profiles]
  [[default]]
[layouts]
  [[default]]
    [[[window0]]]
      type = Window
      parent = ""
    [[[child1]]]
      type = Terminal
      parent = window0
  [[tree]]
    [[[child0]]]
      type = Window
      parent = ""
      order = 0
      size = 894, 554
    [[[terminal1]]]
      type = Terminal
      parent = child0
      order = 0
      profile = default
    [[[child4]]]
      type = Window
      parent = ""
      order = 0
      size = 1091, 1106
    [[[child5]]]
      type = VPaned
      parent = child4
      order = 0
      position = 550
    [[[child6]]]
      type = VPaned
      parent = child5
      order = 0
      position = 272
    [[[terminal7]]]
      type = Terminal
      parent = child6
      order = 0
      profile = default
      command = "source /opt/ros/humble/setup.bash && echo 'ros2 run joy joy_node' && ros2 run joy joy_node; exec bash"
    [[[terminal8]]]
      type = Terminal
      parent = child6
      order = 1
      profile = default
      command = "source /opt/ros/humble/setup.bash && echo 'ros2 run teleop_twist_joy teleop_node --ros-args -p axis_linear.x:=1 -p scale_linear.x:=1.0 -p axis_linear.y:=0 -p scale_linear.y:=1.0 -p axis_angular.yaw:=3 -p scale_angular.yaw:=1.0 -p require_enable_button:=false' && ros2 run teleop_twist_joy teleop_node --ros-args -p axis_linear.x:=1 -p scale_linear.x:=1.0 -p axis_linear.y:=0 -p scale_linear.y:=1.0 -p axis_angular.yaw:=3 -p scale_angular.yaw:=1.0 -p require_enable_button:=false; exec bash"
    [[[child9]]]
      type = VPaned
      parent = child5
      order = 1
      position = 272
    [[[terminal10]]]
      type = Terminal
      parent = child9
      order = 0
      profile = default
    [[[terminal11]]]
      type = Terminal
      parent = child9
      order = 1
      profile = default
      directory = /home/ИМЯ_ПОЛЬЗОВАТЕЛЯ/lib/robot_stand
      command = "source /opt/ros/humble/setup.bash; exec bash"
[plugins]
```

3. Проверить layout:
```
terminator --layout=tree
```

4. Настроить автозапуск при входе:

```  
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/terminator-tree.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Terminator (tree layout)
Comment=Launch Terminator with the "tree" layout at login
Exec=terminator --layout=tree
Icon=terminator
Terminal=false
X-GNOME-Autostart-enabled=true
EOF
```

