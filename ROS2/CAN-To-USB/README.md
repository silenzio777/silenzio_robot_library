

- source: https://github.com/westonrobot/wrp_ros2

## Setup CAN-To-USB adapter
**Only needed if you are using a CAN robot or peripheral**
 
1. Enable gs_usb kernel module
    ```
    $ sudo modprobe gs_usb
    ```
2. Bringup can device

    **NOTE**: Adjust CAN bitrate accordingly. Refer to the tables in the [mobile_base README](./wrp_sdk_robot/README.md) and [peripheral README](./wrp_sdk_periph/README.md) for the correct bitrate.
   ```
   $ sudo ip link set can0 up type can bitrate <bitrate>
   $ sudo ip link set can0 txqueuelen 1000
   ```
3. If no error occured during the previous steps, you should be able to see the can device now by using command
   ```
   $ ifconfig -a
   ```
4. Install and use can-utils to test the hardware
    ```
    $ sudo apt install can-utils
    ```
5. Testing command
    ```
    # receiving data from can0
    $ candump can0
    # send data to can0
    $ cansend can0 001#1122334455667788
    ```

Scripts are provided [here](./scripts) for convenience. You can run "./setup_can2usb.bash" for the first-time setup and run "./bringup_can2usb_1m.bash" to bring up the device each time you unplug and re-plug the adapter.
