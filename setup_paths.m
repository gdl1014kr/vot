% 추적 알고리즘의 구성 요소들이 여러 폴더에 분산되어 있을 때, 이들을 한 번에 불러올 수 있도록 돕는 유틸리티 함수 코드


function setup_paths()

% Add the neccesary paths
[pathstr,~,~] = fileparts(mfilename('fullpath')); %  현재 스크립트 파일이 위치한 경로를 pathstr 변수에 저장
addpath(genpath([pathstr '/utils/'])); % utils 폴더와 그 아래 모든 하위 폴더를 MATLAB의 검색 경로에 추가
addpath(genpath([pathstr '/implementation/'])); % implementation 폴더와 그 아래 모든 하위 폴더를 검색 경로에 추가
addpath(genpath([pathstr '/feature/'])); % feature 폴더와 그 아래 모든 하위 폴더를 검색 경로에 추가

end
