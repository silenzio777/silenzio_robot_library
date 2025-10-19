### SYS
```
python3
>>> import torch
>>> torch.__version__
'2.5.1+cu124'
```

### HAM
```
(.hamer) silenzio@ubuntuPC:~/lib/hamer$ python3
Python 3.10.12 (main, Aug 15 2025, 14:32:43) [GCC 11.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import torch
>>> torch.__version__
'2.0.1+cu117'
``` 





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

### Fix in '/home/silenzio/lib/hamer/setup.py' file, conmment two lines:
```
        'smplx==0.1.28',
        #'torch',
        #'torchvision',
        'yacs',
```
And then%

```
pip3 install -e .[all]
```
```
pip3 install -v -e third-party/ViTPose
```

You also need to download the trained models:
```
bash fetch_demo_data.sh
```

Besides these files, you also need to download the MANO model. Please visit the MANO website and register to get access to the downloads section. We only require the right hand model. You need to put 

- MANO_RIGHT.pkl 

under the 
```
_DATA/data/mano folder.
```


### Demo

```
python demo.py \
    --img_folder example_data --out_folder demo_out \
    --batch_size=48 --side_view --save_mesh --full_frame
```
