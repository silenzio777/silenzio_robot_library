# Docker commands:
> [!TIP]
> Useful info about NVIDIA Containers: [The NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/1.13.5/install-guide.html)

Build options[Docker build](build-options)

________
## Install:
```
curl https://get.docker.com | sh && sudo systemctl --now enable docker
```
```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

sudo apt-get update

sudo apt-get install -y nvidia-container-toolkit

sudo nvidia-ctk runtime configure --runtime=docker

sudo systemctl restart docker
```
________
## Test run:

```
docker
```

```
Usage: docker [OPTIONS] COMMAND

>A self-sufficient runtime for containers
...
Run 'docker COMMAND --help' for more information on a command.
For more help on how to use Docker, head to https://docs.docker.com/go/guides/
```

```
docker run hello-world
```

```
Hello from Docker! This message shows that your installation appears to be working correctly.
To generate this message, Docker took the following steps:
The Docker client contacted the Docker daemon.
The Docker daemon pulled the "hello-world" image from the Docker Hub. (arm64v8)
The Docker daemon created a new container from that image which runs the executable that produces the output you are currently reading.
The Docker daemon streamed that output to the Docker client, which sent it to your terminal.
To try something more ambitious, you can run an Ubuntu container with: $ docker run -it ubuntu bash
Share images, automate workflows, and more with a free Docker ID: https://hub.docker.com/
For more examples and ideas, visit: https://docs.docker.com/get-started/
```
________
## To run docker command without sudo:

```
sudo usermod -aG docker $USER
```
```
docker info
```

```
Client: Docker Engine - Community 
Version: 27.5.1 
Context: default 
Debug Mode: false 
Plugins: buildx: 
Docker Buildx (Docker Inc.)
Version: v0.20.0 
Path: /usr/libexec/docker/cli-plugins/docker-buildx compose: 
Docker Compose (Docker Inc.) 
Version: v2.32.4 
Path: /usr/libexec/docker/cli-plugins/docker-compose
...
Storage Driver: overlay2 <<<<<<<<<--------------- 
```
________
## To delete all containers including its volumes use:

```
docker rm -vf $(docker ps -aq)
```
________
## To delete all the images:

```
docker rmi -f $(docker images -aq)
```

> [!NOTE]
> Remember, you should remove all the containers before removing all the images from which those containers were created.

________
## Use this to delete everything:

```
docker system prune -a --volumes
```
Remove all unused containers, volumes, networks and images

> [!NOTE]
> WARNING! This will remove: - all stopped containers - all networks not used by at least one container - all volumes not used by at least one container - all images without at least one container associated to them - all build cache

________
## Docker info:

```
docker ps -a
```
```
CONTAINER ID    IMAGE                COMMAND             CREATED          STATUS PORTS NAMES 

b976c1814c68      silenzio/catnip  "python ./app.py"   2 minutes ago   Exited (0) 2 minutes ago thirsty_heyrovsky 
0c05bc37557c     busybox               "sh"                           23 minutes ago Exited (0) 23 minutes ago gracious_curie
```
________
## Show all docker containers size:
```
docker system df
```
```
TYPE TOTAL ACTIVE SIZE RECLAIMABLE 
Images 15 4 49.17GB 48.15GB (97%) 
Containers 25 0 77.24MB 77.24MB (100%) 
Local Volumes 4 2 0B 0B 
Build Cache 152 0 6.401GB 6.401GB
```
________
## To delete the docker build cache:

```
docker builder prune
```

Stop all docker containers:
```
docker stop $(docker ps -aq)
```

Agressive delete all docker containers:
```
docker system prune -a --volumes -f
```

```
$ docker system prune -a --volumes -f
Deleted Containers:
e2c6c152db57f0d6420c8fa7e97733749b74eb8f0d70e895d2b3cd94cb92de83
...
Deleted build cache objects:
t8y3xs4ah4ol2zdgiuaue8rrv
...
sml0zl2v8zk5fjiw9afzge35i
lt6n09shuco7ba0s01kuvqiiw

Total reclaimed space: 33.39GB
```

Clear logs:
```
sudo find /var/lib/docker/containers/ -name '*.log' -exec truncate -s 0 {} \;
```

> [!NOTE]
> WARNING! This will remove all dangling build cache. Are you sure you want to continue? [y/N] y 

