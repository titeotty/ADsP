###########  이상값 검색  #############################
rm(list = ls())

x = rnorm(100) # 표준정규 분포, -3 ~ +3
boxplot(x)
x

# 고의적인 이상값 추가
x = c(x, 19, 28, 30)
outwith = boxplot(x)
outwith$out # 이상값 출력

## 다른 방법으로는 outlier패키지 사용.
install.packages("outliers")
library(outliers)

set.seed(1234)
y = rnorm(100)

# 평균과 가장 차이가 많이 나는 값 출력
outlier(y) 

# 반대방향으로 평균과 가장 차이가 많이 나는 값 출력
outlier(y, opposite=TRUE) 

dim(y)
dim(y) = c(20, 5) # 20x5 행렬
y
class(y)
outlier(y) # 각 열의 평균에 가장 거리가 먼 숫자가 5개
outlier(y, opposite=TRUE) # 음수

boxplot(y)
boxplot(y)$out

boxplot(y[,3])
boxplot(y[,3])$out
###################################################################
