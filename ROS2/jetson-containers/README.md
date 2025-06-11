

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
mkdir model_repository/models -p

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

______

### Requirements and Setup for Russian ASR:

```
./riva_stop.sh
```

```
Shutting down docker containers...
```

```
./riva_clean.sh
```
```
Cleaning up local Riva installation.
Image nvcr.io/nvidia/riva/riva-speech:2.17.0-l4t-aarch64 found. Delete? [y/N] y
Error response from daemon: get home/silenzio/lib/riva_quickstart_arm64_2.19.0/model_repository: no such volume
'/home/silenzio/lib/riva_quickstart_arm64_2.19.0/model_repository' is not a Docker volume, or has already been deleted.
Found models at '/home/silenzio/lib/riva_quickstart_arm64_2.19.0/model_repository'. Delete? [y/N] y
```

Change this line in "config.sh":
```
# Specify ASR language to deploy, as defined in "asr_models_languages_map" above
# For multiple languages, enter space separated language codes
asr_language_code=("ru-RU") ## en-US")
```

```
./riva_init.sh
```

```

Please enter API key for ngc.nvidia.com: 
Logging into NGC docker registry if necessary...
Pulling required docker images if necessary...
Note: This may take some time, depending on the speed of your Internet connection.
> Pulling Riva Speech Server images.
  > Pulling nvcr.io/nvidia/riva/riva-speech:2.19.0-l4t-aarch64. This may take some time...
--------------------------------------------------------------------------------
   Download status: COMPLETED
   Downloaded local path model: /tmp/artifacts/models_asr_conformer_ru_ru_str_v2.19.0-tegra-orin
   Total files downloaded: 1
   Total transferred: 321.99 MB
   Started at: 2025-06-02 11:42:31
   Completed at: 2025-06-02 11:43:03
   Duration taken: 31s
--------------------------------------------------------------------------------
...
```
______

```
--- a/config.sh
+++ b/config.sh
@@ -18,7 +18,7 @@ riva_tegra_platform="orin"

 # For any language other than en-US: service_enabled_nlp must be set to false
 service_enabled_asr=true
-service_enabled_nlp=true
+service_enabled_nlp=false
 service_enabled_tts=true
 service_enabled_nmt=false

@@ -57,7 +57,7 @@ asr_acoustic_model=("conformer")

 # Specify ASR language to deploy, as defined in "asr_models_languages_map" above
 # For multiple languages, enter space separated language codes
-asr_language_code=("en-US")
+asr_language_code=("es-ES")

 # Specify ASR accessory model from below list, prebuilt model available only when "asr_acoustic_model" is set to "parakeet_1.1b"
 # "diarizer" : deploy ASR model with Speaker Diarization model
diff --git a/riva_start.sh b/riva_start.sh
index 8ad07a9..0cbdb07 100644
--- a/riva_start.sh
+++ b/riva_start.sh
@@ -101,7 +101,7 @@ if [ $(docker ps -q -f "name=^/$riva_daemon_speech$" | wc -l) -eq 0 ]; then
     docker run -d \
         --init \
         --ipc=host \
-        --gpus '"'$gpus_to_use'"' \
+        --runtime=nvidia \
         -p $riva_speech_api_port:$riva_speech_api_port \
         -p $riva_speech_api_http_port:$riva_speech_api_http_port \
         -e RIVA_SERVER_HTTP_PORT=$riva_speech_api_http_port \
```

Then we test it with a default file and it can work correctly.

```
# riva_streaming_asr_client --audio_file=/opt/riva/wav/es-ES_sample.wav
I0611 05:53:26.773959  4100 grpc.h:101] Using Insecure Server Credentials
Loading eval dataset...
filename: /opt/riva/wav/es-ES_sample.wav
Done loading 1 files
in rio
in rio
in rio
and
in rio
in rio de
rio
rio
rio tigris
rio de grist
tigris
tigris
tigris
tigris
rio grist
rio
rio tenaya
rio tania
rio tigris
rio tigris on
rio tigris
rio tigris
rio tigris ten on
rio tigris ten on
Rio Tigris, ten Tipo.
-----------------------------------------------------------
File: /opt/riva/wav/es-ES_sample.wav

Final transcripts:
0 : Rio Tigris, ten Tipo.

Timestamps:
Word                                    Start (ms)      End (ms)        Confidence

Rio                                     440             680             3.3618e-02
Tigris,                                 840             1400            9.3009e-03
ten                                     1520            1680            7.9300e-02
Tipo.                                   2080            2400            7.8500e-03


Audio processed: 4.4800e+00 sec.
-----------------------------------------------------------

Not printing latency statistics because the client is run without the --simulate_realtime option and/or the number of requests sent is not equal to number of requests received. To get latency statistics, run with --simulate_realtime and set the --chunk_duration_ms to be the same as the server chunk duration
Run time: 6.9652e-01 sec.
Total audio processed: 5.9760e+00 sec.
Throughput: 8.5798e+00 RTFX
```

______


### Run Riva Speech Server:

```
cd /home/silenzio/lib/riva_quickstart_arm64_2.19.0
./riva_start.sh
```
```
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


