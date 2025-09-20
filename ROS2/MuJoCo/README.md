

## MuJoCo

https://docs.openarm.dev/simulation/mujoco/

__________

Multi-Joint dynamics with Contact is a physics engine maintained by Google Deepmind.

MJCFs (MuJoCo description Files) are XML files used to describe all the moving components of a scene, enabling the experimentation of algorithms in a reproducible environment.

To get started, download the latest MuJoCo binaries and open a simulate window.

### Install simulator app:
For example, for MuJoCo 3.3.6 on x86 linux:

```
cd '/home/silenzio/lib/
MUJOCO_VERSION="3.3.6"
wget -q --show-progress "https://github.com/google-deepmind/mujoco/releases/download/${MUJOCO_VERSION}/mujoco-${MUJOCO_VERSION}-linux-x86_64.tar.gz"
tar --extract --gzip --verbose --file="mujoco-${MUJOCO_VERSION}-linux-x86_64.tar.gz"
rm "mujoco-${MUJOCO_VERSION}-linux-x86_64.tar.gz"
cd "mujoco-${MUJOCO_VERSION}/bin"
./simulate
```

### Run simulator app:
```
cd '/home/silenzio/lib/mujoco-3.3.6/bin'
./simulate
```
```
MuJoCo version 3.3.6
Plugins registered by library 'libelasticity.so':
    mujoco.elasticity.cable
Plugins registered by library 'libsensor.so':
    mujoco.sensor.touch_grid
Plugins registered by library 'libactuator.so':
    mujoco.pid
Plugins registered by library 'libsdf_plugin.so':
    mujoco.sdf.bolt
    mujoco.sdf.bowl
    mujoco.sdf.gear
    mujoco.sdf.nut
    mujoco.sdf.torus
```

### works

_______

Then, clone the openarm_mujoco repository:

git clone https://github.com/enactic/openarm_mujoco.git

Open a file explorer and drag the v1/openarm_bimanual.mjcf.xml file into the simulate window.

