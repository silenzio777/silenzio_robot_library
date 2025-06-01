


https://catalog.ngc.nvidia.com/orgs/nvidia/teams/riva/resources/riva_quickstart_arm64

###ngc registry resource download-version "nvidia/riva/riva_quickstart_arm64:2.19.0"

./ngc registry resource download-version nvidia/riva/riva_quickstart_arm64:2.3.0





### Run Riva Speech Server:
```
cd /home/silenzio/lib/riva_quickstart_arm64_2.19.0
```
____

```
./riva_init.sh
```

```
Please enter API key for ngc.nvidia.com: 
Logging into NGC docker registry if necessary...
Pulling required docker images if necessary...
Note: This may take some time, depending on the speed of your Internet connection.
> Pulling Riva Speech Server images.
  > Image nvcr.io/nvidia/riva/riva-speech:2.19.0-l4t-aarch64 exists. Skipping.
Downloading models (RMIRs) from NGC...
...
+ echo 'Riva initialization complete. Run ./riva_start.sh to launch services.'
Riva initialization complete. Run ./riva_start.sh to launch services.

```

____

```
./riva_start.sh
```
```
Starting Riva Speech Services. This may take several minutes depending on the number of models deployed.
Waiting for Riva server to load all models...retrying in 10 seconds
Waiting for Riva server to load all models...retrying in 10 seconds
...
```
### Errors...


docker run -ti nvcr.io/nvidia/riva/riva-speech:2.19.0-l4t-aarch64


_______
### Run nano_llm:
```
jetson-containers run $(autotag nano_llm)
```
```
jetson-containers run $(autotag nano_llm) \
  python3 -m nano_llm.agents.web_chat --api=mlc \
    --model Efficient-Large-Model/VILA-7b \
    --asr=riva --tts=piper
```
