
# 

https://maniskill.readthedocs.io/en/latest/user_guide/demos/scripts.html


UBUNTU_PC:

## Install:

```
sudo apt-get install libvulkan1
```
```
cat  /usr/share/vulkan/icd.d/nvidia_icd.json
```
```
{
    "file_format_version" : "1.0.1",
    "ICD": {
        "library_path": "libGLX_nvidia.so.0",
        "api_version" : "1.4.312"
    }
}
```

```
$ cat /usr/share/glvnd/egl_vendor.d/10_nvidia.json
```
```
{
    "file_format_version" : "1.0.0",
    "ICD" : {
        "library_path" : "libEGL_nvidia.so.0"
    }
}
```

```
sudo nano /etc/vulkan/implicit_layer.d/nvidia_layers.json
```

Add this text:

```
{
    "file_format_version" : "1.0.0",
    "layer": {
        "name": "VK_LAYER_NV_optimus",
        "type": "INSTANCE",
        "library_path": "libGLX_nvidia.so.0",
        "api_version" : "1.4.312",
        "implementation_version" : "1",
        "description" : "NVIDIA Optimus layer",
        "functions": {
            "vkGetInstanceProcAddr": "vk_optimusGetInstanceProcAddr",
            "vkGetDeviceProcAddr": "vk_optimusGetDeviceProcAddr"
        },
        "enable_environment": {
            "__NV_PRIME_RENDER_OFFLOAD": "1"
        },
        "disable_environment": {
            "DISABLE_LAYER_NV_OPTIMUS_1": ""
        }
    }
}
```



```
pip3 install numpy==1.23.5
pip install "pyglet<2"
pip3 install --upgrade mani_skill
```



## Run:

```
python -m mani_skill.examples.demo_random_action -e "TwoRobotStackCube-v1"   --render-mode="human"
python -m mani_skill.examples.demo_random_action -e "RotateValveLevel2-v1"   --render-mode="human"
python -m mani_skill.examples.motionplanning.panda.run -e "StackCube-v1" --vis
```
```
python -m mani_skill.examples.teleoperation.interactive_panda -e "StackCube-v1" 
```

You can then drag the end-effector of the robot arm around to any position and rotation and press “n” on the keyboard to generate a trajectory to that place (done via motion planning). Each time the system will also print the current info about whether the task is solved or not.

You can press “g” to toggle the gripper to be closing or opening.

To finish collecting one trajectory and to move on to another, simply press “c” which will save the last trajectory.

To stop data collection press “q” to quit. This will then save the trajectory data to your demos/teleop/<env_id> folder. In addition it will generate videos of your demos after and put them in the same folder, you can stop this by pressing CTRL+C to stop the script.

You can always press “h” to bring up a help menu describing the keyboard commands.

<img width="1920" height="1194" alt="image" src="https://github.com/user-attachments/assets/1c0f7a6d-248c-4a13-bfd5-562c0072e664" />



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
### pip install torch torchvision torchaudio tensorboard wandb
```


## Install OpenArm pick up task

```
cd ~/lib
git clone https://github.com/enactic/openarm_maniskill_simulation.git
```

###  copy openarm assets
```
## cp -r ~/lib/openarm_maniskill_simulation/urdf ~/lib/ManiSkill/mani_skill/assets/robots/openarm
cp -r ~/lib/openarm_maniskill_simulation/urdf /home/silenzio/.local/lib/python3.10/site-packages/mani_skill/assets/robots/openarm
cp -r /home/silenzio/lib/ManiSkill/mani_skill/agents/robots /home/silenzio/.local/lib/python3.10/site-packages/mani_skill/agents/robots

```

###  copy agents(robot)
```
## cp ~/lib/openarm_maniskill_simulation/mani_skill/agents/robots/__init__.py ~/lib/ManiSkill/mani_skill/agents/robots
## cp -r ~/lib/openarm_maniskill_simulation/mani_skill/agents/robots/openarm ~/lib/ManiSkill/mani_skill/agents/robots

cp ~/lib/openarm_maniskill_simulation/mani_skill/agents/robots/__init__.py /home/silenzio/.local/lib/python3.10/site-packages/mani_skill/agents/robots
cp -r ~/lib/openarm_maniskill_simulation/mani_skill/agents/robots/openarm /home/silenzio/.local/lib/python3.10/site-packages/mani_skill/agents/robots


```

### copy task files
```
## cp ~/lib/openarm_maniskill_simulation//mani_skill/envs/tasks/tabletop/pick_cube.py ~/lib/ManiSkill/mani_skill/envs/tasks/tabletop
## cp ~/lib//openarm_maniskill_simulation//mani_skill/envs/tasks/tabletop/pick_cube_cfgs.py ~/lib/ManiSkill/mani_skill/envs/tasks/tabletop
## cp ~/lib/openarm_maniskill_simulation//mani_skill/envs/tasks/tabletop/pull_cube.py ~/lib/ManiSkill/mani_skill/envs/tasks/tabletop
## cp ~/lib/openarm_maniskill_simulation//mani_skill/envs/tasks/tabletop/push_cube.py ~/lib/ManiSkill/mani_skill/envs/tasks/tabletop

