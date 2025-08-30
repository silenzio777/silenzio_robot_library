

https://maniskill.readthedocs.io/en/latest/user_guide/demos/scripts.html


UBUNTU_PC:

## Install:

```
sudo apt-get install libvulkan1
pip3 install numpy==1.23.5
pip install "pyglet<2"
pip3 install --upgrade mani_skill
```

## Run:

```
python -m mani_skill.examples.demo_random_action -e "TwoRobotStackCube-v1"   --render-mode="human"
python -m mani_skill.examples.demo_random_action -e "RotateValveLevel2-v1"   --render-mode="human"
python -m mani_skill.examples.teleoperation.interactive_panda -e "StackCube-v1" 
python -m mani_skill.examples.motionplanning.panda.run -e "StackCube-v1" --vis
```


### Visualize Pointcloud Data
```
python -m mani_skill.examples.demo_vis_pcd -e "StackCube-v1"
```

### Visualize Segmentation Data

You can run the following to visualize the segmentation data

```
python -m mani_skill.examples.demo_vis_segmentation -e "StackCube-v1"
python -m mani_skill.examples.demo_vis_segmentation -e "StackCube-v1" \
  --id id_of_part # mask out everything but the selected part
```


### Visualize Any Robot
Run the following to open a viewer displaying any robot given in a empty scene with just a floor. You can also specify different keyframes if there are any pre-defined to visualize.

```
python -m mani_skill.examples.demo_robot -r "panda"
```



__

https://github.com/enactic/openarm_maniskill_simulation


## Clone Maniskill

Clone Maniskill git at your HOME directory

```
cd ~/lib
git clone https://github.com/haosulab/ManiSkill.git
```

## Install Maniskill

```
cd ManiSkill && pip install -e .
pip install torch torchvision torchaudio tensorboard wandb
```


## Install OpenArm pick up task

```
cd ~/lib
git clone https://github.com/enactic/openarm_maniskill_simulation.git
cp -r ~/lib/openarm_maniskill_simulation/urdf ~/lib/ManiSkill/mani_skill/assets/robots/openarm
```









