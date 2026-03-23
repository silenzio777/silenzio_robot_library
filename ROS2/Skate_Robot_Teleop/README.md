

# Skate Robot Teleoperation and Telemetry

https://github.com/Rbotic/skate_teleop

### install:
```
cd ~/lib/
silenzio@ubuntuPC:~/lib$ git clone https://github.com/Rbotic/skate_teleop.git
pip3 install meshcat
pip3 install vuer==0.1.5
```


```python
import casadi as cpin                                                                                
...
#from pinocchio import casadi as cpin  
```

```
## pip3 install pin
pip3 install numpy==1.23.5
pip3 install casadi
```

### Install Pinocchio:

https://stack-of-tasks.github.io/pinocchio/download.html

Add robotpkg apt repository

If you have never added robotpkg as a softwares repository, please follow first the instructions from 1 to 4. Otherwise, go directly to instruction 5. Those instructions are similar to the installation procedures presented in http://robotpkg.openrobots.org/debian.html.

Ensure you have some required installation dependencies
```
sudo apt install -qqy lsb-release curl
```

Register the authentication certificate of robotpkg:
```
sudo mkdir -p /etc/apt/keyrings
curl http://robotpkg.openrobots.org/packages/debian/robotpkg.asc \
    | sudo tee /etc/apt/keyrings/robotpkg.asc
```
Add robotpkg as source repository to apt:

```
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/robotpkg.asc] http://robotpkg.openrobots.org/packages/debian/pub $(lsb_release -cs) robotpkg" \
    | sudo tee /etc/apt/sources.list.d/robotpkg.list
```

You need to run at least once apt update to fetch the package descriptions:
```
sudo apt update
```

Install Pinocchio:

The installation of Pinocchio and its dependencies is made through the line:
```
sudo apt install -qqy robotpkg-py3*-pinocchio
```



### run:

```
cd ~/lib/skate_teleop/teleop$
python3 teleop_main.py
```

http://127.0.0.1:7000/static/
```
dataVisClient Failed to resolve hostname 'r.local': [Errno -2] Name or service not known

********** Television starting: vuer_vis  **********

Vuer Server

Local:   https://vuer.ai?ws=ws://localhost:8012
Network: https://vuer.ai?ws=ws://10.8.1.2:8012

Workspace:

 · file:///home/silenzio/lib/skate_teleop/skt_v3
-> https://vuer.ai/workspace

Press Ctrl-C to exit.
###
Not Connected to robot
###
process_teleop_rx performance: 61.91 Hz (processed 31 loops in 0.50 sec)
###
Not Connected to robot
###
process_teleop_rx performance: 60.09 Hz (processed 31 loops in 0.52 sec)
process_teleop_tx performance: 61.91 Hz (processed 31 loops in 0.50 sec)
process_collect_vr_state performance: 59.71 Hz (processed 30 loops in 0.50 sec)
process_prep_udp_to_send performance: 61.90 Hz (processed 31 loops in 0.50 sec)
You can open the visualizer by visiting the following URL:
http://127.0.0.1:7000/static/

```





__________________

**🥽 Headset Setup**
1. Install and connect [Tailscale](https://github.com/tailscale/tailscale-android/releases/latest). Once setup, you will see both `oculus-quest3` and `your PC name` listed in the Tailscale app.
2. Open `https://your-machine.tailxxxx.ts.net` in the Quest browser.
3. Select “Passthrough” at the bottom-center of the browser.
4. Face the same direction as the ground arrow; hold the Meta button to re-orient if needed.

#### 🛑 Controller Mapping & Safety 

* **'A' button** is a *deadman's switch*

  * Releasing the button immediately places the robot motors into a safe state
  * Motors are fully disabled after 10 seconds if it is not re-engaged

* **Grip Buttons** is a *deadman's switch* for their respective robot arms
* **Triggers** control their respective grippers

---

## 📋 Notes 

* Tested on Ubuntu 20.04 and 22.04
* Should work with other OpenXR headsets (e.g. Apple Vision Pro, PICO4) with minor code changes
* Can run without the physical robot using a virtual robot model



### 4. 🥽 Remote Access via Tailscale (Optional for XR Teleoperation)

### INstall tailscale:
https://tailscale.com/docs/install/linux


```bash
#curl -fsSL https://tailscale.com/install.sh | sh
sudo snap install tailscale
```


To view on VR/XR devices, use Tailscale to promote your local Vuer server to HTTPS:

```bash
sudo tailscale up
sudo tailscale serve localhost:8012
```

This generates a Tailscale HTTPS URL (e.g. https://your-machine.tailxxxx.ts.net). **Keep this terminal running.**

(Optional - for virtual robot control) Modify line 215 of `teleop/open_television/television.py`:
```python
src = "https://user-computer.tail1234.ts.net/workspace/skt_v3.urdf"  # replace 'https://user-computer.tail1234.ts.net/' with your own Tailscale URL
```





___


https://docs.vuer.ai/en/latest/examples/vr_xr/motion_controllers.html

https://github.com/vuer-ai/vuer


Quest 3 Motion Controller States
The MotionController offers a way to stream the current pose, button and trackpad states of the Quest 3 motion controller to the python side. To use this mixed reality (XR) feature, you need to setup vuer behind a SSL proxy. I usually use ngrok, which is a paid service. You can also use local tunnel, which is free.

https://localtunnel.me/
```
sudo npm install -g localtunnel
lt --port 8000
```
