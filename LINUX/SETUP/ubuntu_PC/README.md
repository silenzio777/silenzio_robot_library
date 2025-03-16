```
nano ~/.bashrc
```

```
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!

__conda_setup="$('/home/silenzio/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/silenzio/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/silenzio/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/silenzio/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
```

```
source ~/.bashrc
```

```
(base) silenzio@ubuntuPC:~$ conda activate pt
```

```
(pt) silenzio@ubuntuPC:~$ pip3 show torch
Name: torch
Version: 1.10.1+cu111
Summary: Tensors and Dynamic neural networks in Python with strong GPU acceleration
Home-page: https://pytorch.org/
Author: PyTorch Team
Author-email: packages@pytorch.org
License: BSD-3
Location: /home/silenzio/miniconda3/envs/pt/lib/python3.6/site-packages
Requires: typing-extensions, dataclasses
Required-by: torchvision, torchaudio
---
(pt) silenzio@ubuntuPC:~$ pip3 show torchvision
Name: torchvision
Version: 0.11.2+cu111
Summary: image and video datasets and models for torch deep learning
Home-page: https://github.com/pytorch/vision
Author: PyTorch Core Team
Author-email: soumith@pytorch.org
License: BSD
Location: /home/silenzio/miniconda3/envs/pt/lib/python3.6/site-packages
Requires: numpy, pillow, torch
Required-by: 
```
```
(pt) silenzio@ubuntuPC:~$ python3
Python 3.6.13 |Anaconda, Inc.| (default, Jun  4 2021, 14:25:59) 
[GCC 7.5.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
```
```
>>> import torch
>>> import torch; torch.cuda.is_available();torch.__version__
True
'1.10.1+cu111'
>>> import torchvision;torchvision.__version__
'0.11.2+cu111'
>>> import torch;print(torch.nn.Conv2d(3, 3, 3).cuda()(torch.rand(1, 3, 6, 6, device='cuda')))
tensor([[[[-0.1617, -0.2088, -0.1004, -0.1646],
          [-0.2828, -0.1115,  0.0105, -0.0419],
          [-0.0576, -0.2302, -0.1868, -0.4420],
          [-0.2701, -0.3303, -0.1618, -0.1709]],

         [[-0.1428, -0.1416, -0.3596, -0.1518],
          [-0.0637,  0.2389, -0.3343, -0.0137],
          [ 0.0023,  0.0447,  0.0640,  0.0520],
          [ 0.1127, -0.2811, -0.1451, -0.0514]],

         [[-0.1702, -0.1214, -0.1733, -0.2559],
          [-0.3840, -0.1761, -0.1356,  0.1061],
          [-0.2147,  0.0781, -0.3182, -0.2179],
          [-0.1958, -0.2622, -0.0784, -0.0208]]]], device='cuda:0',
       grad_fn=<AddBackward0>)
>>> 

```
