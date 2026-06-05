# install isaac-sim 4.5, isaac-lab 2.2.0 

```
cd ~/lib
mkdir isaac
cd isaac
```

```
python3 -m venv env_isaaclab_2_2_0
source env_isaaclab_2_2_0/bin/activate
unset PYTHONPATH
pip3 install --upgrade pip
```

```
pip3 install /home/silenzio/Downloads/isaacsim_extscache_kit-4.5.0.0-cp310-none-manylinux_2_34_x86_64.whl
pip3 install 'isaacsim[all,extscache]==4.5.0' --extra-index-url https://pypi.nvidia.com
```

---
```
sudo apt install cmake build-essential
pip install "cmake<3.27"
export CMAKE_POLICY_VERSION_MINIMUM=3.5
```

### Download isaac-sim 2.2.0
https://github.com/isaac-sim/IsaacLab/tree/release/2.2.0

Then <>Code --> Download ZIP

Unzip to IsaacLab_2_2_0

```
pip3 install pip==23
pip3 install setuptools==65
cd IsaacLab_2_2_0
./isaaclab.sh --install # or "./isaaclab.sh -i"
```

```
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/silenzio/lib/isaac/IsaacLab_2_2_0/env_isaaclab_2_2_0/lib/python3.10/site-packages/isaacsim/exts/isaacsim.ros2.bridge/humble/lib
```

### add config:
```
nano /home/silenzio/lib/isaac/IsaacLab_2_2_0/env_isaaclab_2_2_0/bin/activate
```

### add text to file:
```
# Настройки для ROS2 Bridge в Isaac Sim
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/silenzio/lib/isaac/IsaacLab_2_2_0/env_isaaclab_2_2_0/lib/python3.10/site-packages/isaacsim/exts/isaacsim.ros2.bridge/humble/lib
```

### run:
```
_./isaaclab.sh -s
./isaaclab.sh --sim
```

### run without registry:
```
cd ~/lib/isaac/IsaacLab_2_2_0
source env_isaaclab_2_2_0/bin/activate

./isaaclab.sh -s --/app/extensions/registry/enabled=false
```

### or:
```
./isaaclab.sh -s --/app/extensions/syncRegistry=false
```

### kill isaac:
```
pkill -9 -f isaac
```

____
### T1:


```
cd ~/lib/isaac/IsaacLab_2_2_0
source env_isaaclab_2_2_0/bin/activate
./isaaclab.sh -p '/home/silenzio/lib/isaac/IsaacLab_2_2_0/scripts/tutorials/00_sim/create_empty.py'
```

### T2:
```
watch -n 2 'du -sh ~/.local/share/ov/data/exts/v2 2>/dev/null'
watch -n 2 'du -sh ~/.local/share/ov 2>/dev/null'
watch -n 2 'du -sh ~/.cache/ov 2>/dev/null'
```
___
### CLEAR CACHE
```
rm -rf ~/.cache/ov
rm -rf ~/.cache/nvidia/GLCache
rm -rf ~/.local/share/ov/data/Kit/Isaac-Sim/4.5
```

___
```
du -sh ~/.cache/ov
```

300M	/home/silenzio/.cache/ov

```
du -sh  ~/.local/share/ov
```
359M	/home/silenzio/.local/share/ov


Найдите папки кэша Omniverse:
~/.cache/ov – общий кэш Kit
~/.local/share/ov – могут быть дополнительные данные

Также расширения могут лежать прямо внутри установки Isaac Sim:
_isaac_sim/kit/exts
_isaac_sim/exts

___

## Test speed:
```
curl -o /dev/null \
-L \
-w "\nSpeed: %{speed_download} bytes/sec\n" \
http://d4i3qtqj3r0z5.cloudfront.net/omni.kit.menu.edit-874360293737b28f.zip
```

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  352k  100  352k    0     0  1200k      0 --:--:-- --:--:-- --:--:-- 1227k

Speed: 1229307 bytes/sec
```

__

Быстрый эксперимент
Попробуй запустить самый минимальный headless-тест:

```
python3 -c "
from isaacsim import SimulationApp
simulation_app = SimulationApp({'headless': True})
print('OK')
simulation_app.close()"
```
___

### tailscale OFF

```
sudo snap stop tailscale
sudo snap disable tailscale
```

### tailscale ON
```
sudo snap enable tailscale
sudo tailscale up
```


### Train:



```
./isaaclab.sh -p scripts/reinforcement_learning/rsl_rl/train.py --task=Isaac-Ant-v0 --headless
./isaaclab.sh -p scripts/reinforcement_learning/rsl_rl/train.py --task=Isaac-Velocity-Rough-Anymal-C-v0 --headless
```

### PLay:
```
./isaaclab.sh -p scripts/reinforcement_learning/rsl_rl/play.py --task=Isaac-Ant-v0
```





