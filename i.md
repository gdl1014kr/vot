# 1. installation

git clone https://github.com/visionml/pytracking.git
cd pytracking
git submodule update --init

## https://www.anaconda.com/download/success 에서 conda 설치 및 install.sh 수정 후
chmod +x install.sh
bash install.sh conda_install_path pytracking # which conda 하여 경로 조회 => ex: /home/username/anaconda3/bin/conda 일 경우 /home/username/anaconda3  or /home/username/miniconda3/bin/conda 일 경우 /home/username/miniconda3     

## 실행
./install.sh /home/username/anaconda3 pytracking

## Conda 환경 활성화
conda activate pytracking 

## PYTHONPATH 설정
export PYTHONPATH=$(pwd) # 반드시 pytracking 루트 디렉터리에서 실행
