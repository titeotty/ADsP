###### 반복 구문과 조건문 ######################
rm(list = ls())

## 1) for 반복 구문

a <- c()
# a = NULL
# a = -1
for (i in 1:9) {
  a[i] <- i * i
}
print(a)

b <- c()
for (i in 1:9) 
  b[i] <- i * i
print(b)

isum <- 0
for (i in 1:100) {
  isum <- isum + i
}
cat("1부터 100까지의 합 =", isum, "입니다.", "\n")

x <- 0
while (x<5) {
  x <- x+1
  print(x)
}


## 3) if~else 조건문
StatScore <-  c(88, 90, 87, 92, 75, 65, 93, 54, 85, 90)
over90 <-  rep(0, length(StatScore))
over90

for (i in 1:length(StatScore)) {
  if (StatScore[i] >= 90) over90[i] <- 1
  else over90[i] <- 0
}

print(over90)
cat("90점을 넘은 사람의 수는 ", sum(over90), "명 입니다.", sep="")
cat("90점을 넘은 사람의 수는 ", sum(over90), "명 입니다.", sep="--")

# 사용자 정의 함수
addto <- function(a) {
  isum <- 0
  for (i in 1:a) {
    isum <- isum + i
  }
  return(isum)
}

print(addto(10))
print(addto(100))

# 기타 유용한 기능들
## 1) paste: 문자열로 연결

number <- 1:10
alphabet <- c("a", "b", "c")

print(paste(number, alphabet))
print(paste(number, alphabet, sep=" to the "))

substr("BigDataAnalysis", 1, 4)

country <- c("Korea", "Japan", "China", "Singapore", "Russia")
print(substr(country, 1, 3))

# 3) 자료형 데이터 구조 변환
x <- matrix(c(1,2,3,4,5,6), ncol=2)
x

print(as.data.frame(x))  # 데이터프레임
print(as.list(x))        # 리스트
print(as.matrix(x))      # 행렬
print(as.vector(x))      # 벡터
print(as.factor(x))      # 팩터

as.integer(3.14)
as.integer('3.14')
as.integer(c('3.14', 5))
as.numeric('foo')
as.character(101)
as.numeric(FALSE)
as.logical(0.35)
as.logical(0)

###########################################
income <- c(100, 200, 150, 300, 900)
car <- c("kia", "hyundai", "kia", "toyota", "lexus")
marriage <- c(FALSE, FALSE, FALSE, TRUE, TRUE)

df = data.frame(income, car, marriage)

# income 숫자형 벡터, car 문자형 벡터, marriage 논리형 벡터
print(df)              
# matrix 변환 후 모든 컬럼 문자형 벡터화
print(as.matrix(df))   
as.matrix(df)[2, 2]

## 4) 문자열을 날짜로 변환
print(Sys.Date())     # 오늘 날짜

a <- '2019-07-08'
b <- '07/08/2019'

print(as.Date(a))
print(as.Date(b, format = "%m/%d/%Y")) # 4자리 연도
print(as.Date(b, format = "%m/%d/%y")) # 2자리 연도
print(as.Date(b))

## 5) 날짜를 문자열로 변환

format(Sys.Date())
as.character(Sys.Date())
format(Sys.Date(), format="%m/%d/%Y")


# format 함수로 날자 정보 추출
format(Sys.Date(), '%a')             # 요일
format(Sys.Date(), '%b')             # 월
format(Sys.Date(), '%B')             # 7월
format(Sys.Date(), '%m')             # 두자리 숫자로 월
format(Sys.Date(), '%d')             # 두자리 숫자로 일
format(Sys.Date(), '%y')             # 두자리 숫자로 연도
format(Sys.Date(), '%Y')             # 네자리 숫자로 연도

# R 그래픽 기능
height <- c(170, 168, 174, 175, 188, 165, 165, 190, 173, 168, 159, 170)
weight <- c(68, 65, 74, 77, 92, 63, 67, 95, 72, 96, 60, 69)
plot(height, weight)
plot(weight ~ height)
plot(weight, height)
plot(height ~ weight)

# iris 샘플 데이터 (Sepal:꽃받침, Petal:꽃잎)
df <- iris            
df
str(df)

## 1) 산점도 그래프(Scatter Plot)
plot(df$Sepal.Length, df$Sepal.Width)  # 꽃받침 길이와 꽃받침 너비 산점도
plot(df$Sepal.Length, df$Petal.Length) # 꽃받침 길이와 꽃잎 길이 산점도

# 산점도 행렬(Scatter Plot Matrix)을 위한 준비
c("red", "green3", "blue")[1]
c("red", "green3", "blue")[c(1, 2)]
c("red", "green3", "blue")[c(1, 3, 2, 1, 3)]

df$Species
uc <- unclass(df$Species) # "setosa", "versicolor", "virginica"
uc # "setosa", "versicolor", "virginica"가 각각 1, 2, 3으로 수정된 벡터
c("red", "green3", "blue")[unclass(df$Species)]


names(df)

## 2) 산점도 행렬(Scatter Plot Matrix)
pairs(df[1:4],
      main = "Anderson's Iris Data -- 3 species",
      pch = 21,
      bg = c("red", "green3", "blue")[unclass(df$Species)])

pairs(df,
      main = "Anderson's Iris Data -- 3 species",
      pch = 21,
      bg = c("red", "green3", "blue")[unclass(df$Species)])

## 3) 히스토그램(Histogram)
StatScore <- c(88, 90, 87, 92, 75, 65, 93, 54, 85, 90)
hist(StatScore)
hist(StatScore, prob=T)

## 3) 상자그림(Box-Plot)
boxplot(StatScore)

StatScore2 <- c(88, 90, 87, 92, 75, 65, 93, 54, 85, 90, 108)
boxplot(StatScore2)
