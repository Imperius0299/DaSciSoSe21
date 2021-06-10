setwd("C:/Users/szepannek/Desktop")


fb <- read.table("https://raw.githubusercontent.com/g-rho/DaSciSoSe21/main/data/fb_likes.csv", sep = ";", header = T)

# descriptive analysis
x <- fb$openness
plot(hist(x), col = "yellow", main = "opnenness", freq = FALSE)

mean(x)
sd(x)

# add normal density 
xx <- seq(-4,2,by=0.05)
yy <- dnorm(xx, mean = mean(x), sd = sd(x))
lines(xx, yy, lty = "dotted", col = "red")


# wordcloud
library(wordcloud2)
wordcount <- colSums(fb[,-182]) # count '1's for each column (i.e. word)
df <- data.frame(word = names(wordcount), freq = wordcount)
wordcloud2(df, size = 0.5)


### predictive modelling

nmin <- 10
fb10 <- fb[rowSums(fb[,-182]) >= nmin,]
nrow(fb10) / 110728 # 23956 -- 0.216

library(rpart)
rpmod <- rpart(openness ~ ., fb10, cp = 0.005)

library(rpart.plot)
rpart.plot(rpmod) 
rpmod
