###### 주요 단축키 ##########################
#
# 현재(선택블록) 문장 실행: ctrl + Enter
# 현재 파일 모든 문장 실행: ctrl + alt + R
# 이전 실행, 다시 실행: ctrl + alt + P
# 대입연산자 <- (단축키: alt + -)
# 줄, 블록 주석처리 토글 # : ctrl + shift + C
# 콘솔 창 비우기(clear) : ctrl + L
# 
#############################################

a <- 10 # scalar
a
b <- c(10) # combine, scalar
b

?identical
identical(a, b) # 함수형 언어

x <- c(1, 10, 24, 40) # 벡터 생성, 단일 자료형
y <- c('사과', '바나나', '오렌지') # 문자
z <- c(TRUE, FALSE, TRUE)
xy <- c(x, y)
print(xy)

# numeric => character
m <- c(1993, 'R') # 벡터 생성, 단일 자료형
m
# logical => numeric
n <- c(0, TRUE) # 벡터 생성, 단일 자료형
n
# logical => character
p <- c('logical', TRUE) # 벡터 생성, 단일 자료형
p

# 파일 실행 명령
# source("adsp_01_01_basic.R")

?source
help(source)
# 커서 위에서 F1

# 모든 변수 제거
rm(list = ls())
#############################################