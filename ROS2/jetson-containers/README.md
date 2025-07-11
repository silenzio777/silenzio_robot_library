## Fresh install:

https://catalog.ngc.nvidia.com/orgs/nvidia/teams/riva/resources/riva_quickstart_arm64

https://docs.nvidia.com/deeplearning/riva/user-guide/docs/quick-start-guide/asr.html


### Downgrade Docker:
```
sudo apt-get install -y docker-ce=5:27.5* docker-ce-cli=5:27.5* --allow-downgrades
sudo systemctl restart docker
sudo usermod -aG docker $USER
newgrp docker
```

### Get ngc cli:

Download "ngccli_arm64.zip" from: https://org.ngc.nvidia.com/setup/installers/cli
Or this way:
```
wget --content-disposition https://ngc.nvidia.com/downloads/ngccli_arm64.zip && unzip ngccli_arm64.zip && chmod u+x ngc-cli/ngc
find ngc-cli/ -type f -exec md5sum {} + | LC_ALL=C sort | md5sum -c ngc-cli.md5
echo "export PATH='$PATH:$(pwd)/ngc-cli'" >> ~/.bash_profile && source ~/.bash_profile
```

## Setup ngc cli:
```
$ ngc config set
Enter API key [no-apikey]. Choices: [<VALID_APIKEY>, 'no-apikey']: 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
Enter CLI output format type [ascii]. Choices: ['ascii', 'csv', 'json']: 
Enter org [no-org]. Choices: ['hkpaft3gxabp']: 
Invalid org. Please re-enter.
Enter org [no-org]. Choices: ['hkpaft3gxabp']: hkpaft3gxabp
Enter team [no-team]. Choices: ['no-team']: no-team
Enter ace [no-ace]. Choices: ['no-ace']: no-ace
Validating configuration...
Successfully validated configuration.
Saving configuration...
Successfully saved NGC configuration to /home/silenzio/.ngc/config
```

file "/home/silenzio/.ngc/config":
```
;WARNING - This is a machine generated file.  Do not edit manually.
;WARNING - To update local config settings, see "ngc config set -h" 

[CURRENT]
apikey = nvapi-...........................................
format_type = ascii
org = .......
```

### Get riva_server:
```
$ ngc registry resource download-version nvidia/riva/riva_quickstart_arm64:2.19.0
Getting files to download...
  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ • 156.8/156.8 KiB • Remaining: 0:00:00 • 153.8 kB/s • Elapsed: 0:00:02 • Total: 24 - Completed: 24 - Failed: 0
-----------------------------------------------------------------------------------------
   Download status: COMPLETED
   Downloaded local path resource: /home/silenzio/Downloads/riva_quickstart_arm64_v2.19.0
   Total files downloaded: 24
   Total transferred: 156.83 KB
   Started at: 2025-06-12 13:30:28
   Completed at: 2025-06-12 13:30:30
   Duration taken: 2s
-----------------------------------------------------------------------------------------
```

### Install riva_server:
```
cd riva_quickstart_arm64_v2.19.0/
mkdir model_repository/models -p
```

