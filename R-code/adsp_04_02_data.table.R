##### 패키지 data.table ###########################################
rm(list=ls())

# 빠른 그룹화와 순서화, 짧은 문장 지원해서 데이터 프레임보다 좋고, 
# 램이 64비트 이상일 때 효율적

# 패키지가 없으면 FALSE 반환하고 경고 메시지 발생 
require(data.table)
install.packages("data.table")
# 패키지가 없으면 오류 발생
library(data.table)

rnorm(10) # 표준 정규분포 난수 10개

# v란 변수에 정규분포 5개 난수 생성
DT = data.table(x=c("b", "b", "b", "a", "a"), v=rnorm(5))
DT # 데이터 프레임과 달리 맨 왼쪽에 위치한 행번호가 콜론(:)으로 프린트 되어 나옴

head(cars)
str(cars)
CARS <- data.table(cars) #데이터 프레임을 데이터 테이블로 바꾸기
head(CARS)

# airquality 
AQ = data.table(airquality)
AQ

# 현존하는 데이터 테이블 이름, 행, 열의 수, 용량, 변수 이름들, key의 유무 출력
tables() 
sapply(CARS, class) # 결과 매트릭스
lapply(CARS, class) # 결과 리스트

mat <- matrix(1:9,3,3)
mat
apply(mat, 1, sum)
apply(mat, 2, sum)

x <- list(1:10)
x
lapply(x, sqrt)
class(lapply(x, sqrt))

sapply(x, sqrt)
class(sapply(x, sqrt))

# iris 
IRIS = data.table(iris)
IRIS
tables() 

iris[2, ] # 2행
iris[2]   # 2열

DT
DT[2, ] # 2번째 행 조회
DT[2]   # 2번째 행 조회
DT[DT$x=="b", ] # x값이 b인 데이터 참조

# 오류
DT["b", ] # x값이 b인 데이터 참조

setkey(DT, x) # 키를 지정
tables() # 확인해보면 이제 DT에는 key가 x란 변수로 지정됨을 알 수 있다.

# 이제 키가 정해져 잇으므로 굳이 DT[DT$x=="b", ]처럼 쓸 필요 없음 
DT["b", ]
DT["b", mult="first"] # 첫번째 결과
DT["b", mult="last"]  # 마지막 결과

###############################################
# 매우 큰 데이터프레임 생성
my.DF <- data.frame(x = runif(2.6e+07), y = rep(LETTERS, each = 10000))
my.df <- data.frame(x = runif(2.6e+07), y = rep(letters, each = 10000))
str(my.DF)
str(my.df)
# 행 검색 속도
system.time(x <- my.DF[my.DF$y == 'C', ])

# data.table로 변환
my.DT <- as.data.table(my.DF)
system.time(x <- my.DT[my.DT$y == 'C', ])
# 키 설정
setkey(my.DT, y)
# 처리 속도가 매우 빠름 
system.time(x <- my.DT[J('C'), ])
###############################################

# data.table은 빠른 처이 시간이 장점
# 천만개 이상(10000068)의 행과 676(26^2)개 그룹
grpsize <- ceiling(1e7 / 26^2) 
26^2
grpsize

LETTERS # 알파벳 대문자 상수
letters # 알파벳 소문자 상수

# 걸린 시간 재는 함수 system.time
tt <- system.time(DF <- data.frame(  
  x = rep(LETTERS, each=26*grpsize), # LETTERS는 알파벳 대문자
  y = rep(letters, each=grpsize),    # letters는 알파벳 소문자
  v = runif(grpsize * 26^2),         # 0 ~ 1 사이의 난수 넣기, random uniform distribution
  stringAsFactors = FALSE)           # 열 stringAsFactors FALSE로
)

tt
str(tt)
str(DF)

head(DF)
tail(DF,3)

dim(DF)
nrow(DF)
ncol(DF)

dim(DF)[1]/tt["elapsed"] # 초당 몇개나 만들었는지 계산

# 일반 데이터프레임을 검색하는데 소요 시간
tt <- system.time(ans1 <- DF[DF$x=="R" & DF$y=="h", ])
tt
# 자료찾는데 걸린 시간. 하나하나 모든 자료와 비교하는 벡터 검색 방식
tt[3] 
head(ans1, 3)
dim(ans1)

# data.table에 키를 지정해 검색하는데 소요 시간
DT <- data.table(DF)
setkey(DT, x, y)
str(DT)

tables()

# 이진 검색을 함. J는 data.table 고유의 옵션 값으로 join을 의미
# DT 데이터 테이블에서 키가 "R"과 "h"인 행을 검색
# J("R", "h")는 data.table에서 키를 기준으로 데이터를 서브셋하는 데 사용
ss <- system.time(ans2 <- DT[J("R", "h")])
head(ans2, 3)
dim(ans2)
identical(ans1$v, ans2$v)# 두 변수가 같은지 비교한것.
ss #시간이 거의 안걸림

# 데이터프레임처럼 사용하면 성능은 비슷, 그래도 빠름
system.time(ans2 <- DT[DT$x=="R" & DT$y=="h", ]) 
# 두 데이터가 같은지 비교를 변수 별로 확인후 출력 
mapply(identical, ans1, ans2) 

# 모든 열 합
DT[, sum(v)] 
# x그룹 기준으로 summation
DT[, sum(v), by=x] 

# DT$v를 DT$x에 따라 나누어 함수 sum을 적용
tapply(DT$v, DT$x, sum)
# 위 문장의 소요 시간 측정과 출력
ttt <- system.time(tt <- tapply(DT$v, DT$x, sum)); ttt

# 데이터 테이블에서의 by는 tapply와 비교하면 빠름 
sss <- system.time(ss <- DT[, sum(v), by=x]); sss

head(tt)
head(ss)
identical(as.vector(tt), ss$V1)

# 그룹핑하려고 by="x,y" 사용
sss <- system.time(ss <- DT[, sum(v), by="x,y"]); sss; ss 

################################################################################
