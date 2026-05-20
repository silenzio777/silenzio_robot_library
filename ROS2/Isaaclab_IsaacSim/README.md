# install isaac-sim 2.2.0 

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

### works