```
$ bash riva_init.sh
Logging into NGC docker registry if necessary...
Pulling required docker images if necessary...
Note: This may take some time, depending on the speed of your Internet connection.
> Pulling Riva Speech Server images.
  > Pulling nvcr.io/nvidia/riva/riva-speech:2.19.0-l4t-aarch64. This may take some time...

Downloading models (RMIRs) from NGC...
Note: this may take some time, depending on the speed of your Internet connection.
To skip this process and use existing RMIRs set the location and corresponding flag in config.sh.
2025-06-12 10:33:07 URL:https://xfiles.ngc.nvidia.com/org/nvidia/team/ngc-apps/recipes/ngc_cli/versions/3.48.0/files/ngccli_arm64.zip?versionId=sPn0KF0IeLN_9vFxB35JiAi3I4VPz.AW&Signature=x03yX4tqGdFYQ2jh~RI10Ffho~JPuiEk8jFwdWutW3-14Cho0LYtBJFlErwHorzjh~6ds4lu7duZpxY~IQgx~qOYZWBy0g32BrmSlvjHNJOQOhsrGS7~nDxr-xISe5YlwNMVLqPEZohWw4m6fIjJwyT5tO4Tvv7jTczQc9UrsM7Broi2uwEBA-QSwLhQmrsQInnYcpQkvW3FpziZCT5coju3I85QPsiTWD9180obuiixh6C~WXd0fkfjFXUfRr~YgjtNC97A095bfxKm0z4Tsbe5VLI8fLsZ-Mf73m2zLJM24yFxNlNfdD44B68MNS0rND8KqJNl0YWkur6Nn5POvw__&Expires=1749810783&Key-Pair-Id=KCX06E8E9L60W [50007324/50007324] -> "ngccli_arm64.zip" [1]
/opt/riva

CLI_VERSION: Latest - 3.152.2 available (current: 3.48.0). Please update by using the command 'ngc version upgrade' 

Getting files to download...
  ━━ • … • Remaining: 0… • … • Elapsed: 0… • Total: 1 - Completed: 1 - Failed: 0

--------------------------------------------------------------------------------
   Download status: COMPLETED
   Downloaded local path model: /tmp/artifacts/models_asr_conformer_en_us_str_v2.19.0-tegra-orin
   Total files downloaded: 1
   Total transferred: 802.72 MB
   Started at: 2025-06-12 10:33:12
   Completed at: 2025-06-12 10:34:27
   Duration taken: 1m 14s
--------------------------------------------------------------------------------
Getting files to download...
  ━━ • … • Remaining: 0… • … • Elapsed: 0… • Total: 1 - Completed: 1 - Failed: 0

--------------------------------------------------------------------------------
   Download status: COMPLETED
   Downloaded local path model: /tmp/artifacts/models_nlp_punctuation_bert_base_en_us_v2.19.0-tegra-orin
   Total files downloaded: 1
   Total transferred: 191.71 MB
   Started at: 2025-06-12 10:36:33
   Completed at: 2025-06-12 10:36:51
   Duration taken: 18s
--------------------------------------------------------------------------------
Getting files to download...
  ━━ • … • Remaining: 0… • … • Elapsed: 0… • Total: 1 - Completed: 1 - Failed: 0
--------------------------------------------------------------------------------
   Download status: COMPLETED
   Downloaded local path model: /tmp/artifacts/models_nlp_punctuation_bert_base_en_us_v2.19.0-tegra-orin
   Total files downloaded: 1
   Total transferred: 191.71 MB
   Started at: 2025-06-12 10:38:58
   Completed at: 2025-06-12 10:39:17
   Duration taken: 18s
--------------------------------------------------------------------------------
Getting files to download...
⠸ ━╸ • … • Remaining: 0… • … • Elapsed: 0… • Total: 1 - Completed: 0 - Failed: 0

--------------------------------------------------------------------------------
   Download status: COMPLETED
   Downloaded local path model: /tmp/artifacts/models_tts_fastpitch_hifigan_en_us_ipa_v2.19.0-tegra-orin
   Total files downloaded: 1
   Total transferred: 187.44 MB
   Started at: 2025-06-12 10:39:20
   Completed at: 2025-06-12 10:39:38
   Duration taken: 17s
--------------------------------------------------------------------------------

+ [[ tegra != \t\e\g\r\a ]]
+ [[ tegra == \t\e\g\r\a ]]
+ '[' -d /home/silenzio/Downloads/riva_quickstart_arm64_v2.19.0/model_repository/rmir ']'
+ [[ tegra == \t\e\g\r\a ]]
+ '[' -d /home/silenzio/Downloads/riva_quickstart_arm64_v2.19.0/model_repository/prebuilt ']'
+ echo 'Converting prebuilts at /home/silenzio/Downloads/riva_quickstart_arm64_v2.19.0/model_repository/prebuilt to Riva Model repository.'
Converting prebuilts at /home/silenzio/Downloads/riva_quickstart_arm64_v2.19.0/model_repository/prebuilt to Riva Model repository.
+ docker run -it -d --rm -v /home/silenzio/Downloads/riva_quickstart_arm64_v2.19.0/model_repository:/data --name riva-models-extract nvcr.io/nvidia/riva/riva-speech:2.19.0-l4t-aarch64
+ docker exec riva-models-extract bash -c 'mkdir -p /data/models; \
      for file in /data/prebuilt/*.tar.gz; do tar xf $file -C /data/models/ &> /dev/null; done'
+ docker container stop riva-models-extract
+ '[' 0 -ne 0 ']'
+ echo

+ echo 'Riva initialization complete. Run ./riva_start.sh to launch services.'
Riva initialization complete. Run ./riva_start.sh to launch services.
```

