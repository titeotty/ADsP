###################################################################
rm(list = ls())
## 데이터 탐색
iris
# 데이터 추상구조, 행렬의 수, 가볍게 숫자와 데이터 형태 보기.
str(iris)
summary(iris) #기초통계
summary(c(1:10))

cov(iris[, 1:4]) # 공분산
cor(iris[, 1:4]) # 상관계수
cor(iris[1:4]) # 상관계수
cor(iris) # 오류

# NA's   :37 
summary(airquality)

## 결측값 처리
y <- c(1,2,3,NA)
is.na(y)
z <- c(1,2,3,NaN)
is.na(y)

x <- c(1,2,NA,3)
mean(x) # 결측값 포함하고 계산해서 NA 출력
mean(x, na.rm = T) # 결측값 제외하고 계산

mydata = cbind(x, y) # 열로 결합
mydata

complete.cases(mydata) # 행에 na가 없는가
!complete.cases(mydata)

# 결측값이 없는 행만 출력
mydata[complete.cases(mydata),]
# 결측값이 있는 행만 출력
mydata[!complete.cases(mydata),]

#######################################
install.packages("Amelia")
library(Amelia)
detach(package:Amelia) # unload
search()
require(Amelia)

# install.packages("stringr")
library(stringr)
# 패키지 이름에 ':plyr'이 들어간 패키지 검색
search()[str_detect(search(), ':Amelia')]

data("freetrade")
head(freetrade) # Amelia dataset
str(freetrade)
summary(freetrade)

# 적어도 하나 na가 있는 행, 열 수
dim(freetrade[!complete.cases(freetrade),])
# na가 하나도 없는 행, 열 수
dim(freetrade[complete.cases(freetrade),])
nrow(freetrade) # 총 행수 : 171개

freetrade[!complete.cases(freetrade),]
missmap(freetrade)

unique(freetrade["country"]) # 9개국
unique(freetrade["year"]) # 1981 ~ 1999년
freetrade[freetrade$country == "Korea", ] # 한국 자료

# freetrade 데이터셋의 각 행에 NA가 있는지 확인
na_in_rows <- apply(freetrade, 1, function(row) any(is.na(row)))
na_in_rows
# 모든 행에 NA가 있는지 확인
all(na_in_rows)  # TRUE면 모든 행에 NA가 있음

## 데이터분석에서 결측값 처리가 중요
## 변수들 간의 관계를 이용해 다른 값으로 대체(imputation)을 하는 방법
# m: 대체법에 의해 생성되는 데이터셋의 수: m imputed datasets.
# ts: time series
# cs: cross section variable
a.out <- amelia(freetrade, m=5, ts="year", cs="country")
a.out
##################
# 대체된 데이터셋 확인
summary(a.out)

a.out$imputations[[1]] # 5 개중 첫번째
a.out$imputations[[2]] # 5 개중 두번째
a.out$imputations[[5]] # 5 개중 다섯번째

# 대체된 첫 번째 데이터셋 접근
imputed.dataset <- a.out$imputations[[1]]
head(imputed.dataset)
str(imputed.dataset)
dim(imputed.dataset)

head(freetrade)
dim(freetrade)

# 히스토그램
hist(a.out$imputation[[3]]$tariff, col="grey", border="white" )

# a.out을 imputations.RData에 저장
save(a.out, file="imputations.RData")

# 각 데이터셋이 outdata1.csv, outdata2.csv, ... 같은 형식으로 생성
write.amelia(obj=a.out, file.stem = "outdata")

# 결측값 확인 시각화
?missmap
missmap(a.out)
missmap(freetrade)

# imputation 하려면 imputation 값을 데이터셋에 쓰면 된다.
freetrade$tariff <- a.out$imputation[[5]]$tariff
missmap(freetrade)

freetrade.imputed  <- a.out$imputation[[5]]
missmap(freetrade.imputed)
####################################################################