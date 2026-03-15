
cd ~/lib
cd src/
git clone --recurse-submodules https://github.com/legalaspro/so101-ros-physical-ai.git
sudo apt update

colcon build --packages-select so101-ros-physical-ai
[0.614s] colcon.colcon_core.package_selection WARNING ignoring unknown package 'so101-ros-physical-ai' in --packages-select
                     
Summary: 0 packages finished [0.59s]

colcon build --packages-select feetech_ros2_driver

Make Error at feetech_driver/CMakeLists.txt:36 (find_package):
  By not providing "Findrange-v3.cmake" in CMAKE_MODULE_PATH this project has
  asked CMake to find a package configuration file provided by "range-v3",
  but CMake did not find one.

  Could not find a package configuration file provided by "range-v3" with any
  of the following names:

    range-v3Config.cmake
    range-v3-config.cmake

## FIX:

cd ~/lib/
git clone https://github.com/Microsoft/vcpkg.git
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg integrate install
./vcpkg install range-v3

Computing installation plan...
The following packages will be built and installed:
    range-v3:x64-linux@0.12.0#4
  * vcpkg-cmake:x64-linux@2024-04-23
  * vcpkg-cmake-config:x64-linux@2024-05-23
...
Completed submission of range-v3:x64-linux@0.12.0#4 to 1 binary cache(s) in 47.3 ms (1/1)





