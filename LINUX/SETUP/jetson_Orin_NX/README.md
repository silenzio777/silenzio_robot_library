
### System Torch and Torchvision with GPU

- Python 3.10.12
- Torch 2.5.0
- Torchvision 0.20.0
- 
```
silenzio@jetsonnx:~/ros2_ws$ python3
Python 3.10.12 (main, Feb  4 2025, 14:57:36) [GCC 11.4.0] on linux
Type "help", "copyright", "credits" or "license" for more information.

>>> import torch
>>> torch.__version__
'2.5.0'

>>> import torch; torch.cuda.is_available();torch.__version__
True
'2.5.0'

>>> import torchvision
>>> torchvision.__version__
'0.20.0'

>>> import torch;print(torch.nn.Conv2d(3, 3, 3).cuda()(torch.rand(1, 3, 6, 6, device='cuda')))
tensor([[[[-0.2334, -0.6982, -0.1686, -0.2675],
          [ 0.0341, -0.3815, -0.1165, -0.4988],
          [-0.5830, -0.5142, -0.1634, -0.2711],
          [-0.3779, -0.4587, -0.6050, -0.5246]],

         [[-0.2511, -0.0953, -0.0170,  0.2646],
          [ 0.0647,  0.0885, -0.3690, -0.0735],
          [-0.3264,  0.0349,  0.6344, -0.1592],
          [ 0.2325, -0.0402, -0.2069,  0.1589]],

         [[-0.7323, -0.3493, -0.8753, -0.5273],
          [-1.0189, -0.5098, -0.5717, -0.1466],
          [-0.7291, -0.8060, -0.5223, -0.6727],
          [-0.7895, -0.7066, -0.8492, -0.5166]]]], device='cuda:0',
       grad_fn=<ConvolutionBackward0>)

```
