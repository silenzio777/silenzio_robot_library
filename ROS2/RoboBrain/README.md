
# RoboBrain


### Test iference:

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
