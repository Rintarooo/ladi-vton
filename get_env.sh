#!/bin/bash
conda create -n gpvton python=3.8 -y
conda activate gpvton
## https://pytorch.org/get-started/previous-versions/
pip install torch==1.7.1+cu110 torchvision==0.8.2+cu110 -f https://download.pytorch.org/whl/torch_stable.html
# pip install ftfy regex tqdm
# pip install git+https://github.com/openai/CLIP.git
pip install -r requirements.txt

##[fix bug]
# RuntimeError: Ninja is required to load C++ extensions
# pip install ninja

#   File "main.py", line 115, in concrete_synthesis
#     os.mkdir(save_path)
# FileNotFoundError: [Errno 2] No such file or directory: './result/final_result/Stark'
# os.makedirs(save_path, exist_ok=True)

# File "main.py", line 126, in diff_render
#     m = load_mtl("../predef/material_0.mtl")['material_0']
# FileNotFoundError: [Errno 2] No such file or directory: '../predef/material_0.mtl'
# './predef/material_0.mtl'

# FileNotFoundError: [Errno 2] No such file or directory: './result/inter_result//texture_map/00000_tex.jpg'