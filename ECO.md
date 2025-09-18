ECO (Efficient Convolution Operators)

ECO는 CCOT(Continuous Convolution Operation Tracker)의 높은 정확도를 유지하면서 연산 효율성을 획기적으로 개선한 추적 알고리즘. 
CCOT는 매우 정확했지만 계산 비용이 높아 실시간 추적에 어려움. 
=> 이를 해결하기 위해 훈련 데이터의 중복성을 줄이고, 필터 모델을 효율적으로 재구성하여 성능과 속도 모두 향상.

ECO의 핵심 기여

1. 분해된 합성곱 연산자 (Factorized Convolution Operator)
기존 DCF 추적기들은 HOG나 Color Name 등 여러 종류의 특징(feature)을 사용했는데, 각 특징 채널마다 완전히 독립적인 상관 필터 학습. 이 방식은 비효율적이며, 학습해야 할 매개변수가 매우 많다는 단점.

ECO는 이 문제를 해결하기 위해 **'기저(basis) 필터'** 도입. 모든 특징 채널에 대해 소수의 공통 기저 필터들을 학습한 후, 각 채널의 최종 필터를 이 기저 필터들의 선형 조합으로 구성. 이로 인해 학습해야 할 매개변수 수가 크게 줄어들어 계산 비용이 압도적으로 낮아짐.

2. 훈련 샘플의 중복성 제거 (Training Sample Reduction)
기존 DCF는 target의 위치 변화에 대응하기 위해, 훈련 영역을 순환 이동(cyclic shift)하여 수많은 훈련 샘플을 만들었습니다. 그러나 이 샘플들 중 상당수는 서로 매우 유사하여 중복성이 높았고, 이로 인해 연산 낭비와 과적합(overfitting)이 발생했습니다.

ECO는 이 중복되는 훈련 샘플을 분석하여 가장 의미 있는 소수의 샘플만을 선택적으로 사용. 이를 통해 메모리 사용량과 연산량을 크게 줄이면서도 추적기의 판별 능력 유지.

3. 희소 업데이트 전략 (Sparse Update Strategy)
기존 추적기들은 매 프레임마다 필터를 업데이트하여 target의 외형 변화에 적응. 하지만 프레임 간 변화가 적을 경우, 매번 필터를 업데이트하는 것은 불필요한 연산 낭비.

ECO는 필요한 시점에만 필터를 업데이트하는 전략을 사용. 예를 들어, 추적기가 target의 위치를 매우 높은 신뢰도로 예측했거나, target의 외형에 큰 변화가 감지되었을 때에만 업데이트를 수행. 이처럼 업데이트 주기를 유동적으로 조절함으로써, 추적 속도를 향상.

요약
ECO는 필터 모델을 간결하게 만들고, 훈련 데이터를 최적화하며, 업데이트 주기를 조절하는 세 가지 핵심 아이디어를 통해 CCOT의 정확도를 유지하면서도 획기적인 속도 향상을 달성. 이는 상관 필터 기반 추적기를 실제 환경에 적용할 수 있는 실용적인 실시간 추적기로 발전시키는 데 결정적인 역할을 함.

DSST, CCOT, ECO 중 ECO가 가장 최신 기술. 뛰어난 성능과 효율성으로 Baseline으로 활용


이미지 피라미드 (Image Pyramid)
이미지 피라미드는 target의 크기 변화에 대응하기 위해 널리 사용되는 기법.

개념: 원본 이미지를 다양한 크기(스케일)로 재조정하여 여러 이미지 레이어(층)를 쌓는 방식. 마치 피라미드처럼 아래로 갈수록 이미지가 커지고 위로 갈수록 작아짐.

활용: DSST와 같은 추적기는 이 피라미드의 각 레이어에서 target의 특징을 추출. 이후 각 레이어의 특징에 대한 상관 필터 응답을 계산, 가장 높은 응답을 보이는 레이어를 target의 새로운 스케일로 판단. 이를 통해 target의 크기가 변하더라도 정확하게 추적 가능.


ECO:Efficient Convolution Operators for Tracking(2017)

Abstract:
DCF 기반 방식(C-COT)의 복잡해진 모델과 많은 학습 파라미터로 인해 계산 복잡성 및 과적합 발생 -> 속도와 성능 동시 향상 목표, 속도 개선이 주 목표(정확도는 많이 향상됨)
dataset: VOT2016, UAV123, OTB-2015, TempleColor


Contribution:


1. factorized convolution operator: Factorized convolution operator: DCF 모델에서 파라미터 수를 대폭 감소시켜 복잡성 완화.
2. Compact generative model of training sample distribution: 샘플 종류 다양성을 유지하면서 메모리와 시간 복잡성을 줄임.
3. Conservative model update strategy: 추적 속도와 견고성을 동시에 향상시키는 효율적인 모델 업데이트 전략

=> 속도 최대 20배 향상, 성능 크게 개선

