%   This script runs the implementation of EMCF, which is borrowed from
%   BACF.

clear; %  MATLAB 환경의 모든 변수, 명령어 창, 열린 그림 창을 초기화
clc; %  MATLAB 환경의 모든 변수, 명령어 창, 열린 그림 창을 초기화
close all; %  MATLAB 환경의 모든 변수, 명령어 창, 열린 그림 창을 초기화
setup_paths; %  이 추적 알고리즘을 실행하는 데 필요한 모든 함수 파일(run_DSHCF, load_video_info, computePascalScore 등)이 있는 폴더들을 MATLAB의 검색 경로에 추가하는 함수

%   Load video information
% base_path  = 'F:/tracking/datasets/UAVTrack112';

base_path = './seq'; % 데이터셋의 기본 경로를 seq 폴더로 지정
video      = 'Yacht2'; %
video_path = [base_path '/' video];
[seq, ground_truth] = load_video_info(video,base_path,video_path);
seq.path = video_path;
seq.name = video;
seq.startFrame = 1;
seq.endFrame = seq.len;

gt_boxes = [ground_truth(:,1:2), ground_truth(:,1:2) + ground_truth(:,3:4) - ones(size(ground_truth,1), 2)]; 

% Run DSHCF
results = run_DSHCF(seq);

%   compute the OP
pd_boxes = results.res;
pd_boxes = [pd_boxes(:,1:2), pd_boxes(:,1:2) + pd_boxes(:,3:4) - ones(size(pd_boxes,1), 2)  ];
OP = zeros(size(gt_boxes,1),1);  % overlap rate
CE = zeros(size(gt_boxes,1),1);  % ceter location error
for i=1:size(gt_boxes,1)
    b_gt = gt_boxes(i,:);
    b_pd = pd_boxes(i,:);
    OP(i) = computePascalScore(b_gt,b_pd);
    centerGT = [b_gt(1) + (b_gt(3) - 1)/2, b_gt(2) + (b_gt(4) - 1)/2];
    centerPD = [b_pd(1) + (b_pd(3) - 1)/2, b_pd(2) + (b_pd(4) - 1)/2];
    CE(i) = sqrt((centerPD(1) - centerGT(1))^2 + (centerPD(2) - centerGT(2))^2);
end
OP_vid = sum(OP >= 0.5) / numel(OP);
CE_vid = sum(CE <= 20) / numel(CE);
FPS_vid = results.fps;
display([video  '---->' '   FPS:   ' num2str(FPS_vid)   '    op:   '   num2str(OP_vid)  '    ce:   '   num2str(CE_vid)]);
