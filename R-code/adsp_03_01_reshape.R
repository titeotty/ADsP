####### 패키지 reshape ############################
rm(list = ls())

# reshape 패키지는 r에 내장된 명령문과 다름.
install.packages("reshape")
library(reshape) # 메모리 로드 

data("airquality") # 뉴욕의 대기질 데이터
head(airquality, 10)
names(airquality)
colnames(airquality)
rownames(airquality)
tolower(names(airquality))

# 열이름, 소문자로 일괄 변환
names(airquality) = tolower(names(airquality))
names(airquality)

## melt() cast()
# 넓은 자료구조를 길게(wide to long) 재구조화 해주는 melt() 함수
# id를 기준으로 나머지 각 변수를 variable이란 데이터로 만듦
# id로 지정한 월, 날짜별로 
# 나머지 열을 모두 variable, value에 값을 늘여놓는 방식

# 결측값 NA(Not Available)도 처리
aqm = melt(airquality, id = c("month", "day"))
aqm

install.packages("dplyr")
library(dplyr)
sample_n(airquality, 5)
sample_n(aqm, 5)

## melt()
aqm = melt(airquality, id=c("month", "day"), na.rm = TRUE)
aqm
sample_n(aqm, 5)

## cast()
# aqm 대상으로 day를 y 축, month를 x축, 
# 그리고 각 variable들의 값을 안에 넣어서 보여주는 형식
# 반환형은 3차원 배열. [일, 월, 변수]
# 변수 : ozone solar.r wind temp 
a <- cast(aqm, day ~ month ~ variable) # 결과는 3차원 배열
a 
class(a)   # 배열 유형
a[1, 1, 1] # 1일, 5월, ozone
a[1, 1, 'ozone'] # 1일, 5월, ozone
a[1:5, , 'ozone'] # *, *, ozone

a[1, 1, 2] # 1일, 5월, solar.r
a[1, 1, 'solar.r'] # 1일, 5월, solar.r
a[1:5, , 'solar.r'] # 1일, 5월, solar.r: solar.r의 1행에서 5행

# 월별 각 변수(오존, 태양복사, 바람, 온도)들의 평균값 산출 
b <- cast(aqm, month ~ variable, mean) 
b <- cast(aqm, month ~ variable, fun.aggregate=mean)
b 

# month 별로 모든 변수에 대해 평균을 구하고
# 이어서 | 를 사용해 산출물을 분리해서 리스트로 반환
aqm = melt(airquality, id=c("month", "day"), na.rm = TRUE)
c <- cast(aqm, month ~ . | variable, mean) 
c[[1]]
c[1]

############# 월별로 모든 변수의 평균: 별 의미가 없음
c2 <- cast(aqm, month ~ ., mean) 
c2 
##################

# 각 변수의 평균을 참조, 리스트 참조 방법
c[['ozone']]
c[['solar.r']]
c[['wind']]
c[['temp']]
c['temp']

# 가장 밑, 맨 오른쪽에 소합계나 소평균 산출 
# 이 경우는 평균
d <- cast(aqm, month ~ variable, mean, 
          margins = c("grand_row", "grand_col"))
d 
# 위와 동일
d2 <- cast(aqm, month ~ variable, mean, 
          margins = TRUE)
d2 

head(airquality)
# 일, 월 별로 subset을 이용해 ozone에 대해서만 평균(일 월의 값) 처리.
e <- cast(aqm, day ~ month, mean, subset = variable=="ozone")
e

# 일, 월 별로 subset을 이용해 solar.r에 대해서만 평균 처리.
e2 <- cast(aqm, day ~ month, mean, subset = variable=="solar.r")
e2

e3 <- cast(aqm, day ~ month, mean, subset = variable=="wind")
e3

# 함수 range()
range(airquality$ozone, na.rm = T) # 최대 최소 함수

#  영이름이 _X1, _X2로 suffix가 붙여 최대 최소 표시
f <- cast(aqm, month ~ variable, range)
f <- cast(aqm, month ~ variable, fun.aggregate=range)
f

# 사용가능한(설치된) 패키지(라이브러리) 확인 
library()
installed.packages()
.packages(all = TRUE) # 간략하게 이름만

# 현재 메모리에 로드(attach)된 패키지 확인
search()

# 로드된 패키지를 메모리에서 언로드하려면 detach() 함수를 사용
# 패키지 이름 앞에 package:를 붙여서 지정해야 함
detach('package:reshape')

# 패키지를 삭제(remove.packages)하면 패키지가 R 라이브러리에서 완전히 제거
# 다시 사용하려면 다시 설치
# remove.packages("reshape")
# remove.packages("reshape2")
library("reshape")
aqm = melt(airquality, id=c("month", "day"))
aqm

# the end