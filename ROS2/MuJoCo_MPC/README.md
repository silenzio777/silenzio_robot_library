## MuJoCo MPC

MuJoCo MPC (MJPC) is an interactive application and software framework for real-time predictive control with MuJoCo, developed by Google DeepMind.

https://github.com/google-deepmind/mujoco_mpc

### Installation:

MJPC is tested with Ubuntu 20.04 and macOS-12. In principle, other versions and Windows operating system should work with MJPC, but these are not tested.

Prerequisites
Operating system specific dependencies:

### macOS

Install Xcode.

Install ninja and zlib:
```
brew install ninja zlib
```

Clone MuJoCo MPC
```
git clone https://github.com/google-deepmind/mujoco_mpc
```

Build and Run MJPC GUI application

Change directory:
```
cd mujoco_mpc
```
Create and change to build directory:
```
mkdir build

cd build
```

Configure:
### macOS-12
```
cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -G Ninja -DMJPC_BUILD_GRPC_SERVICE:BOOL=ON
```
### Ubuntu 20.04
```
cmake .. -DCMAKE_BUILD_TYPE:STRING=Release -G Ninja -DCMAKE_C_COMPILER:STRING=clang-12 -DCMAKE_CXX_COMPILER:STRING=clang++-12 -DMJPC_BUILD_GRPC_SERVICE:BOOL=ON
```
Note: gRPC is a large dependency and can take 10-20 minutes to initially download.

Build
```
cmake --build . --config=Release
```
Run GUI application
```
cd bin
./mjpc
```
### Works on macOS!

# Graphical User Interface

- [Graphical User Interface](#graphical-user-interface)
  - [Overview](#overview)
  - [User Guide](#user-guide)

## Overview

The MJPC GUI is built on top of MuJoCo's `simulate` application with a few additional features. The below screenshot shows a capture of the GUI for the `walker` task.

![image](https://github.com/user-attachments/assets/8d80913d-bcf7-4eb4-bbdd-f60c39caf503)

## User Guide

- Press `F1` to bring up a help pane that describes how to use the GUI.
- The MJPC GUI is an extension of MuJoCo's native `simulate` viewer, with the same keyboard shortcuts and mouse functionality.
    - `+` speeds up the simulation, resulting in fewer planning steps per simulation step.
    - `-` slows down the simulation, resulting in more planning steps per simulation step.
- The `simulate` viewer enables drag-and-drop interaction with simulated objects to apply forces or torques.
    - Double-click on a body to select it.
    - `Ctrl + left drag` applies a torque to the selected object, resulting in rotation.
    - `Ctrl + right drag` applies a force to the selected object in the `(x,z)` plane, resulting in translation.
    - `Ctrl + Shift + right drag` applies a force to the selected object in the `(x,y)` plane.
- MJPC adds three keyboard shortcuts:
    - The `Enter` key starts and stops the planner.
    - The `\` key starts and stops the controller (sending actions from the planner to the model).
    - The `9` key turns the traces on/off.

____________

## Python API
not tested...

We provide a simple Python API for MJPC. This API is still experimental and expects some more experience from its users. For example, the correct usage requires that the model (defined in Python) and the MJPC task (i.e., the residual and transition functions defined in C++) are compatible with each other. Currently, the Python API does not provide any particular error handling for verifying this compatibility and may be difficult to debug without more in-depth knowledge about MuJoCo and MJPC.

### Installation
Prerequisites
Build MJPC (see instructions above).

Python 3.10

(Optionally) Create a conda environment with Python 3.10:
```
conda create -n mjpc python=3.10
conda activate mjpc
```
Install MuJoCo
```
pip install mujoco
```
Install API
Next, change to the python directory:

```
cd python
```
Install the Python module:
```
python setup.py install
```
Test that installation was successful:
```
python "mujoco_mpc/agent_test.py"
```
Example scripts are found in python/mujoco_mpc/demos. For example from python/:
```
python mujoco_mpc/demos/agent/cartpole_gui.py
```
will run the MJPC GUI application using MuJoCo's passive viewer via Python.

Python API Installation Issues
If your installation fails or is terminated prematurely, we recommend deleting the MJPC build directory and starting from scratch as the build will likely be corrupted. Additionally, delete the files generated during the installation process from the python/ directory.

