abstract

historical information: 이전 frame에서 얻은 object의 위치와 특성 정보(이전 프레임에서 학습된 필터, feature, tracking 결과 등)
response adjustments: 현재 frame에서 object의 위치를 얼마나 잘 판단하는지 response map으로 표현(response map의 값들을 동적으로 조절하여 노이즈나 동적 변화에도
안정적인 tracking 가능하도록 함.)


CF Tracking framework - historical information + response adjustments


동적인 환경에서 tracking 어려움

이유: target & background의 빈번한 변화, 센서의 photon-counting process(광자 계수 프로세스)에서 생성되는 stochastic noise(확률적 노이즈), 조명 변화


=> 해결 방안(이 논문에서의 contribution):  Adaptive Second-Order Difference Spatial Regularization(2차 차분 공간 정규화)을 통한 
Dynamic-Sensitivity Enhanced Correlation Filter(LDECF, 동적 민감도가 향상된 상관 필터) 제안



센서의 photon-counting process에서 생성되는 stochastic noise 및 target & background의 빈번한 변화 

해결 방안: 
1. Non-local means(NLM) algorithm 을 통한 template images(더 큰 이미지에서 특정 패턴이나 객체를 찾기 위한 기준 이미지 조각 ex) 얼굴을 인식할 때 눈, 코, 입 등의 이미지를 의미)의 noise 제거
 -> target의 contour discriminative 향상

- 원본 이미지에서 목표 영역(템플릿) 자름 -> 템플릿에서 특징 추출 -> 추출된 특징에 NLM denoising을 적용하여 noise 제거 및 target의 contour discriminative 향상 
-> 특징을 기반으로 한 response map(현재 frame에서 object을 얼마나 잘 탐지하는지에 대한 시각화)

- NLM은 단순히 인접한 주변 픽셀만 보는 것이 아니라, 이미지 내 멀리 떨어진 유사한 패턴들도 찾아서 노이즈를 줄이고 원래 이미지의 구조를 더 잘 보존할 수 있음.


2. Dynamic-sensitivity error(forward-sensitive error와 historically-sensitive backtracking error의 차이)를 CF learning에 통합(반영) 
-> Dynamic-sensitivity error optimization problem 와 adaptive second-order difference spatial regularization 도입

=> 필터가 환경 변화에 민감하게 대응하도록 하여 동적 환경에서 target tracking stability 향상

3. adaptive second-order difference spatial regularization을 사용하여  filter coefficients(필터 계수) and spatial regularization weights(공간 정규화 가중치) 동시 최적화
=> 이 정규화가 Dynamic-sensitivity error 전략과 시너지 효과를 내도록 설계.



4. ADMM 최적화 기법을 도입해 계산의 수렴 속도 및 효율성 향상


introduction

UAV tracking의 한계: 역동적인 배경, 급격한 시점 변화, 불확실한 비행 조건 등에서는 저하된 성능을 보임.

Siamese network 기반 SiamFC => 유사성 학습 접근 방식을 통해 object tracking 문제 해결

일부 딥러닝 기반 추적기: TLD(tracking-learning-detection) 방법 사용 
=> detection & tracking 동시 수행 =>  robustness & accuracy 향상 => but, 복잡한 후처리 및 하이퍼파라미터 튜닝(상당한 계산 자원)으로 인한 속도 저하
=> 실시간성이 떨어짐. 단일 board를 사용하는 UAV에서 성능 저하. 적합하지 않음.

CNN 기반 추적 방법: 높은 정확도를 보이지만, 상당한 계산 자원을 필요로하기 때문에 효율성 떨어짐.
=> 경량 CNN 기반 추적 방법: filter pruning와 같은 경량화 기술을 통한 정확도 및 계산 효율성 모두 향상

vision transformer 기반 모델은 정확도가 대규모, 고품질 훈련 데이터에 의존.  많은 train이 필요
=> 상당한 계산 자원으로 인해 속도 저하

필터와 가중치의 적응형 공간 정규화를 위해 ADSR을 적용해 필터의 공간적 연속성 유지 및 노이즈나 갑작스러운 변화 방지


deep feature 기반  Correlation filter 
-> deep learning 기술+ 기존의 Correlation filter tracking 기술  (deep network를 통한 image feature 추출, CF를 이용한 실시간 tracking)

=> 정확도면에서 우수한 성능. but, 계산 효율성 문제
=> 연산 자원이 제한된(단일 CPU 사용) UAV에서는 처리 속도가 크게 떨어짐.(낮은 효율성) 

DCF 추적기는 주로 ridge regression 문제를 해결하여 filter가 주변 환경에서 객체를 식별 가능
=> 전체 이미지에서 target을 찾는 것이 아니라 target template을 사용하여 상관 연산을 통해 현재 frame에서 대상의 위치를 효율적으로 찾음.
=> 딥러닝 기반 추적기보다 연산량이 적고, 단일 CPU에서 높은 계산 효율성과 강력한 성능으로, 제한적인 UAV tracking에 적합.

그러나 대부분의 DCF 기반 추적기는 과거 정보를 제대로 활용하지 못하고 대상과 배경 간의 변화율이 항상 일관되지 않다는 사실(target & background의 빈번한 변화)을 간과.
즉, 과거 정보를 통해 학습된 필터로 물체의 위치를 추적하기 때문에 잘못된 historical information를 통한 학습, target과 background간 속도 변화율 불일치 등
으로 인해 객체의 특징이 불분명한 경우 모델의 성능이 급격히 저하됨.
=> frame간 response level의 Dynamic-sensitivity error 활용, LDECF(Learning Dynamic-Sensitivity enhanced correlation filter) 모델 제안.

Dynamic-sensitivity error(forward-sensitive error(순방향 민감도 오류)와 historically-sensitive backtracking error(과거 민감도 역추적 오류)의 차이)를 CF learning에 통합(반영)하여 
Dynamic-sensitivity error optimization problem 와 adaptive second-order difference spatial regularization 도입
=> response level 변화가 작을 때 필터가 이전 필터의 판별력에 의해 제약을 받아 성능 저하를 방지. 
변화가 클 때는 필터가 더욱 유연해져 동적 민감도 오류의 변동을 수용하고 새로운 동적 환경에 적응하기 위해 템플릿 업데이트를 가속화.
 
forward-sensitive error : 현재 frame의 response와 이전 두 frame의 response를 비교 => 현재 response이 과거 response에서 얼마나 벗어나는지 측정
historically-sensitive backtracking error: 이전 frame의 filter response가 그보다 더 이전 frame의 filter response를 얼마나 잘 반영하는지 평가


