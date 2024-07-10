# 모든 변수 제거
rm(list=ls())

###### R의기초 함수 #######################
###### rep() seq()  
# 1을 3회 반복
print(rep(1, 3))

# 1에서 3까지 연속된 수
print(seq(1, 3))

# 1에서 3까지 연속된 수
print(1:3)
1:3

?seq
# 1에서 11까지 공차가 2인 등차수열
print(seq(1, 11, by=2))

# 1에서 11까지 항이 6개인 등차수열
print(seq(1, 11, length=6))
print(seq(1, 11, length.out=6))

# 1에서 11까지 항이 8개인 등차수열
print(seq(1, 11, length=8))

?rep
# 2에서 5까지 연속된 수를 각 3회 반복
print(rep(2:5, times = 3))

print(rep(2:5, length = 10)) # 전체 항목이 10개
print(rep(2:5, length.out = 10)) # 전체 항목이 10개

print(rep(2:5, each = 3)) # 

# 논리 연산
A <- 2:4; A
B <- 5:7; B
( A > 3 ) & ( B > 3 )        # 벡터 연산
( A > 3 ) && ( B > 3 )       # 오류
( A > 3 )[1] && ( B > 3 )[1] # 단일 항목 연산

( A > 3 ) | ( B > 3 )
( A > 3 ) || ( B > 3 )
( A > 3 )[1] || ( B > 3 )[1]

# 기초적인 수치 계산
a = 1:10

print(a)
print(a + a)
print(a - a)
print(a * a)
print(a / a)

a = c(2,7,3)    # 벡터
a

# 벡터는 행렬로 보면 열우선 벡터
as.matrix(a)
b = t(a)        # 전치(transpose)

print(a)
print(b)

class(a)
is.vector(a)
class(b)
is.matrix(b)

a * b           # 스칼라 곱
a %*% b         # 행렬 곱

##### 행렬곱 연산 #####
# 2 0 0       2 7 3
# 7 0 0   *   0 0 0
# 3 0 0       0 0 0
#######################

# 행렬: matrix
mx = matrix(c(1,2,3,4), ncol=2)
mx
5 * mx

mx_inv = solve(mx)              # mx의 역행렬
mx_inv

mx
mx_inv

mx %*% mx_inv                   # 결과 : 단위행렬

mx = matrix(c(23, 41, 12, 35, 67, 1, 24, 7, 53), nrow=3)
mx

5*mx

solve(mx)

########### 기술통계량
a = 1:10

# a의 평균
mean(a)
# a의 분산
var(a)
# a의 표준편차
sd(a)
# a의 합
sum(a)
# a의 중앙값
median(a)

median(c(1, 2, 3, 4))
median(c(1, 2, 3, 4, 5))
mean(c(1, 2, 3, 4, 5))
median(c(1, 2, 3.5, 4, 5))
mean(c(1, 2, 3.5, 4, 5))

# a의 로그값
print(log(a))

# a와 a의 공분산
cov(a, a)
# a와 log(a)의 공분산
cov(a, log(a))

# a와 a의 상관계수
cor(a, a)

# a와 log(a)의 상관계수
cor(a, log(a))

# a의 요약 통계량 (최솟값/1사분위수/중앙값/평균값/3사분위수/최댓값)
summary(a)

# R 데이터 핸들링
## 1) 벡터형 변수

b = c("a", "b", "c", "d", "e")
print(b[1])
print(b[-2])

print(b[c(-2,-3)])
print(b[-c(2,3)])

print(b[-c(-2,-3)])
print(b[c(2,3)])

## 2) 행렬/데이터 프레임 형태의 변수

income = c(100, 200, 150, 300, 900)
car = c("kia", "hyundai", "kia", "toyota", "lexus")
marriage = c(FALSE, FALSE, FALSE, TRUE, TRUE)

df = data.frame(income, car, marriage)
print(df)

print(df[2,2])   # 스칼라
print(df[1])     # 1열, 결과: 데이터프레임
print(df[, 1])   # 1열, 결과: 벡터

print(df[-1])    # 1열 제외
print(df[-2])    # 2열 제외
print(df[-1,-1]) # 1행, 1열 제외
print(df[2,])    # 2행 

print(df[2])     # 2열, 결과: 데이터프레임
print(df[,2])    # 2열, 결과: 벡터 

# 기출 문제
c(1, 2, 3, 4) + c(10, 20, 30)
3 == NA
c(1, 2, 3, NA) == NA
###############################################################
# 다양한 함수
outer(1:3, 1:3, "*")
outer(1:3, 1:3)
outer(1:3, 1:3, "+")

countries <- c("KOR", "US", "EU")
stat <- c("GDP", "Pop", "Area")
outer(countries, stat, FUN = paste, sep='-')
