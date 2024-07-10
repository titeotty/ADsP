install.packages("sqldf")
search()
library(sqldf)
search()

iris
sqldf("select * from iris")
sqldf("select * from iris limit 10")
# like 사용 시에는 ''사용
sqldf("select count(*) from iris where Species like 'se%'") 

