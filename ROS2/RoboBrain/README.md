
# RoboBrain

https://github.com/FlagOpen/RoboBrain

__

⭐️ Inference

### 1. Usage for Planning Prediction

Option 1: HF inference

```python
from inference import SimpleInference

model_id = "BAAI/RoboBrain"
model = SimpleInference(model_id)

prompt = "Given the obiects in the image, if you are required to complete the task \"Put the apple in the basket\", what is your detailed plan? Write your plan and explain it in detail, using the following format: Step_1: xxx\nStep_2: xxx\n ...\nStep_n: xxx\n"

image = "./assets/demo/planning.png"

pred = model.inference(prompt, image, do_sample=True)
print(f"Prediction: {pred}")

''' 
Prediction: (as an example)
    Step_1: Move to the apple. Move towards the apple on the table.
    Step_2: Pick up the apple. Grab the apple and lift it off the table.
    Step_3: Move towards the basket. Move the apple towards the basket without dropping it.
    Step_4: Put the apple in the basket. Place the apple inside the basket, ensuring it is in a stable position.
'''
```

### error:
```
Cannot access gated repo for url https://huggingface.co/BAAI/RoboBrain/resolve/main/config.json.
Access to model BAAI/RoboBrain is restricted. You must have access to it and be authenticated to access it. Please log in.
```

### fix:

Generate token (set model and give permissions)
```
https://huggingface.co/settings/tokens
```

### Get acsess:
```
huggingface-cli login
```

```
    _|    _|  _|    _|    _|_|_|    _|_|_|  _|_|_|  _|      _|    _|_|_|      _|_|_|_|    _|_|      _|_|_|  _|_|_|_|
    _|    _|  _|    _|  _|        _|          _|    _|_|    _|  _|            _|        _|    _|  _|        _|
    _|_|_|_|  _|    _|  _|  _|_|  _|  _|_|    _|    _|  _|  _|  _|  _|_|      _|_|_|    _|_|_|_|  _|        _|_|_|
    _|    _|  _|    _|  _|    _|  _|    _|    _|    _|    _|_|  _|    _|      _|        _|    _|  _|        _|
    _|    _|    _|_|      _|_|_|    _|_|_|  _|_|_|  _|      _|    _|_|_|      _|        _|    _|    _|_|_|  _|_|_|_|

    To log in, `huggingface_hub` requires a token generated from https://huggingface.co/settings/tokens .
Enter your token (input will not be visible): 
Add token as git credential? (Y/n) y
Token is valid (permission: fineGrained).
The token `RoboBrain` has been saved to /home/silenzio/.cache/huggingface/stored_tokens
Cannot authenticate through git-credential as no helper is defined on your machine.
You might have to re-authenticate when pushing to the Hugging Face Hub.
Run the following command in your terminal in case you want to set the 'store' credential helper as default.

git config --global credential.helper store

Read https://git-scm.com/book/en/v2/Git-Tools-Credential-Storage for more details.
Token has not been saved to git credential helper.
Your token has been saved to /home/silenzio/.cache/huggingface/token
Login successful.
The current active token is: `RoboBrain`
```


_________


#### Option 2: VLLM inference
Install and launch VLLM

# Install vllm package
```bash
pip install vllm==0.6.6.post1
```

# Launch Robobrain with vllm
```
python -m vllm.entrypoints.openai.api_server --model BAAI/RoboBrain --served-model-name robobrain  --max_model_len 16384 --limit_mm_per_prompt image=8
```

Run python script as example:
```python
from openai import OpenAI
import base64

openai_api_key = "robobrain-123123" 
openai_api_base = "http://127.0.0.1:8000/v1"

client = OpenAI(
    api_key=openai_api_key,
    base_url=openai_api_base,
)

prompt = "Given the obiects in the image, if you are required to complete the task \"Put the apple in the basket\", what is your detailed plan? Write your plan and explain it in detail, using the following format: Step_1: xxx\nStep_2: xxx\n ...\nStep_n: xxx\n"

image = "./assets/demo/planning.png"

with open(image, "rb") as f:
    encoded_image = base64.b64encode(f.read())
    encoded_image = encoded_image.decode("utf-8")
    base64_img = f"data:image;base64,{encoded_image}"

response = client.chat.completions.create(
    model="robobrain",
    messages=[
        {
            "role": "user",
            "content": [
                {"type": "image_url", "image_url": {"url": base64_img}},
                {"type": "text", "text": prompt},
            ],
        },
    ]
)

content = response.choices[0].message.content
print(content)

'''
Prediction: (as an example)
    Step_1: Move to the apple. Move towards the apple on the table.
    Step_2: Pick up the apple. Grab the apple and lift it off the table.
    Step_3: Move towards the basket. Move the apple towards the basket without dropping it.
    Step_4: Put the apple in the basket. Place the apple inside the basket, ensuring it is in a stable position.
'''
```

____






### 2. Usage for Affordance Prediction
```python
from inference import SimpleInference

model_id = "BAAI/RoboBrain"
lora_id = "BAAI/RoboBrain-LoRA-Affordance"
model = SimpleInference(model_id, lora_id)

# Example 1:
prompt = "You are a robot using the joint control. The task is \"pick_up the suitcase\". Please predict a possible affordance area of the end effector?"

image = "./assets/demo/affordance_1.jpg"

pred = model.inference(prompt, image, do_sample=False)
print(f"Prediction: {pred}")

'''
    Prediction: [0.733, 0.158, 0.845, 0.263]
'''

# Example 2:
prompt = "You are a robot using the joint control. The task is \"push the bicycle\". Please predict a possible affordance area of the end effector?"

image = "./assets/demo/affordance_2.jpg"

pred = model.inference(prompt, image, do_sample=False)
print(f"Prediction: {pred}")

'''
    Prediction: [0.600, 0.127, 0.692, 0.227]
'''

```

<div align="center">
<img src="./assets/demo/afford_examples.png" />
</div>

### 3. Usage for Trajectory Prediction
```python
from inference import SimpleInference

model_id = "BAAI/RoboBrain"
lora_id = "BAAI/RoboBrain-LoRA-Trajectory"
model = SimpleInference(model_id, lora_id)

# Example 1:
prompt = "You are a robot using the joint control. The task is \"pick up the knife\". Please predict up to 10 key trajectory points to complete the task. Your answer should be formatted as a list of tuples, i.e. [[x1, y1], [x2, y2], ...], where each tuple contains the x and y coordinates of a point."

image = "./assets/demo/trajectory_1.png"

pred = model.inference(prompt, image, do_sample=False)
print(f"Prediction: {pred}")

'''
    Prediction: [[0.375, 0.297], [0.281, 0.344], [0.214, 0.406], [0.172, 0.473]]
'''

# Example 2:
prompt = "You are a robot using the joint control. The task is \"reach for the banana\". Please predict up to 10 key trajectory points to complete the task. Your answer should be formatted as a list of tuples, i.e. [[x1, y1], [x2, y2], ...], where each tuple contains the x and y coordinates of a point."

image = "./assets/demo/trajectory_2.png"

pred = model.inference(prompt, image, do_sample=False)
print(f"Prediction: {pred}")

'''
    Prediction: [[0.264, 0.479], [0.387, 0.512], [0.505, 0.554], [0.642, 0.6]]
'''

```

<div align="center">
<img src="./assets/demo/traj_examples.png" />
</div>
