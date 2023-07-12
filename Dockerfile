ARG PYTHON_VER=3.10.0
# https://pytorch.org/get-started/previous-versions/
ARG PYTORCH_VER=2.0.1
ARG CUDA_VER=11.7.1
ARG UBUNTU_VER=22.04

# https://hub.docker.com/r/nvidia/cuda
# FROM nvidia/cuda:11.7.0-base-ubuntu22.04
FROM nvidia/cuda:${CUDA_VER}-base-ubuntu${UBUNTU_VER}

ENV WORK_DIR /app

# https://freak-da.hatenablog.com/entry/2020/03/31/094140
ARG PYTHON_VER_WO=310
ARG PYTHON_VER
ARG CUDA_VER=117
ARG PYTORCH_VER
ARG UBUNTU_VER

# Install some basic utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3-pip \
    ca-certificates \
    sudo \
    wget \
    curl \
    vim \
    git \
    bzip2 \
    build-essential \
    vim \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# install Python 
RUN wget https://www.python.org/ftp/python/$PYTHON_VER/Python-$PYTHON_VER.tgz &&  \
    tar -xf Python-$PYTHON_VER.tgz &&  \
    cd Python-$PYTHON_VER &&  \
    ./configure --enable-optimizations &&  \
    make -j $(nproc) &&  \
    make altinstall

RUN ln -s /usr/bin/python${PYTHON_VER_WO} /usr/bin/python &&  \
    pip install --upgrade pip \
    pip install torch torchvision \
    opencv-python==4.7.0.72 diffusers==0.14.0 transformers==4.27.3 accelerate==0.18.0 clean-fid==0.1.35 torchmetrics[image]==0.11.4 wandb==0.14.0 matplotlib==3.7.1 tqdm xformers

    # pip install torch torchvision torchaudio jupyterlab
# torch-2.0.1+cu117.with.pypi.cudnn-cp310-cp310-linux_x86_64.whl
    # pip install torch==${PYTORCH_VER}+cu${CUDA_VER} torchvision==0.15.1+cu{CUDA_VER} --index-url https://download.pytorch.org/whl/cu117 \


# Create a working directory
RUN mkdir ${WORK_DIR}
WORKDIR ${WORK_DIR}

# # requirements.txtの場合
# # COPY requirements.txt ${WORK_DIR}
# # COPY environment.yml ${WORK_DIR}

# # RUN pip install -r requirements.txt
# # this is heavy if your current folder is a big data storage
# # COPY . ${WORK_DIR}

# # # Install Miniconda and Python 3.x
# # ENV CONDA_AUTO_UPDATE_CONDA=false
# # ENV PATH=/home/user/miniconda/bin:$PATH
# # RUN curl -sLo ~/miniconda.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
# #  && chmod +x ~/miniconda.sh \
# #  && ~/miniconda.sh -b -p ~/miniconda \
# #  && rm ~/miniconda.sh \
# #  && conda install -y python==$PYTHON_VERSION numpy scipy pandas matplotlib tqdm \
# #  && conda clean -ya


# # https://qiita.com/junkor-1011/items/cd7c0e626aedc335011d
# # ローカルuser作成
# # ARG USER_NAME=user
# # ARG USER_UID=1000
# # ARG PASSWD=password
# # RUN useradd -m -s /bin/bash -u ${USER_UID} ${USER_NAME} && \
# #     gpasswd -a ${USER_NAME} sudo && \
# #     echo "${USER_NAME}:${PASSWD}" | chpasswd && \
# #     echo "${USER_NAME} ALL=(ALL) ALL" >> /etc/sudoers && \
# #     chmod g+w /etc/passwd


# # conda用準備
# ENV CONDA_DIR=/opt/conda \
#     CONDA_TMP_DIR=/tmp/conda \
#     HOME=/home/$USER_NAME \
#     SHELL=/bin/bash
# RUN mkdir -p $CONDA_DIR && \
#     mkdir -p $CONDA_TMP_DIR
#     # && \
#     # chown $USER_NAME:$USER_UID $CONDA_DIR && \
#     # chown $USER_NAME:$USER_UID $CONDA_TMP_DIR

# # yamlファイルの取り込み
# ARG CONDA_YAML="./environment.yml"
# COPY $CONDA_YAML /tmp/conda_packages.yml

# # USER ${USER_NAME}

# # WORKDIR $HOME

# # miniconda
# # https://repo.anaconda.com/miniconda/
# ARG MINICONDA_VERSION=py${PYTHON_VER_WO}_23.3.1-0-Linux-x86_64
# # latest-Linux-x86_64
# # py37_4.8.3-Linux-x86_64
# # ARG MINICONDA_MD5=751786b92c00b1aeae3f017b781018df
# ENV PATH=${CONDA_DIR}/bin:$PATH

# RUN cd /tmp && \
#     wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-${MINICONDA_VERSION}.sh && \
#     /bin/bash Miniconda3-${MINICONDA_VERSION}.sh -f -b -p $CONDA_TMP_DIR && \
#     rm Miniconda3-${MINICONDA_VERSION}.sh && \
#     $CONDA_TMP_DIR/bin/conda env create -f /tmp/conda_packages.yml -p $CONDA_DIR && \
#     rm -rf $HOME/.cache/* && \
#     rm -rf $CONDA_TMP_DIR/*
#     # echo "${MINICONDA_MD5} *Miniconda3-${MINICONDA_VERSION}.sh" | md5sum -c - && \
#     # 