1. ATOM (Accurate Tracking by Overlap Maximization)
ATOM은 tracking을 두 개의 독립적인 모듈로 분리하여, correlation filter의 빠른 속도와 deep learning의 높은 정확도를 결합한 tracker.

ATOM의 핵심 모듈

분류기(Classifier) 모듈:

- image 내에서 target의 대략적인 위치를 빠르게 찾는 역할.

- 이미지 영역을 foreground(target), background(배경)로 구분
=> tracking 중간에 물체의 모양이나 특징을 계속 학습하는 oneline learning 방식으로 동작.

- correlation filter의 원리를 활용하여, target의 외형 feature을 학습한 필터를 통해 다음 frame에서 target의 위치 예측. 계산 효율성 높아 실시간 tracking에 적합.

추정(estimation) 회귀기(Regressor) 모듈:

- target의 정확한 크기(scale)와 종횡비(aspect ratio)를 정밀하게 예측하는 역할.

- offline training을 통해 대량의 데이터를 학습한 작은 딥러닝 네트워크(DNN) 사용. 이 네트워크는 Classifier 모듈이 찾은 target의 위치를 기반으로 target의 bounding box 예측.

ATOM: Accurate Tracking by Overlap Maximization(2019)

Abstract

- 최근 visual tracking의 robustness 큰 향상. but, accuary 발전 제한적.

- 최근 tracking은 tracker가 목표 bounding box를 estimate하기 위해 multi-scale search(다양한 크기와 비율의 후보 bounding box를 만들어 classfier에 적용하는 방식) 방시에 집중하여 정확한 target state estimation이 어렵다는 한계 존재.

1. target의 자세, 변형, 시점 및 조명 변화 등 high-level적인 특징을 반영하지 못해 복잡한 target state estimation 한계. 즉, 정확도 문제.
=> 정확한 target estimation을 위해 광범위한 dataset을 통한 offline training이 필요함. 

2. multi-scale search 방식은 계산 비용이 높아 실시간성 떨어짐.

이를 해결하기 위해 ATOM 방식 도입.
ATOM은 multi-scale search 대신 IOU 예측 네트워크를 활용하여 목표 target과 후보 bounding box 간의 겹침(Overlap)을 예측하고, 이를 최대화하여 bounding box를 추정하여 더 정밀하고 효과적인 추적 달성

Introduction

일반적인 visual tracking: target의 초기 위치 정보만으로 image sequence 전체에서 target의 trajectory를 추정.

tracking은 크게 두 부분으로 나뉨.
1. 분류(classfication): 
- 이미지 내에서 target이 있는 위치를 대략적으로 찾음.
- 이미지 영역을 foreground(target), background로 구분
- tracking 실행 중에 현재 frame 정보를 이용해 모델을 실시간으로 업데이트하는 oneline learning 수행.
=> 이를 통해 물체의 모양이나 특징을 계속 학습하며, distractor(방해 요소)를 robust하게 구별하여 실시간으로 tracking accuracy와 robustness 확보.

2. 추정(estimation): 
- target의 위치와 scale을 나타내는 bounding box를 정확하게 계산하는 작업.
- 정확한 target estimation을 위해 미리 학습된 모델이 필요함.
=> 대규모 dataset으로 모델을 학습시키는 offline training 진행. 
이를 통해 tracking target의 정확한 위치와 scale(bounding box)를 예측 가능.

즉, 추적은 목표가 어디에 있는지 대략적으로 찾고(classification), 그 위치를 좀 더 정확하게 조정(estimation)하는 두 단계로 구성

backbone network: classfication, estimation 모두 ResNet-18 모델 사용
dataset: NFS, UAV123, TrackingNet, LaSOT, VOT2018
ATOM: PyTorch 기반 Python, GPU에서 구현