https://github.com/nilutpolkashyap/vlms_with_ros2_workshop


Create & Setup Python Virtual Environment
cd ~/ros2_ws

virtualenv -p python3 ./vlm-venv                      
source ./vlm-venv/bin/activate

# Make sure that colcon doesn’t try to build the venv
touch ./vlm-venv/COLCON_IGNORE        
Install Python dependencies
pip install timm --extra-index-url https://download.pytorch.org/whl/cpu  # is needed for torch

pip install "openvino>=2024.1" "torch>=2.1" opencv-python supervision transformers yapf pycocotools addict "gradio>=4.19" tqdm

Add your Python virtual environment package path
Make sure to update <<YOUR_USER_NAME>> with your system username.
```
export PYTHONPATH=/home/silenzio/ros2_ws/vlm-venv/lib/python3.10/site-packages/:$PYTHONPATH
```

export PYTHONPATH=/home/silenzio/tws/vlm-venv/lib/python3.10/site-packages/:$PYTHONPATH


Clone this repository inside the 'src' folder of your workspace
cd ~/ros2_ws/src

git clone https://github.com/nilutpolkashyap/vlms_with_ros2_workshop.git

Download weights and required packages
cd ~/ros2_ws/src/vlms_with_ros2_workshop

python3 download_weights.py

Download OpenVINO IR models from Google Drive
Download the zip file from the Google Drive link here

Place the contents of the zip file inside the 'openvino_irs' directory in the following path

~/ros2_ws/src/vlms_with_ros2_workshop/ros2_vlm/ros2_vlm/modules/openvino_irs

vlms_with_ros2_workshop
ros2_vlm

Build and source the workspace
cd ~/ros2_ws
colcon build --packages-select ros2_vlm --symlink-install 

source ~/ros2_ws/install/setup.bash