### Run Riva Speech Services test (English languges):
```
./riva_start.sh
Starting Riva Speech Services. This may take several minutes depending on the number of models deployed.
Waiting for Riva server to load all models...retrying in 10 seconds
Riva server is ready...
Use this container terminal to run applications:

root@d418cb8c06c2:/opt/riva# riva_streaming_asr_client --audio_file=/opt/riva/wav/en-US_sample.wav
I0612 10:55:32.405516   311 grpc.h:101] Using Insecure Server Credentials
Loading eval dataset...
filename: /opt/riva/wav/en-US_sample.wav
Done loading 1 files
what
what
what is
what is
what is
what is now tilde
what is natural
what is natural
what is natural
what is natural language
what is natural language
what is natural language
what is natural language processing
what is natural language processing
what is natural language processing
what is natural language processing
what is natural language processing
what is tural language processing
what is language processing
What is natural language processing? 
-----------------------------------------------------------
File: /opt/riva/wav/en-US_sample.wav

Final transcripts: 
0 : What is natural language processing? 

Timestamps: 
Word                                    Start (ms)      End (ms)        Confidence      

What                                    920             960             1.9195e-01      
is                                      1200            1240            5.4835e-01      
natural                                 1720            2080            1.0869e-01      
language                                2240            2600            6.7237e-01      
processing?                             2720            3200            1.0000e+00      

Audio processed: 4.0000e+00 sec.
-----------------------------------------------------------

Not printing latency statistics because the client is run without the --simulate_realtime option and/or the number of requests sent is not equal to number of requests received. To get latency statistics, run with --simulate_realtime and set the --chunk_duration_ms to be the same as the server chunk duration
Run time: 7.3754e-01 sec.
Total audio processed: 4.1520e+00 sec.
Throughput: 5.6295e+00 RTFX
root@d418cb8c06c2:/opt/riva# 
```
### Works!

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
### Works!

________

### Install Russian language:

Shutting down docker containers...
```
./riva_stop.sh
```

Check docker: 
```
$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```

### Clean riva_server:
```
$ ./riva_clean.sh
Cleaning up local Riva installation.
Image nvcr.io/nvidia/riva/riva-speech:2.19.0-l4t-aarch64 found. Delete? [y/N] y
Error response from daemon: get home/silenzio/lib/riva_quickstart_arm64_v2.19.0/model_repository: no such volume
'/home/silenzio/lib/riva_quickstart_arm64_v2.19.0/model_repository' is not a Docker volume, or has already been deleted.
Found models at '/home/silenzio/lib/riva_quickstart_arm64_v2.19.0/model_repository'. Delete? [y/N] y
[sudo] password for silenzio: 
```

Change this line in "config.sh":
```
# Specify ASR language to deploy, as defined in "asr_models_languages_map" above
# For multiple languages, enter space separated language codes
asr_language_code=("ru-RU") ## en-US")
```

Make this changes:
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


### Install riva_server again:
```
cd riva_quickstart_arm64_v2.19.0/
mkdir model_repository/models -p
```

