1. ATOM (Accurate Tracking by Overlap Maximization)
ATOM은 추적을 두 개의 독립적인 모듈로 분리하여, 상관 필터의 빠른 속도와 딥러닝의 높은 정확도를 결합한 하이브리드 추적기입니다. 이 이원화(two-stage) 전략이 ATOM의 핵심입니다.

1.1. ATOM의 핵심 모듈
분류기(Classifier) 모듈:

역할: target의 대략적인 위치를 빠르게 찾는 역할을 합니다.

기술: 상관 필터의 원리를 활용하여, target의 외형 특징(feature)을 학습한 필터를 통해 다음 프레임에서 target의 위치를 예측합니다. 이 모듈은 계산이 매우 효율적이어서 실시간 추적의 기반이 됩니다.

회귀기(Regressor) 모듈:

역할: target의 정확한 **크기(scale)**와 **종횡비(aspect ratio)**를 정밀하게 예측합니다.

기술: 오프라인에서 대량의 데이터를 학습한 **작은 딥러닝 네트워크(DNN)**를 사용합니다. 이 네트워크는 분류기 모듈이 찾은 위치를 기반으로 target의 경계 박스(Bounding Box)를 최종적으로 정밀하게 조정합니다.

1.2. 주요 특징
ATOM은 빠른 분류기로 target을 찾고, 정밀한 회귀기로 크기를 예측하여, 속도와 정확도를 동시에 만족시키는 데 성공했습니다.


ATOM: Accurate Tracking by Overlap Maximization(2019)

Abstract

- tracking의 robustness 큰 향상. but, accuary 발전 제한적.
- 최근 tracking trend가 scale을 classfication함에 따라 정확한 target state estimation 간과됨.

즉, 대부분의 tracker는 목표 bounding box를 estimate하기 위해 multi-scale search(다양한 크기와 비율의 후보 bounding box를 만들어 classfier에 적용하는 방식)

=> 이는 다음과 같은 한계가 있음.
1. target의 자세, 변형, 시점 변화 등 high-level적인 특징을 반영하지 못해 복잡한 target state estimation 한계. 즉, 정확도 문제.
2. multi-scale search 방식은 계산 비용이 높음.

이를 해결하기 위해 ATOM 방식 도입.
ATOM은 multi-scale search 대신 IOU 예측 네트워크를 활용하여 목표 target과 후보 bounding box 간의 겹침(Overlap)을 예측하고, 이를 최대화 하는 방향으로 bounding box를 추정하여 더 정밀하고 효과적인 추적 달성