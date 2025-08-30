

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
