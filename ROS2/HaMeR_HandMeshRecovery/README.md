https://github.com/geopavlakos/hamer/tree/main

## HaMeR: Hand Mesh Recovery

https://github.com/geopavlakos/hamer/blob/main/assets/teaser.jpg

Code repository for the paper: Reconstructing Hands in 3D with Transformers

### Installation

First you need to clone the repo:
```
git clone --recursive https://github.com/geopavlakos/hamer.git
cd hamer
```

We recommend creating a virtual environment for HaMeR. You can use venv:
```
python3.10 -m venv .hamer
source .hamer/bin/activate
```

Then, you can install the rest of the dependencies. This is for CUDA 11.7, but you can adapt accordingly:
```
pip3 install torch torchvision --index-url https://download.pytorch.org/whl/cu117
```
```
pip3 install -e .[all]
```
```
pip3 install -v -e third-party/ViTPose
```
