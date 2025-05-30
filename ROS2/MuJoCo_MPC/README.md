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
