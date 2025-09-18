Abstract

target의 정확한 scale estimation은 visual object tracking에서 어려운 연구 문제.
=> 최첨단 방법: exhaustive scale search(완전 탐색 스케일 검색) 사용
=> but, 큰 scale 변화 시 어려움, 계산 비용 많이 듦.

=> translation 및 scale estimation을 위해 DCF(Discriminative correlation filter) 학습.(target scale의 변화로 인해 발생하는 외형 변화를 직접 학습, 논문에서는 OTB, VOT2014 dataset 사용)


Conclusion

real-time visual tracking을 위한 accurate & robust한 scale estimation 문제 조사.
explicit scale filter는 target scale 변화에 의해 유도된 외형 변화를 직접 학습.(정확도)
계산 비용 줄임 => 속도 증가(real-time)

OTB, VOT2014 dataset에서 다른 tracker 보다 성능 우수


introduction

generic(일반적인) visual object tracking => target의 초기 위치만으로 sequence 전체에서 target의 trajectory를 추정해야하는데 occlusions, appearance variations, motion blur, fast motion, scale variations 등의 요인으로 어려움.

target scale 변화 => 카메라 축 움직임, 외형 변화로 인해 생김.

DCF 기반 => 계산 효율성으로 인한 real-time에 적합.
속도 향상 => 학습 및 감지 단계에서 고속 푸리에 변환(Fast Foruier transform, FFT)를 활용하여 얻을 수 있음.

DCF based tracking + scale estimation 
1. joint scale space filter
2. multi-resolution translation filter
=> 1,2 방식은 계산 비용 높아 real time에 부적합

따라서 Discriminative approach for scale adaptive visual tracking(DSST) 제안.

