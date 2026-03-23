

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
pip3 install pin
pip3 install numpy==1.23.5
pip3 install casadi
```


_________

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
