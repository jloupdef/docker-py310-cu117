FROM nvidia/cuda:11.7.1-devel-ubuntu22.04


SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEBIAN_FRONTEND noninteractive\
    SHELL=/bin/bash

RUN apt-get update --yes && \
    # - apt-get upgrade is run to patch known vulnerabilities in apt-get packages as
    #   the ubuntu base image is rebuilt too seldom sometimes (less than once a month)
    apt-get upgrade --yes && \
    apt install --yes --no-install-recommends\
    git\
    git-lfs\
    wget\
    curl\
    bash\
    nano\
    vim\
    openssh-server\
    python3\
    python3-dev\
    python3-pip\
    python-is-python3 &&\
    apt-get clean && rm -rf /var/lib/apt/lists/* &&\
    echo "fr_FR.UTF-8 UTF-8" > /etc/locale.gen

ENV FORCE_CUDA="1"

ARG TORCH_CUDA_ARCH_LIST="8.0"
ENV TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST}"

COPY whls/*.whl /

RUN pip install --upgrade pip wheel &&\
    pip install --extra-index-url https://download.pytorch.org/whl/cu117 \
        torch==1.13.1+cu117 \
        torchvision==0.14.1+cu117 \
        diffusers[torch]==0.12.0 \
        transformers==4.26.0 \
        onnxruntime==1.13.1 \
        accelerate \
        scipy \
        safetensors \
        "pynvml>=11.4.1" \
        "bitsandbytes>=0.36.0.post2" \
        "ftfy>=6.1.1" \
        "aiohttp>=3.8.3" \
        "tensorboard>=2.11.2" \
        protobuf==3.20.1 \
        wandb==0.13.9 \
        pyre-extensions==0.0.30 \
        pytorch-lightning==1.9.0 \
        omegaconf==2.3.0 \
        numpy==1.24.1 \
        keyboard \
        colorama \
        ninja \
        triton \
        pyre-extensions &&\
    pip install *.whl &&\
    pip cache purge

WORKDIR /root

ENV USE_TORCH=1


ADD start.sh /
ADD init_everydream.sh init_model.sh init_images.sh  /root/

RUN mkdir -p /root/.cache/huggingface &&\
    chmod +x /start.sh /root/*.sh &&\
    git lfs install

CMD [ "/start.sh" ]
