# 모든 변수 제거
rm(list=ls())

# 스칼라
a <- 3

str(a)    # 객체의 내부 구조를 표현
mode(a)   # 객체의 저장 모드
typeof(a) # 내부 타입 또는 객체의 저장 모드
class(a)  # 객체지향 관점의 클래스

is.numeric(a)
is.character(a)

# 스칼라
s <- 'RStudio'

str(s)
mode(s)
typeof(s)
class(s)
is.numeric(s)
is.character(s)

###### 행렬 ##############################
# 행과 열의 2차원, 기본 열 우선, 단일 유형의 자료
# 컬럼이 3개인 행렬(디폴트 열기준)
mx = matrix(c(1,2,3,4,5,6), ncol=2)       
mx
is.numeric(mx)
is.matrix(mx)
is.vector(mx)

str(mx)
mode(mx)
typeof(mx)
class(mx)

?str
?mode
?typeof
?class

# matrix: 행과 열 구조의 단일 자료형의 묶음
# 컬럼이 3개인 행렬(byrow=TRUE로 행기준)
mx2 = matrix(c(1,2,3,4,5,6), ncol=2, byrow=TRUE)  
mx2

str(mx2)
mode(mx2)
typeof(mx2)
class(mx2)

# 배열 array: 3차원 이상의 단일 자료형의 묶음
###### 3차원 배열 ##############################
arr = array(1:12, dim = c(2, 3, 2))       
arr

str(arr)
mode(mx)
typeof(mx)
class(arr)

###### 4차원 배열 ##############################
arr4 = array(1:36, dim = c(2, 3, 2, 3))       
arr4
dim(arr4)

str(arr)
mode(mx)
typeof(mx)
class(arr)
is.vector(arr4)
is.matrix(arr4)
is.array(arr4)

###### 벡터 ##############################
r1 = c(10, 10)
r1

str(r1)
mode(r1)
typeof(r1)
class(r1)
is.vector(r1)

c1 = c(20, 20, 20)

print(rbind(mx, r1))
print(cbind(mx2, c1))

###### 데이터프레임 ######################
# 열마다 단일 자료형, 2차원 데이터
income = c(100, 200, 150, 300, 900)
car = c("kia", "hyundai", "kia", "toyota", "lexus")
marriage = c(FALSE, FALSE, FALSE, TRUE, TRUE)

df = data.frame(income, car, marriage)
print(df)

str(df)
mode(df)
typeof(df)
class(df)

# 데이터프레임의 열: 동일한 자료형
df[3, 'car']
df[3, 'car'] = 100
df[3, 'car']

###### 리스트 ###########################
# 리스트: 모든 자료형을 모아 놓은 꾸러미(자루)
lt = list(c(1, 2), c("a"))
lt

str(lt)
mode(lt)
typeof(lt)
class(lt)

w <- list("python", matrix(1:9, 3, 3), c(2024:2028), 
          c(T, F, T, F), max)
w

str(w)
mode(w)
typeof(w)
class(w)

w[[1]] # 리스트의 원소 참조
w[[5]] # 리스트의 원소 참조
w[1] # 리스트에서 하나의 내부 리스트 참조
w[5] # 리스트에서 하나의 내부 리스트 참조
w[c(2, 5)] # 리스트에서 두 개의 내부 리스트 참조

###### 외부 데이터 불러오기 ################
## CSV 파일 불러오기 
data1 <- read.table("data\\example.txt", header=1, sep=',')
data1

# 다음 방법으로 엑셀 파일 읽기
# install.packages("readxl") # 설치
library(readxl) # 메모리 로드
# 기본 경로에 파일이 있으면 전체 경로명을 쓰지 않아도 됨
xldata = read_excel("data\\mydata.xlsx") 
xldata

data1 <- read.table("data\\dataset.csv", header = TRUE, sep = ",")
data1
data2 <- read.csv("data\\dataset.csv", header = TRUE)
data2

###########################################################
