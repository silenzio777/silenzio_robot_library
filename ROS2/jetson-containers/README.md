

### Isntall Riva Speech Server (embedded device arm64):

https://catalog.ngc.nvidia.com/orgs/nvidia/teams/riva/resources/riva_quickstart_arm64

```
sudo apt-get install -y docker-ce=5:27.5* docker-ce-cli=5:27.5* --allow-downgrades

sudo systemctl restart docker
sudo usermod -aG docker $USER
newgrp docker
wget --content-disposition https://ngc.nvidia.com/downloads/ngccli_arm64.zip && unzip ngccli_arm64.zip && chmod u+x ngc-cli/ngc
find ngc-cli/ -type f -exec md5sum {} + | LC_ALL=C sort | md5sum -c ngc-cli.md5
echo "export PATH='$PATH:$(pwd)/ngc-cli'" >> ~/.bash_profile && source ~/.bash_profile

ngc config set

ngc registry resource download-version nvidia/riva/riva_quickstart_arm64:2.19.0

cd riva_quickstart_arm64_v2.19.0/
```
```
nano config.sh
```

Change this line:
```
service_enabled_asr=true
service_enabled_nlp=false #true
service_enabled_tts=true
service_enabled_nmt=false
```

```
mkdir model_repository/models

sudo bash riva_init.sh
(ok)
```

From riva_start.sh 

delete line
```
–gpus ‘"’$gpus_to_use’"’
```

Add line:
```
–runtime=nvidia
```

### Run Riva Speech Server:

```
cd /home/silenzio/lib/riva_quickstart_arm64_2.19.0
./riva_start.sh
Starting Riva Speech Services. This may take several minutes depending on the number of models deployed.
Error response from daemon: No such container: riva-speech
Error response from daemon: No such container: riva-speech
Waiting for Riva server to load all models...retrying in 10 seconds
aafe5d94da02669d4fe5ca73f0a0af42afc2607735cebef668ed5f7114e6ed6a
timeout: failed to connect service ":50051" within 1s
Waiting for Riva server to load all models...retrying in 10 seconds
status: SERVING
Riva server is ready...
Use this container terminal to run applications:
root@aafe5d94da02:/opt/riva#
```
## Works!


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
