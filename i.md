git clone https://github.com/visionml/pytracking.git
cd pytracking
git submodule update --init

#install.sh 수정 후
chmod +x install.sh
bash install.sh conda_install_path pytracking # which conda 하여 경로 조회 => ex: /home/username/anaconda3/bin/conda 일 경우 /home/username/anaconda3  or /home/username/miniconda3/bin/conda 일 경우 /home/username/miniconda3     

# 실행
./install.sh /home/username/anaconda3 pytracking
