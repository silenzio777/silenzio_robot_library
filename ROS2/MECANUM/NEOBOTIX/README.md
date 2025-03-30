### Neobotix neo_mpo_500-2

### neo_kinematics_mecanum2

https://neobotix-docs.de/ros/packages/neo_kinematics_mecanum2.html#neo-kinematics-mecanum

### Install:

```
git clone -b humble https://github.com/neobotix/neo_mpo_500-2
```

```
git clone -b humble https://github.com/neobotix/neo_kinematics_mecanum2

neo_sick_s300-2
neo_teleop2
neo_kinematics_mecanum2
neo_relayboard_v2-2
neo_srvs2
neo_msgs2
```

### Lounch:
```
ros2 launch neo_mpo_500-2 rviz.launch.py

ros2 launch neo_mpo_500-2 bringup.launch.py

ros2 launch neo_mpo_500-2 mapping.launch.py

ros2 launch neo_mpo_500-2 navigation.launch.py

.... "package 'neo_nav2_bringup' not found,
```
