setwd("C:/Users/Yihan Hu/Desktop/STAT0011")
library(svglite)
library(readxl)
library(ggplot2)
library(reshape2)
library(data.table)
library(rempsyc)
library(forecast)
library(seastests)
library(seasonal)


SP <- read.csv("SP500.csv")
SSE <- read.csv("SSE.csv")
SP$Date <- as.Date(SP$Date, format = "%m/%d/%Y") 
SSE$Date <- as.Date(SSE$Date, format = "%m/%d/%Y")
SP <- SP[order(SP$Date), ]

sp_ts <- ts(SP$Price, start = c(2000, 1), frequency = 52)
sp_ts_decompose <- decompose(sp_ts)
plot(sp_ts_decompose)
isSeasonal(sp_ts)


fit <- tbats(sp_ts)
tbats.components(fit)



SP_Monthly <- read.csv("S&P 500 Historical Results Price Data.csv")
SP_Monthly$Date <- as.Date(SP_Monthly$Date, format = "%d/%m/%Y") 
SP_Monthly <- SP_Monthly[order(SP_Monthly$Date), ]
SP_Monthly$Price <- gsub(",", "", SP_Monthly$Price)
SP_Monthly$Price <- as.numeric(SP_Monthly$Price)


sp_monthly_ts <- ts(SP_Monthly$Price, start = c(2000, 2), frequency = 12)
sp_monthly_ts_decompose <- decompose(sp_monthly_ts)
plot(sp_monthly_ts_decompose)
isSeasonal(sp_monthly_ts)

fit <- seas(sp_monthly_ts)
summary(fit)
plot(fit)
adjusted <- final(fit)  # seasonally adjusted series
head(adjusted)

