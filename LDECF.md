historical information: 이전 frame에서 얻은 object의 위치와 특성 정보(이전 프레임에서 학습된 필터, feature, tracking 결과 등)
response adjustments: 현재 frame에서 object의 위치를 얼마나 잘 판단하는지 response map으로 표현(response map의 값들을 동적으로 조절하여 노이즈나 동적 변화에도
안정적인 tracking 가능하도록 함.)


CF Tracking framework - historical information + response adjustments


동적인 환경에서 tracking 어려움

이유: target & background의 빈번한 변화, 센서의 photon-counting process(광자 계수 프로세스)에서 생성되는 stochastic noise(확률적 노이즈), 조명 변화


=> 해결 방안(이 논문에서의 contribution):  Adaptive Second-Order Difference Spatial Regularization(2차 차분 공간 정규화)을 통한 Dynamic-Sensitivity Enhanced Correlation Filter(LDECF, 동적 민감도가 향상된 상관 필터)



1. 센서의 photon-counting process에서 생성되는 stochastic noise

해결 방안: Non-local means(NLM) algorithm 을 통한 template images(더 큰 이미지에서 특정 패턴이나 객체를 찾기 위한 기준 이미지 조각 ex) 얼굴을 인식할 때 눈, 코, 입 등의 이미지를 의미)의 noise 제거 -> target의 contour discriminative 향상

- 원본 이미지에서 목표 영역(템플릿) 자름 -> 템플릿에서 특징 추출 -> 추출된 특징에 NLM denoising을 적용하여 noise 제거 및 target의 contour discriminative 향상 -> 특징을 기반으로 한 response map(현재 frame에서 object을 얼마나 잘 탐지하는지에 대한 시각화)

- NLM은 단순히 인접한 주변 픽셀만 보는 것이 아니라, 이미지 내 멀리 떨어진 유사한 패턴들도 찾아서 노이즈를 줄이고 원래 이미지의 구조를 더 잘 보존할 수 있음.

2. target & background의 빈번한 변화 

해결 방안: Dynamic-sensitivity error(forward-sensitive error와 historically-sensitive backtracking error의 차이)를 CF learning에 통합 -> Dynamic-sensitivity error optimization problem 와 adaptive second-order difference spatial regularization 도입

=> 동적 환경에서 target tracking stability 향상


 ADMM에 의해 최적화된 adaptive second-order difference spatial regularization을 사용하여  filter coefficients(필터 계수) and spatial regularization weights(공간 정규화 가중치) 동시 최적화
=> algorithm의 수렴 및 계산 효율성 향상

3. 조명 변화




필터와 가중치의 적응형 공간 정규화를 위해 ADSR을 적용해 필터의 공간적 연속성 유지 및 노이즈나 갑작스러운 변화 방지


 UAV tracking의 한계: 역동적인 배경, 급격한 시점 변화, 불확실한 비행 조건 등에서는 저하된 성능을 보임.

- 딥러닝 기반의 추적 방법은 높은 정확도를 보이지만, 복잡한 후처리 및 하이퍼파라미터 튜닝으로 인해 운용 속도에 영향을 미치고, 상당한 계산 자원을 요구함. 
=> 실시간성이 떨어짐. 단일 board를 사용하는 UAV에서 성능 저하. 적합하지 않음.
- CNN 기반 추적 방법: 높은 정확도를 보이지만, 상당한 계산 자원을 필요로하기 때문에 효율성 떨어짐.
- 경량 CNN 기반 추적 방법: filter pruning을 통한 정확도 및 효율성 모두 향상
- 트랜스포머 기반 모델은 대규모, 고품질 훈련 데이터와 상당한 계산 자원을 필요로 함. 많은 train이 필요.

-deep feature 기반  Correlation filter -> deep learning 기술+ 기존의 Correlation filter tracking 기술  (deep network를 통한 image feature 추출, CF를 이용한 실시간 tracking)

=> 결국 이 방식도 UAV는 단일 CPU를 사용하기 때문에 처리 속도가 크게 떨어짐.(낮은 효율성) 

- DCF(Discriminative Correlation Filter) 기반 방법은 복잡한 오프라인 훈련이 필요 없고, 온라인 업데이트 전략을 통해 목표물 변화에 빠르게 적응할 수 있음.
->  단일 CPU에서 계산 효율성이 높고 견고한 성능을 보여 자원이 제한적인 UAV 추적 환경에서 유용함.
-> 과거 정보를 통해 학습된 필터로 물체의 위치를 추적하기 때문에 잘못된 정보를 통해 학습하거나 객체의 특징이 불분명한 경우 모델의 성능이 급격히 저하됨.
즉, 잘못된 historical information, target과 background간 속도 변화율 불일치 등
적당히 역동적인 시나리오를 위해 설계되어 역동적인 환경에서는 부적합.


해결 방안: frame간 response level의 Dynamic-sensitivity error 활용, LDECF(Learning Dynamic-Sensitivity enhanced correlation filter)





