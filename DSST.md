DSST(Discriminative Scale Space Tracker)

tracking을 위치 추정과 크기 추정이라는 두 가지 독립적인 문제로 분리하여 해결한 알고리즘

위치 추정: 기존의 상관 필터를 사용하여 target의 위치를 추적

크기 추정(Scale Estimation): 
- target의 크기 변화에 특화된 별도의 1차원 상관 필터 사용
- 이 필터는 **이미지 피라미드(Image Pyramid)**를 구성하여 각 scale에서 추출한 특징에 상관 연산을 수행, 가장 높은 응답을 보이는 scale을 target의 새로운 크기로 결정.

=> 이러한 분리형 접근 방식은 위치와 크기 변화에 모두 강인하게 대응하며, 추적 성능을 크게 향상.



Discriminative Scale Space Tracking(2017)

Abstract

target의 정확한 scale estimation은 visual object tracking에서 어려운 연구 문제.
=> 최첨단 방법: exhaustive scale search(완전 탐색 스케일 검색) 사용
=> but, 큰 scale 변화 시 어려움, 계산 비용 많이 듦.

=> translation 및 scale estimation을 위해 DCF(Discriminative correlation filter) 학습.(target scale의 변화로 인해 발생하는 외형 변화를 직접 학습, 논문에서는 OTB(Online Tracking Benchmark), VOT2014 dataset 사용)


Conclusion

real-time visual tracking을 위한 accurate & robust한 scale estimation 문제 조사.
explicit scale filter는 target scale 변화에 의해 유도된 외형 변화를 직접 학습.(정확도)
계산 비용 줄임 => 속도 증가(real-time)

OTB(Online Tracking Benchmark), VOT2014 dataset에서 다른 tracker 보다 성능 우수


introduction

generic(일반적인) visual object tracking => target의 초기 위치 정보만으로 image sequence 전체에서 target의 trajectory를 추정해야하는데 occlusions, appearance variations, motion blur, fast motion, scale variations 등의 요인으로 어려움.

target scale 변화 => 카메라 축 움직임, 외형 변화로 인해 생김.

DCF 기반 => 계산 효율성으로 인한 real-time에 적합. 즉, DCF는 각 새로운 frame에서 target을 찾기 위함.
속도 향상 => 학습 및 감지 단계에서 고속 푸리에 변환(Fast Foruier transform, FFT)를 활용하여 얻을 수 있음.

DCF based tracking + scale estimation 
1. joint scale space filter
2. multi-resolution translation filter
=> 1,2 방식은 계산 비용 높아 real time에 부적합

따라서 target의 위치와 크기를 더 정확하고 지속적으로 tracking 하는 Discriminative approach for scale adaptive visual tracking(DSST) 제안.

새로운 frame이 주어지면 standard translation filter를 사용하여 target의 translation tracking -> 학습된 scale filter(scale 변화에 의해 유도된 appearance variations를 직접 학습)를 target 위치에 적용하여 target의 scale을 정확하게 tracking(accuracy & robustness)

fast DSST(fDSST) : DSST에 비해 속도 2배 향상, tracking 성능 크게 향상

DSST: Scale filter와 각 scale sample의 correlation.
- scale filter: target의 scale 변화를 추적하기 위해 학습된 1차원 filter.(각각의 scale 변화에 target의 appearance가 어떻게 변하는지 학습)
- 이미지 내 위치에서의 적용: target의 현재 위치를 알고 있을 때, 해당 위치를 기준으로 다양한 크기의 이미지 패치(각 scale sample) 생성 -> 이 패치들을 scale filter에 입력하여 각 scale에 대한 correlation score 계산
- correlation score: 각 scale sample과 학습된 scale filter 간의 일치 정도를 나타내는 점수. 점수가 높을수록 해당 scale이 현재 target 크기와 잘 맞는다는 의미.(여러 scale에 대한 correlation score를 비교하여 가장 높은 점수를 가진 sclae을 현재 대상의 크기로 추정)

<img width="362" height="366" alt="image" src="https://github.com/user-attachments/assets/482c8c8b-01bb-4463-a379-1e389fddd1c7" />

input: 현재 frame 영상 \(I_t\), 이전 target 위치 \(p_{t-1}\), 이전 타겟 스케일 \(s_{t-1}\), 그리고 이전 시점의 번역 및 스케일 모델 매개변수들 \(A_{t-1,trans}\), \(B_{t-1,trans}\), \(A_{t-1,scale}\), \(B_{t-1,scale}\).

1~3 (Translation estimation): 이전 위치 및 스케일에서 샘플 \(z_{t,trans}\)을 추출하고, 번역 필터를 적용해 상관점수 \(y_{t,trans}\)를 계산하여 타겟 위치 \(p_t\)를 업데이트합니다.

4~6 (Scale estimation): 위치가 갱신된 후 해당 위치에서의 샘플 \(z_{t,scale}\)을 추출해 스케일 필터를 적용, 상관점수 \(y_{t,scale}\)를 계산하여 타겟 스케일 \(s_t\)를 업데이트합니다.

7~9 (Model update): 새 위치와 스케일 정보로부터 훈련 샘플 \(f_{t,trans}\)와 \(f_{t,scale}\)을 추출하고, 각각의 필터 모델을 업데이트합니다.

metric: overlap precision(OP), distance precision(DP) , FPS

OTB dataset attribute:
in-plane rotation, scale variation, out of view, background clutter, illumination variation, motion blur, fast motion, deformation, out-of-plane rotation, occlusion 및 low resolution

vot2014 dataset attribute:
camera motion, illumination change, occlusion, size change and motion change

