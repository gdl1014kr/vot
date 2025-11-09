# 1. installation

git clone https://github.com/visionml/pytracking.git
cd pytracking
git submodule update --init

## https://www.anaconda.com/download/success 에서 conda 설치 
cd ~
cd ~/Downloads
bash Anaconda3-2025.06-0-Linux-x86_64.sh
source ~/.bashrc

## install.sh 수정 후
chmod +x install.sh
bash install.sh conda_install_path pytracking # which conda 하여 경로 조회 => ex: /home/username/anaconda3/bin/conda 일 경우 /home/username/anaconda3  or /home/username/miniconda3/bin/conda 일 경우 /home/username/miniconda3     

## 실행(conda 활성화, pytracking 디렉터리에서)
bash install.sh /home/username/anaconda3 pytracking

## Conda 환경 활성화
conda activate pytracking 

## PYTHONPATH 설정
export PYTHONPATH=$(pwd) # 반드시 pytracking 루트 디렉터리에서 실행

## timm 설치
pip install timm==0.6.13

# 2. Pytracking - for implementing my tracker

## Run the tracker on webcam feed => select the object to track by drawing a bounding box. Note: It is possible to select multiple targets to track!
### (필수) 시스템 CUDA 경로 간섭 방지
unset LD_LIBRARY_PATH

### (필수) pytracking 라이브러리 경로 설정
export PYTHONPATH=$(pwd)

python run_webcam.py tracker_name parameter_name (## ex: python run_webcam.py dimp dimp50)

## Run the tracker on some dataset sequence => This is done using the run_tracker script. => local.py에서 path 수정(ex: anno, data_seq 폴더 경로 직전까지 지정. dataset이 uav라면, settings.uav_path = '/home/dl/pytracking/pytracking/UAV123' 지정
python run_tracker.py tracker_name parameter_name --dataset_name dataset_name --sequence sequence --debug debug --threads threads (## ex: python run_tracker.py atom default --dataset_name uav --sequence uav_bike3 --debug 0 --threads 0, python run_tracker.py atom default --dataset_name uav --sequence uav_car13 --debug 3)

## Run the tracker on a set of datasets (local.py 코드에서 dataset 경로(settings.uav_path)에 맞게 수정
python run_experiment.py experiment_module experiment_name --dataset_name dataset_name --sequence sequence  --debug debug --threads threads(## ex: python run_experiment.py myexperiments uav_test --debug 0 --threads 4)

## Run the tracker on a video file => This is done using the run_video script.
python run_video.py tracker_name parameter_name videofile --optional_box optional_box --debug debug (## ex: python run_video.py dimp dimp50 /home/username/my_video.mp4 --optional_box [150,200,75,100] --debug 1) => 자동
