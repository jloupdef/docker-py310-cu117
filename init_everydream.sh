#!/bin/bash

git clone https://github.com/victorchall/EveryDream2trainer
pushd EveryDream2trainer
mkdir ckpt_cache
pushd ckpt_cache
git clone https://huggingface.co/stabilityai/stable-diffusion-2-depth
git clone https://huggingface.co/stabilityai/stable-diffusion-2-1-base
popd
popd