

## MuJoCo

https://docs.openarm.dev/simulation/mujoco/

__________

Multi-Joint dynamics with Contact is a physics engine maintained by Google Deepmind.

MJCFs (MuJoCo description Files) are XML files used to describe all the moving components of a scene, enabling the experimentation of algorithms in a reproducible environment.

To get started, download the latest MuJoCo binaries and open a simulate window.


For example, for MuJoCo 3.3.6 on x86 linux:

```
MUJOCO_VERSION="3.3.6"
wget -q --show-progress "https://github.com/google-deepmind/mujoco/releases/download/${MUJOCO_VERSION}/mujoco-${MUJOCO_VERSION}-linux-x86_64.tar.gz"
tar --extract --gzip --verbose --file="mujoco-${MUJOCO_VERSION}-linux-x86_64.tar.gz"
rm "mujoco-${MUJOCO_VERSION}-linux-x86_64.tar.gz"
cd "mujoco-${MUJOCO_VERSION}/bin"
./simulate
```

### works

_______

Then, clone the openarm_mujoco repository:

git clone https://github.com/enactic/openarm_mujoco.git

Open a file explorer and drag the v1/openarm_bimanual.mjcf.xml file into the simulate window.

