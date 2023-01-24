#!/bin/bash

cd /workspace

git clone --depth=1 https://github.com/victorchall/EveryDream2trainer
pushd EveryDream2trainer

wget https://raw.githubusercontent.com/Stability-AI/stablediffusion/main/configs/stable-diffusion/v2-inference-v.yaml
wget https://raw.githubusercontent.com/Stability-AI/stablediffusion/main/configs/stable-diffusion/v2-inference.yaml
wget https://raw.githubusercontent.com/Stability-AI/stablediffusion/main/configs/stable-diffusion/v2-midas-inference.yaml
wget https://raw.githubusercontent.com/CompVis/stable-diffusion/main/configs/stable-diffusion/v1-inference.yaml

mkdir ckpt_cache
pushd ckpt_cache

model=stable-diffusion-2-1-base
#model=stable-diffusion-2-depth

mkdir $model && pushd $model
git init
git remote add -f origin https://huggingface.co/stabilityai/$model

git config core.sparsecheckout true

echo depth_estimator >> .git/info/sparse-checkout
echo feature_extractor >> .git/info/sparse-checkout
echo scheduler >> .git/info/sparse-checkout
echo text_encoder >> .git/info/sparse-checkout
echo tokenizer >> .git/info/sparse-checkout
echo unet >> .git/info/sparse-checkout
echo vae >> .git/info/sparse-checkout
echo .gitattributes >> .git/info/sparse-checkout
echo model_index.json >> .git/info/sparse-checkout


git pull --depth=1 origin main


#git clone --depth=1 https://huggingface.co/stabilityai/$model
#git clone --depth=1 https://huggingface.co/stabilityai/stable-diffusion-2-1-base
popd
popd
