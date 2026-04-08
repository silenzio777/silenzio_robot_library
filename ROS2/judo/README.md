# Judo: a hackable sampling-based MPC toolbox

https://github.com/bdaiinstitute/judo?tab=readme-ov-file





# Quickstart
This section walks you through the installation and usage of `judo`. For more details, see [the docs](https://bdaiinstitute.github.io/judo).

## 1. Installation
### Using `pip`
We recommend installing `judo` using `pip` as follows:
```bash
### pip install judo-rai  # if you want dev dependencies, use judo-rai[dev]
```

### Using `pixi`
We use [`pixi`](https://pixi.sh/) for reproducible environments via a lock file.

To install `pixi`, run the following:
```bash
curl -fsSL https://pixi.sh/install.sh | sh
```

There are two main environments:
- **`default`** — for users who just want to run `judo`.
- **`dev`** — adds testing, linting, type checking, and wheel-building tools (pytest, ruff, pyright, etc.).

To activate an environment, run the following in the repo root:
```bash
### pixi shell           # default env
```

### fix pybind11:
```
unset PYTHONPATH
unset LD_LIBRARY_PATH
(judo-rai:dev) silenzio@ubuntuPC:~/lib/judo$ python3 -m ensurepip --upgrade
python3 -m pip install pybind11==2.13.6
```

```
(judo-rai:dev) silenzio@ubuntuPC:~/lib/judo$ python3 -c "import pybind11; print(f'pybind11: {pybind11.__version__}')"
pybind11: 2.13.6
```

First-time setup for developers:
```bash
pixi shell -e dev
pre-commit install
pybind11-stubgen mujoco -o typings/
```

#### Building `mujoco_extensions` (required for Spot tasks)
Spot locomotion tasks use a C++ pybind11 module for threaded policy rollout with ONNX inference. From within the pixi shell:
```bash
pixi run build
```
To clean and rebuild from scratch:
```bash
pixi run clean
pixi run build
```

## 2. Run the `judo` app!
To start the simulator, from within the pixi shell, you can simply run:
```bash
judo
```
Or without activating the shell:
```bash
pixi run judo
```
This will start the stack and print a link in the terminal that will open the app in your browser, e.g.,
```
http://localhost:8080
```

### works:

![spot](https://github.com/user-attachments/assets/cdb821fc-a257-435c-95e7-36393c9333b1)

