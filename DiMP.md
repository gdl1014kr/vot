DiMP (Discriminative Model Prediction)
DiMP는 ATOM의 아이디어를 더욱 발전시켜, 필터 학습 과정 자체를 딥러닝 기반으로 최적화한 알고리즘입니다. DiMP의 목표는 target을 배경으로부터 가장 강력하게 구별할 수 있는 **'판별 필터(discriminative filter)'**를 학습하는 것입니다.

2.1. DiMP의 핵심 모듈
필터 학습 네트워크:

역할: 추적을 위한 최적의 상관 필터를 직접 예측합니다.

기술: DiMP는 필터 학습 과정 전체를 하나의 엔드투엔드(End-to-end) 신경망으로 통합했습니다. 이 네트워크는 target의 특징과 배경 정보를 입력으로 받아, target을 배경과 가장 잘 구별할 수 있는 필터를 출력합니다.

온라인 학습 (Online Learning): DiMP는 target의 외형이 변할 때마다 네트워크를 통해 필터를 빠르게 업데이트합니다. 이 과정은 수동으로 학습률을 설정하는 기존 방식보다 훨씬 더 강력하고 데이터에 기반한 학습이 가능합니다.

2.2. 주요 특징
DiMP는 필터 학습을 자동화하고 최적화함으로써 ATOM보다 더 높은 정확도를 달성했습니다. 특히, 추적 대상과 유사한 객체들이 주변에 많을 때, 이를 강력하게 구별하는 능력(판별 능력)이 매우 뛰어납니다.

Learning Discriminative Model Prediction for Tracking(2020)

Abstract

일반적인 tracking은 영상의 첫 frame에서 주어진 target의 초기 위치 정보만으로 image sequence 전체에서 target의 trajectory를 추정함.
=> 따라서, tracking 중간에 물체의 모양이나 특징을 계속 학습하는 oneline learning 과정이 필요함.

기존의 Siamese 네트워크 방식은 오직 물체의 모습만 보고 유사한 부분을 찾기 때문에 주변 배경이 어떻게 생겼는지 무시함. 
=> 따라서, 배경이 비슷하게 생긴 물체가 있으면 tracking이 어려움.

따라서 논문에서는 End-to-End 학습이 가능한 tracking architecture를 개발하고자 함.
- tracking 하는 물체 뿐만 아니라 주변 배경 정보도 함께 활용.
- online learning을 네트워크 내에 내장 하여 실제 영상에서 빠르고 효과적으로 작용하도록 함.
- 모델 업데이트를 매우 빠르게 수행하여 더 오랫동안 안정적으로 tracking 할 수 있도록 함.