cp ~/lib/openarm_maniskill_simulation//mani_skill/envs/tasks/tabletop/pick_cube.py /home/silenzio/.local/lib/python3.10/site-packages/mani_skill/envs/tasks/tabletop
cp ~/lib/openarm_maniskill_simulation//mani_skill/envs/tasks/tabletop/pick_cube_cfgs.py /home/silenzio/.local/lib/python3.10/site-packages/mani_skill/envs/tasks/tabletop
cp ~/lib/openarm_maniskill_simulation//mani_skill/envs/tasks/tabletop/pull_cube.py /home/silenzio/.local/lib/python3.10/site-packages/mani_skill/envs/tasks/tabletop
cp ~/lib/openarm_maniskill_simulation//mani_skill/envs/tasks/tabletop/push_cube.py /home/silenzio/.local/lib/python3.10/site-packages/mani_skill/envs/tasks/tabletop

```

### Fix the source code

File - "/mani_skill/agents/robots/openarm/openarm.py" line 181:

```python

        # ------- #
        # Gripper #
        # ------- #
        # NOTE(jigu): IssacGym uses large P and D but with force limit
        # However, tune a good force limit to have a good mimic behavior
        gripper_pd_mimic_joint_pos = PDJointPosMimicControllerConfig(
            self.gripper_joint_names,
            lower=[0],
            upper=[0.0451],
            stiffness=self.gripper_stiffness,
            damping=self.gripper_damping,
            force_limit=self.gripper_force_limit,
            #mimic={"openarm_finger_joint2": {"joint": "openarm_finger_joint1", "multiplier": 1.0}}
        )
```



### Visualize Any Robot
Run the following to open a viewer displaying any robot given in a empty scene with just a floor. You can also specify different keyframes if there are any pre-defined to visualize.

```
python -m mani_skill.examples.demo_robot -r "openarm"
```

### Run Training
You can run different tasks. Replace <TASK_NAME> with one of the following available tasks:

| Task Description        | Task Name                      |  Demo                               |
| ----------------------- | ------------------------------ | ----------------------------------- | 
| Push the cube to the center of the target.　| `PushCube-v1` | |
| Pull the cube to the cente of the target. | `PullCube-v1` |   |
| Pick up the cube and move it to the target position.　| `PickCube-v1` |  |


```
python ppo.py \
	--env_id="PushCube-v1" \
	--exp-name="PushCube-v1" \
	--num_envs=1024 \
	--total_timesteps=12_000_000 \
	--eval_freq=10 \
	--num-steps=20 \
	--num_eval_envs 8
```

```
2025-08-30 20:13:59,443 - mani_skill  - WARNING - Agent openarm is already registered. Skip registration.
Saving eval videos to runs/PushCube-v1/videos
Running training
####
args.num_iterations=585 args.num_envs=1024 args.num_eval_envs=8
args.minibatch_size=640 args.batch_size=20480 args.update_epochs=4
####
Epoch: 1, global_step=0
Evaluating
Evaluated 400 steps resulting in 8 episodes
eval_success_once_mean=0.0
eval_return_mean=3.9879086017608643
eval_episode_len_mean=50.0
eval_reward_mean=0.0797581672668457
eval_success_at_end_mean=0.0
model saved to runs/PushCube-v1/ckpt_1.pt
SPS: 4386
Epoch: 2, global_step=20480
SPS: 7429

...

SPS: 19042
Epoch: 581, global_step=11878400
Evaluating
Evaluated 400 steps resulting in 8 episodes
eval_success_once_mean=1.0
eval_return_mean=23.27496337890625
eval_episode_len_mean=50.0
eval_reward_mean=0.46549925208091736
eval_success_at_end_mean=0.375
model saved to runs/PushCube-v1/ckpt_581.pt
SPS: 18972
Epoch: 582, global_step=11898880
SPS: 18986
Epoch: 583, global_step=11919360
SPS: 18999
Epoch: 584, global_step=11939840
SPS: 19012
Epoch: 585, global_step=11960320
SPS: 19024
model saved to runs/PushCube-v1/final_ckpt.pt
```

### Run evaluate
How to evaluate a trained model.
```
python ppo.py \
       --env_id="PushCube-v1" \
       --evaluate \
       --exp-name="PushCube-v1" \
       --num_eval_envs=1 \
       --checkpoint "/home/silenzio/lib/ManiSkill/examples/baselines/ppo/runs/PushCube-v1/final_ckpt.pt"
