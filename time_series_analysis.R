# *****************************************************************
# OVERVIEW ####
# *****************************************************************
# time_series_analysis.R
# Code for IMG Spring 2022 Time Series Analysis
#
# Nitrogen Fertilizer Data: https://fred.stlouisfed.org/series/PCU325311325311A
# Potash Data: https://fred.stlouisfed.org/series/PCU212391212391#0
# 
# Author: Justin Dong

# *****************************************************************
# PACKAGES AND FUNCTIONS ####
# *****************************************************************

library(dplyr)
library(ggplot2)
library(lubridate)
library(forecast)
library(scales)

# *****************************************************************
# LOAD DATA ####
# *****************************************************************

# Source: https://stackoverflow.com/questions/13672720/r-command-
# for-setting-working-directory-to-source-file-location-in-rstudio
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

Nitrogen_Data <- na.omit(read.csv("Nitrogen Fertilizer.csv"))
Potash_Data <- na.omit(read.csv("Potash.csv"))

Nitrogen <- as.numeric(na.omit(Nitrogen_Data$Nitrogen))
Potash <- Potash_Data$Potash

# *****************************************************************
# CALCULATIONS ####
# *****************************************************************

Nitrogen_MTS <- ts(Nitrogen, start = decimal_date(ymd("1975-12-01")),
                   frequency = 12)
Nitrogen_Fit <- auto.arima(Nitrogen_MTS)
Nitrogen_Forecast <- forecast(Nitrogen_Fit, 60)
plot(Nitrogen_Forecast, xlab ="Monthly Data",
     ylab ="Index, Dec 1975 = 100",
     main ="Nitrogen Producer Price Index, 1975 - Projected 2027",
     sub = "80% and 95% Confidence Intervals")

Potash_MTS <- ts(Potash, start = decimal_date(ymd("1984-12-01")),
                   frequency = 12)
Potash_Fit <- auto.arima(Potash_MTS)
Potash_Forecast <- forecast(Potash_Fit, 60)
plot(Potash_Forecast, xlab ="Monthly Data",
     ylab ="Index, Dec 1984 = 100",
     main ="Potash Producer Price Index, 1984 - Projected 2027",
     sub = "80% and 95% Confidence Intervals")
