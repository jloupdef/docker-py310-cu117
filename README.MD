
git clone -b main  https://github.com/huggingface/transformers
cd transformers
git submodule update --init --recursive
python setup.py sdist bdist_wheel
cp dist/*.whl ../output
cd ..


git clone -b main  https://github.com/facebookresearch/xformers
cd xformers
git submodule update --init --recursive
python setup.py sdist bdist_wheel
cp dist/*.whl ../output
cd ..