```

```
2025-08-30 20:57:45,278 - mani_skill  - WARNING - Agent openarm is already registered. Skip registration.
Saving eval videos to /home/silenzio/lib/ManiSkill/examples/baselines/ppo/runs/PushCube-v1/test_videos
2025-08-30 20:57:46,871 - mani_skill  - WARNING - mani_skill is not installed with git.
Running evaluation
####
args.num_iterations=390 args.num_envs=512 args.num_eval_envs=1
args.minibatch_size=800 args.batch_size=25600 args.update_epochs=4
####
Epoch: 1, global_step=0
Evaluating
Evaluated 50 steps resulting in 1 episodes
eval_success_once_mean=1.0
eval_return_mean=40.852027893066406
eval_episode_len_mean=50.0
eval_reward_mean=0.8170405626296997
eval_success_at_end_mean=1.0
```



https://github.com/user-attachments/assets/e9c1f1f0-8412-478d-9f85-addcdd429c73



File "trajectory.json":
```
{
  "env_info": {
    "env_id": "PushCube-v1",
    "env_kwargs": {
      "num_envs": 1,
      "reconfiguration_freq": 1,
      "obs_mode": "state",
      "render_mode": "rgb_array",
      "sim_backend": "physx_cuda",
      "control_mode": "pd_joint_delta_pos"
    },
    "max_episode_steps": 50
  },
  "commit_info": null,
  "episodes": [
    {
      "episode_id": 0,
      "episode_seed": 1791095845,
      "control_mode": "pd_joint_delta_pos",
      "elapsed_steps": 50,
      "reset_kwargs": {
        "options": {}
      },
      "success": true
    }
  ]
}
```

___


```
python ppo.py \
	--env_id="PullCube-v1" \
	--exp-name="PullCube-v1" \
	--num_envs=2048 \
	--total_timesteps=12_000_000 \
	--eval_freq=10 \
	--num-steps=20 \
	--num_eval_envs 8
```



https://github.com/user-attachments/assets/10436f6f-eb6a-451e-a259-4b2257c859fc


https://github.com/user-attachments/assets/a3880601-b988-4902-9f1f-c9eafdd0a9c3


```
python ppo.py
	--env_id="PickCube-v1"
	--exp-name="PickCube-v1"
	--num_envs=4096
	--total_timesteps=12_000_000
	--eval_freq=10
	--num-steps=20
	--num_eval_envs 8
```
```
2025-08-30 21:38:53,399 - mani_skill  - WARNING - Agent openarm is already registered. Skip registration.
Saving eval videos to runs/PickCube-v1/videos
Running training
####
args.num_iterations=146 args.num_envs=4096 args.num_eval_envs=8
args.minibatch_size=2560 args.batch_size=81920 args.update_epochs=4
####
Epoch: 1, global_step=0
Evaluating
Evaluated 400 steps resulting in 8 episodes
eval_success_once_mean=0.125
eval_return_mean=8.787243843078613
eval_episode_len_mean=50.0
eval_reward_mean=0.17574487626552582
eval_success_at_end_mean=0.125
model saved to runs/PickCube-v1/ckpt_1.pt
SPS: 13835
Epoch: 2, global_step=81920
SPS: 22994


...

Epoch: 140, global_step=11386880
SPS: 39171
Epoch: 141, global_step=11468800
Evaluating
Evaluated 400 steps resulting in 8 episodes
eval_success_once_mean=1.0
eval_return_mean=36.434654235839844
eval_episode_len_mean=50.0
eval_reward_mean=0.7286931276321411
eval_success_at_end_mean=0.625
model saved to runs/PickCube-v1/ckpt_141.pt
SPS: 38838
Epoch: 142, global_step=11550720
SPS: 38832
Epoch: 143, global_step=11632640
SPS: 38872
Epoch: 144, global_step=11714560
SPS: 38878
Epoch: 145, global_step=11796480
SPS: 38876
Epoch: 146, global_step=11878400
SPS: 38889
model saved to runs/PickCube-v1/final_ckpt.pt
```

https://github.com/user-attachments/assets/a17aefd0-91e7-4f42-a525-a3b4a2c40c00

```
python ppo.py \
       --env_id="PickCube-v1" \
       --evaluate \
       --exp-name="PickCube-v1" \
       --num_eval_envs=1 \
       --checkpoint "/home/silenzio/lib/ManiSkill/examples/baselines/ppo/runs/PickCube-v1/final_ckpt.pt"
``` 
```
2025-08-30 21:48:34,765 - mani_skill  - WARNING - Agent openarm is already registered. Skip registration.
Saving eval videos to /home/silenzio/lib/ManiSkill/examples/baselines/ppo/runs/PickCube-v1/test_videos
2025-08-30 21:48:36,597 - mani_skill  - WARNING - mani_skill is not installed with git.
Running evaluation
####
args.num_iterations=390 args.num_envs=512 args.num_eval_envs=1
args.minibatch_size=800 args.batch_size=25600 args.update_epochs=4
####
Epoch: 1, global_step=0
Evaluating
Evaluated 50 steps resulting in 1 episodes
eval_success_once_mean=1.0
eval_return_mean=37.54619598388672
eval_episode_len_mean=50.0
eval_reward_mean=0.7509239315986633
eval_success_at_end_mean=1.0
```



https://github.com/user-attachments/assets/a77b8634-53d7-44be-bece-93998d1890a9


