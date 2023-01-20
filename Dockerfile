FROM nvidia/cuda:11.7.1-devel-ubuntu22.04

RUN apt-get update && \
    apt-get install git python3 python3-pip python-is-python3 -y

RUN pip install --upgrade pip wheel

RUN pip install --no-cache-dir --extra-index-url https://download.pytorch.org/whl/cu117 \
                torch==1.13.1+cu117 \
                torchvision==0.14.1+cu117 \
                diffusers[torch]==0.11.1 \
                onnxruntime==1.13.1 \
                accelerate \
                scipy \
                safetensors \
                pynvml>=11.4.1 \
                bitsandbytes>=0.36.0.post2 \
                ftfy>=6.1.1 \
                aiohttp>=3.8.3 \
                tensorboard>=2.11.2 \
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
                pyre-extensions

ENV FORCE_CUDA="1"

ARG TORCH_CUDA_ARCH_LIST="8.0"
ENV TORCH_CUDA_ARCH_LIST="${TORCH_CUDA_ARCH_LIST}" 

RUN pip install --no-cache-dir "git+https://github.com/huggingface/transformers@main#egg=transformers"

RUN pip install --no-cache-dir "git+https://github.com/facebookresearch/xformers.git@main#egg=xformers"

RUN useradd -m huggingface

USER huggingface

WORKDIR /home/huggingface

ADD --chown=huggingface:huggingface https://raw.githubusercontent.com/Stability-AI/stablediffusion/main/configs/stable-diffusion/v2-inference-v.yaml v2-inference-v.yaml
ADD --chown=huggingface:huggingface https://raw.githubusercontent.com/Stability-AI/stablediffusion/main/configs/stable-diffusion/v2-inference.yaml v2-inference.yaml
ADD --chown=huggingface:huggingface https://raw.githubusercontent.com/Stability-AI/stablediffusion/main/configs/stable-diffusion/v2-midas-inference.yaml v2-midas-inference.yaml
ADD --chown=huggingface:huggingface https://raw.githubusercontent.com/CompVis/stable-diffusion/main/configs/stable-diffusion/v1-inference.yaml v1-inference.yaml

ENV USE_TORCH=1

RUN mkdir -p /home/huggingface/.cache/huggingface \
  && mkdir -p /home/huggingface/input \
  && mkdir -p /home/huggingface/output

#COPY docker-entrypoint.py /usr/local/bin
#ENTRYPOINT [ "docker-entrypoint.py" ]