```
silenzio@jetsonnx:~/lib/riva_quickstart_arm64_v2.19.0$ bash riva_init.sh
Logging into NGC docker registry if necessary...
Pulling required docker images if necessary...
Note: This may take some time, depending on the speed of your Internet connection.
> Pulling Riva Speech Server images.
  > Image nvcr.io/nvidia/riva/riva-speech:2.19.0-l4t-aarch64 exists. Skipping.

Downloading models (RMIRs) from NGC...
Note: this may take some time, depending on the speed of your Internet connection.
To skip this process and use existing RMIRs set the location and corresponding flag in config.sh.
2025-06-12 11:35:14 URL:https://xfiles.ngc.nvidia.com/org/nvidia/team/ngc-apps/recipes/ngc_cli/versions/3.48.0/files/ngccli_arm64.zip?versionId=sPn0KF0IeLN_9vFxB35JiAi3I4VPz.AW&Signature=YzTxhtOw8~jn0A9SBS-1~xvW2UOxqq0On~llJdKwIZQJvyDl7gdWJ1MLZHqFnwDzX69UWB3imS1X0pT56LrmCoISCZhqAY4TU7rRfrGWYOkXwW9Fp5~vowhouLzwiJWwKHFMxrtAvjvkCQXMgKs5TlMa7PQNEb7Wl1AYUE5Oq3FAxNWHPv9KQ9e41AauTSxJ8YiQSdxPXM3f7G-pAOlKtmozWAH~kLz67vzi2I15EFf-rEVtex2-pb5lnxaKFQUgLM-3cPp1groRbnSDuBpBOc1wSnhrhZj3XFwde4XZrDY3Gk662NWXQo~pdxGQ2JKu~ROgFhyxprPmqcB2SSjB7g__&Expires=1749814510&Key-Pair-Id=KCX06E8E9L60W [50007324/50007324] -> "ngccli_arm64.zip" [1]
/opt/riva

CLI_VERSION: Latest - 3.152.2 available (current: 3.48.0). Please update by using the command 'ngc version upgrade' 

Getting files to download...
  ━━ • … • Remaining: 0… • … • Elapsed: 0… • Total: 1 - Completed: 1 - Failed: 0
       …                   …                                                    
--------------------------------------------------------------------------------
   Download status: COMPLETED
   Downloaded local path model: /tmp/artifacts/models_asr_conformer_ru_ru_str_v2.19.0-tegra-orin
   Total files downloaded: 1
   Total transferred: 321.99 MB
   Started at: 2025-06-12 11:35:20
   Completed at: 2025-06-12 11:35:52
   Duration taken: 31s
--------------------------------------------------------------------------------
Getting files to download...
  ━━ • … • Remaining: 0… • … • Elapsed: 0… • Total: 1 - Completed: 1 - Failed: 0
       …                   …                                                    

--------------------------------------------------------------------------------
   Download status: COMPLETED
   Downloaded local path model: /tmp/artifacts/models_nlp_punctuation_bert_base_ru_ru_v2.19.0-tegra-orin
   Total files downloaded: 1
   Total transferred: 311.31 MB
   Started at: 2025-06-12 11:35:55
   Completed at: 2025-06-12 11:36:26
   Duration taken: 31s
--------------------------------------------------------------------------------
Getting files to download...
  ━━ • … • Remaining: 0… • … • Elapsed: 0… • Total: 1 - Completed: 1 - Failed: 0
       …                   …                                                    
--------------------------------------------------------------------------------
   Download status: COMPLETED
   Downloaded local path model: /tmp/artifacts/models_tts_fastpitch_hifigan_en_us_ipa_v2.19.0-tegra-orin
   Total files downloaded: 1
   Total transferred: 187.44 MB
   Started at: 2025-06-12 11:36:29
   Completed at: 2025-06-12 11:36:47
   Duration taken: 18s
--------------------------------------------------------------------------------

+ [[ tegra != \t\e\g\r\a ]]
+ [[ tegra == \t\e\g\r\a ]]
+ '[' -d /home/silenzio/lib/riva_quickstart_arm64_v2.19.0/model_repository/rmir ']'
+ [[ tegra == \t\e\g\r\a ]]
+ '[' -d /home/silenzio/lib/riva_quickstart_arm64_v2.19.0/model_repository/prebuilt ']'
+ echo 'Converting prebuilts at /home/silenzio/lib/riva_quickstart_arm64_v2.19.0/model_repository/prebuilt to Riva Model repository.'
Converting prebuilts at /home/silenzio/lib/riva_quickstart_arm64_v2.19.0/model_repository/prebuilt to Riva Model repository.
+ docker run -it -d --rm -v /home/silenzio/lib/riva_quickstart_arm64_v2.19.0/model_repository:/data --name riva-models-extract nvcr.io/nvidia/riva/riva-speech:2.19.0-l4t-aarch64
+ docker exec riva-models-extract bash -c 'mkdir -p /data/models; \
      for file in /data/prebuilt/*.tar.gz; do tar xf $file -C /data/models/ &> /dev/null; done'
+ docker container stop riva-models-extract
+ '[' 0 -ne 0 ']'
+ echo

+ echo 'Riva initialization complete. Run ./riva_start.sh to launch services.'
Riva initialization complete. Run ./riva_start.sh to launch services.
```