```
ID RECLAIMABLE SIZE LAST ACCESSED
ttowt55v1kq810zkz3c38w5tb* true 2.906kB 2 minutes ago 
0dnlduc808vp3ip0gk5qgidzi* true 0B 26 minutes ago 
2rlhmboafodljum1ja0asjhwp* true 0B 21 hours ago
```
```
docker images
```

```
REPOSITORY          TAG            IMAGE ID           CREATED           SIZE 
silenzio/catnip         latest        3a93d1d71772    3 minutes ago   1.01GB 
```
________
## If you have a case of redundant tags as described here use: 

```
docker rmi <repo:tag>
```

### instead of:

```
docker rmi <image_id>
```
________

```
docker info | grep Root
```
```
Docker Root Dir: /var/lib/docker
```

```
sudo ls -l /var/lib/docker/
```
```
total 80

drwx--x--x 5 root root 4096 Feb 16 15:33 buildkit 
drwx--x--- 27 root root 4096 Feb 23 12:17 containers 
-rw------- 1 root root 36 Feb 16 13:47 engine-id 
drwx------ 3 root root 4096 Feb 16 13:47 image
drwxr-x--- 3 root root 4096 Feb 16 13:47 network 
drwx--x--- 395 root root 36864 Feb 23 12:34 overlay2
drwx------ 3 root root 4096 Feb 16 13:47 plugins 
drwx------ 2 root root 4096 Feb 22 20:03 runtimes 
drwx------ 2 root root 4096 Feb 16 13:47 swarm 
drwx------ 3 root root 4096 Feb 23 12:43 tmp 
drwx-----x 6 root root 4096 Feb 22 20:03 volumes
```
________
## Get size of all docker container:
```
sudo du -chs /var/lib/docker/
```
```
69G /var/lib/docker/ 
69G total
```
________
## Info:
```
docker info | grep -e "Runtime" -e "Root"
```
```
Runtimes: io.containerd.runc.v2 nvidia runc 
Default Runtime: runc 
Docker Root Dir: /var/lib/docker
```
________
## Build options:

That’s because the output is not on the standard output but the standard error stream. So you can try this to redirect everything into the file:

docker build --no-cache --progress=plain  . &> build.log
or just redirect standard error if you think there should be some other output to show in the terminal

docker build --no-cache --progress=plain  . 2> build.log
Or you can use tee to show the logs and also save it to a file

docker build --no-cache --progress=plain . 2>&1 | tee build.log
If you want to append new logs and not to overwrite on every build, use >> for the redirection as you did originally. If you choose the version with tee, you can use tee -a to append the new logs


__________

### Перенос данных Docker на SSD (опционально)
Если нужно переместить все данные Docker (образы, контейнеры, тома):

Остановите Docker:
```
sudo systemctl stop docker
```

Перенесите данные:
```
sudo rsync -av /var/lib/docker/ /mnt/SSD_BACKUP_512/docker
```

Укажите Docker новый путь к данным:
Создайте конфигурационный файл:

```
sudo nano /etc/docker/daemon.json
```

Добавьте:
```
{
  "data-root": "/mnt/SSD_BACKUP_512/docker"
}
```

```
cat /etc/docker/daemon.json
```
```
{
    "runtimes": {
        "nvidia": {
            "args": [],
            "path": "nvidia-container-runtime"
        }
    },
    "data-root": "/mnt/SSD_BACKUP_512/docker"
}
```

Перезапустите Docker:
```
sudo systemctl start docker
```

Check:
```
docker info | grep "Docker Root Dir"
```

> Docker Root Dir: /mnt/SSD_BACKUP_512/docker

____

### Как безопасно удалить локальную копию:

1. Переименуем старую папку (на случай отката)
```
sudo mv /var/lib/docker /var/lib/docker.old
```

2. Проверяем работу Docker в течение 1-2 дней
```
docker run --rm hello-world
docker images
docker ps -a
```

3. Если всё стабильно - удаляем резервную копию
```
sudo rm -rf /var/lib/docker.old
```

____

### Start/stop docker containers

```
sudo systemctl stop docker containerd
```
```
sudo systemctl start docker containerd
```
```
sudo systemctl status docker containerd
```
```
sudo systemctl restart docker
```

