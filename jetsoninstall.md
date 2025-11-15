git clone https://github.com/visionml/pytracking.git
cd pytracking
pip install https://developer.download.nvidia.com/compute/redist/jp/v61/pytorch/torch-2.5.0a0+872d972e41.nv24.08.17622132-cp310-cp310-linux_aarch64.whl
cd ..
git clone --branch v0.20.0 https://github.com/pytorch/vision torchvision
# 2. 폴더로 이동
cd torchvision
# 3. 빌드 버전 설정 (v0.20.0)
export BUILD_VERSION=0.20.0
# 4. 소스 빌드 및 설치
python3 setup.py install --user
# 5. 상위 폴더로 복귀
cd ..

cd ~/torchvision  # torchvision 소스 폴더로 이동
python3 setup.py install --user
python -c "import torch; print(torch.__version__); print(torch.cuda.is_available())"
cd ..


# install.sh에 포함된 기본 Python 패키지들
cd pytracking
pip install matplotlib pandas tqdm tb-nightly visdom scikit-image tikzplotlib gdown cython
pip install pycocotools lvis jpeg4py
pip install timm

# OpenCV는 Jetson 호환성을 위해 headless 버전을 권장합니다.
pip install opencv-python-headless

# KYS 트래커용 (선택 사항, 컴파일 오류 가능성 높음)
pip install spatial-correlation-sampler

sudo apt-get install ninja-build libturbojpeg

# jetpack 6.2.1 (L4T R36.3)에 맞는 환경 설정