While "riva_init.sh" working:
```
$ docker ps
CONTAINER ID   IMAGE                                                COMMAND   CREATED          STATUS          PORTS     NAMES
e39ed9a5e764   nvcr.io/nvidia/riva/riva-speech:2.19.0-l4t-aarch64   "bash"    21 seconds ago   Up 20 seconds             riva-models-download
```

```
./riva_start.sh
```
```
$ docker ps
CONTAINER ID   IMAGE                                                COMMAND                  CREATED         STATUS         PORTS                                                                                                                                                                                                   NAMES
23762f9e9ad8   nvcr.io/nvidia/riva/riva-speech:2.19.0-l4t-aarch64   "start-riva --riva-u…"   9 seconds ago   Up 7 seconds   0.0.0.0:8000-8002->8000-8002/tcp, :::8000-8002->8000-8002/tcp, 0.0.0.0:8888->8888/tcp, :::8888->8888/tcp, 0.0.0.0:50000->50000/tcp, :::50000->50000/tcp, 0.0.0.0:50051->50051/tcp, :::50051->50051/tcp   riva-speech
```

```
$ ./riva_start.sh
Starting Riva Speech Services. This may take several minutes depending on the number of models deployed.
Waiting for Riva server to load all models...retrying in 10 seconds
Riva server is ready...
Use this container terminal to run applications:
root@8a7d9f1b1acf:/opt/riva# 
```

es-ES:
```
root@649ce50514e8:/opt/riva# riva_streaming_asr_client --audio_file=/opt/riva/wav/es-ES_sample.wav
I0612 13:14:02.002132  7733 grpc.h:101] Using Insecure Server Credentials
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
Rio tigris ten tipo 
-----------------------------------------------------------
File: /opt/riva/wav/es-ES_sample.wav

Final transcripts: 
0 : Rio tigris ten tipo 

Timestamps: 
Word                                    Start (ms)      End (ms)        Confidence      

Rio                                     440             680             3.3618e-02      
tigris                                  840             1400            9.3009e-03      
ten                                     1520            1680            7.9300e-02      
tipo                                    2080            2400            7.8500e-03      


Audio processed: 4.4800e+00 sec.
-----------------------------------------------------------

Not printing latency statistics because the client is run without the --simulate_realtime option and/or the number of requests sent is not equal to number of requests received. To get latency statistics, run with --simulate_realtime and set the --chunk_duration_ms to be the same as the server chunk duration
Run time: 7.9993e-01 sec.
Total audio processed: 5.9760e+00 sec.
Throughput: 7.4706e+00 RTFX
```
### Works!

ru-RU:
```
root@649ce50514e8:/opt/riva# riva_streaming_asr_client --audio_file=/opt/riva/wav/ru-RU_sample.wav
I0612 13:13:45.072036  7693 grpc.h:101] Using Insecure Server Credentials
Loading eval dataset...
filename: /opt/riva/wav/ru-RU_sample.wav
Done loading 1 files
you give it
you give it
the
the
the prefs use
the
the
the
The 
-----------------------------------------------------------
File: /opt/riva/wav/ru-RU_sample.wav

Final transcripts: 
0 : The 

Timestamps: 
Word                                    Start (ms)      End (ms)        Confidence      

The                                     2160            2200            8.2716e-02      
Audio processed: 3.8400e+00 sec.
-----------------------------------------------------------
Not printing latency statistics because the client is run without the --simulate_realtime option and/or the number of requests sent is not equal to number of requests received. To get latency statistics, run with --simulate_realtime and set the --chunk_duration_ms to be the same as the server chunk duration
Run time: 9.6225e-01 sec.
Total audio processed: 7.6320e+00 sec.
Throughput: 7.9314e+00 RTFX
```
### Not works!



_______


______

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


