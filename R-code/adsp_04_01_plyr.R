###################################################################
rm(list = ls())

# 데이터 분리하고 처리한 다음 결합하는 필수적 기능 제공 
# apply에 기반해 출력변수를 배열로 치환해주는 패키지
# 앞의 글자는 입력 데이터 형태 
# 둘째 글자는 출력 데이터 형태
# d(dataframe), a(array), l(list) 3 x 3개의 경우의 수가 존재
set.seed(1) # 난수 고정

# 0에서 1 사이의 균등 분포 난수(random uniform distribution) 3 개 생성
?runif
runif(3, min = 0, max = 1) 
runif(20, 0, 20) # 0에서 20 사이의 난수 20 개 생성

rep(2012:2014, each=6) # 총 18개
round(runif(9, 0, 20)) # 총 9개
round(runif(9, 0, 20), 2) # 총 9개

# year란 변수에는 6개씩 2012부터 2014까지 넣고(총 18개), 
# count란 변수에는 0에서 20사이 정수 9개
# 뒤의 빈부분은 다시 반복해서 입력
set.seed(1) # 난수 고정
d <- data.frame(year = rep(2012:2014, each=6), 
                count = round(runif(9, 0, 20)))
print(d)

################# 시험 범위 아님
### 패키지 로드, 함수 str_detect() 사용하기 위해 
install.packages("stringr")
library(stringr)
search()

# 패키지 이름에 ':plyr'이 들어간 패키지 검색
search()[str_detect(search(), ':plyr')]

# 패키지 설치
install.packages("plyr")
library(plyr)
search()[str_detect(search(), ':plyr')]

# 메모리에 로드된 패키지의 위치 파악
searchpaths()
#######################################

# 함수 apply(): 가장 기본이 되는 함수
# 행(Row) 또는 열(Column) 단위의 연산을 쉽게 할 수
# 있도록 지원하는 함수 
# MARGIN: 함수 인자에 어떤 단위로 연산 할 것인지
# 1: 행 단위 연산, 2: 열 단위 연산
# apply 함수의 실행 결과는 매트릭스나 벡터(Vector)로 출력

?apply
x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
x
## mean, 1: 행
apply(x, 1, mean)
## sum 적용, 2: 열
apply(x, 2, sum)

# 데이터 프레임 내에 그룹 별로 특정한 함수를 적용한
# 데이터 분석을 하는 함수
# 도움말 다음 또는 단어선택 + F1
?ddply

# transform 옵션: 기존의 열 + 새로운 열
# summaries 옵션: 새로운 분류에 대한 새로운 열만 표시

# 새로 생긴 변수, mean.count만 표시
ddply(d, "year", summarise, mean.count = mean(count))

# 새로 생긴 변수, total.count만 표시
ddply(d, "year", summarise, total.count = sum(count)) 

# transform 옵션: 기존 열 + 새로운 열
ddply(d, "year", transform, total.count = sum(count)) 

#######################
d

# 변동계수 계산하는 함수를 year 변수의 각 값을 기준으로 구함
# 변동계수(變動係數. coefficient of variation)
# 변동계수 또는 상대 표준편차(relative standard deviation, RSD)
# 표준편차를 표본평균이나 모평균 등 산술 평균으로 나눈 것
# 측정 단위가 다른 자료를 비교할 때 사용
# 즉, "변동계수 = 표준편차 / 평균"

# 열 "year", 열 "cv.count" 데이터 프레임 생성
ddply(d, "year", function(x) {
  mean.count = mean(x$count)
  sd.count = sd(x$count)
  cv = sd.count / mean.count
  data.frame(cv.count = cv)
})

ddply(d, "year", summarise, 
      sd.year = sd(count), 
      mean.year = mean(count), 
      cv.year = sd.year / mean.year)

###################################################################
# https://m.blog.naver.com/sw4r/222154367000 참조

test_data = data.frame(Gender = c(rep('M', 6), rep('F', 6)), 
                       Group = c(rep('A', 3), rep('B', 4), rep('C', 5)), 
                       values = c(1, 4, 2, 3, 1, 8, 7, 1, 5, 9, 10, 21))
test_data

# 기존의 행, 열이 있으며, 새로운 열 mean이 정의
# 각각의 데이터에 M과 F로 그룹화된 데이터 내에서
# 평균을 계산한 값이 동일하게 삽입
ddply(test_data, "Gender", transform, mean = mean(values))
ddply(test_data, .(Gender), transform, mean = mean(values))
ddply(test_data, "Group", transform, mean = mean(values))
ddply(test_data, "Gender", transform, adding = 2+values)

# 여러 그룹핑 분류
ddply(test_data, c("Gender", "Group"), transform, mean = mean(values))
ddply(test_data, .(Gender, Group), transform, mean = mean(values))

# 대표되는 그룹만 표시
ddply(test_data, "Gender", summarise, mean = mean(values))
ddply(test_data, "Group", summarise, mean = mean(values))
# 여러 그룹핑 분류
ddply(test_data, .(Gender, Group), summarise, mean = mean(values))

####################################################################
# 도움말 문서 예제 코드
dfx <- data.frame(
  group = c(rep('A', 8), rep('B', 15), rep('C', 6)),
  sex = sample(c("M", "F"), size = 29, replace = TRUE),
  age = runif(n = 29, min = 18, max = 54)
)
dfx

# 한 그룹 표시 
ddply(dfx, .(group), summarize,
      mean = round(mean(age), 2), sd = round(sd(age), 2))
ddply(dfx, ~group, summarize,
      mean = round(mean(age), 2), sd = round(sd(age), 2))
ddply(dfx, "group", summarize,
      mean = round(mean(age), 2), sd = round(sd(age), 2))

# 여러 그룹 표시 
ddply(dfx, .(group, sex), summarize,
      mean = round(mean(age), 2), sd = round(sd(age), 2))
ddply(dfx, group~sex, summarize,
      mean = round(mean(age), 2), sd = round(sd(age), 2))
ddply(dfx, ~group + sex, summarize,
      mean = round(mean(age), 2), sd = round(sd(age), 2))
ddply(dfx, ~sex + group, summarize,
      mean = round(mean(age), 2), sd = round(sd(age), 2))

# 모든 행에 사용된 열도 표시
ddply(dfx, .(group, sex), transform,
      mean = round(mean(age), 2), sd = round(sd(age), 2))
####################################################################























