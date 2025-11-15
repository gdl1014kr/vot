# jetpack 6.2.1 (L4T R36.3)에 맞는 환경 설정

pip install https://developer.download.nvidia.com/compute/redist/jp/v61/pytorch/torch-2.5.0a0+872d972e41.nv24.08.17622132-cp310-cp310-linux_aarch64.whl
cd ~/torchvision  # torchvision 소스 폴더로 이동
python3 setup.py install --user
python -c "import torch; print(torch.__version__); print(torch.cuda.is_available())"
