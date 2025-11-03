atom.py: ATOM Tracker의 main rogic. target을 initialize 하고 매 frame마다 tracking, IOU prediction을 통해 bounding box를 refine(refine_target_box)


optim.py: ATOM의 핵심인 최적화 문제 정의. ATOM이 Discriminative Correlation Filter(DCF)를 학습하는 과정에서 filter(필터)와 projetction matrix(차원 축소용 투영 행렬)을 동시에 최적화.
FactorizedConvProblem이 이 동시 최적화 문제를, ConvProblem이 필터만 최적화하는 문제를 정의.


