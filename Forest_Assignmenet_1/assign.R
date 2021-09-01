library(readxl)
library(dplyr)
library(reshape2)
library(ggplot2)

#서울시와 성북구 exel파일 불러오기
setwd("C:/Users/dbwls/Desktop/R_file/forest/Forest_Assignmenet_1")
fine_dust <- read_xls("./dust.xls", na = "-", col_types = c("text", "text", rep("numeric", 24)))
fine_dust_soungbuk <- read_xls("./soungbuk.xls", na = "-", col_types = c("text", "text", rep("numeric", 24)))
fine_dust_1 <- fine_dust
fine_dust_soungbuk_1 <- fine_dust_soungbuk

#index가 모두 영어로된 파일생성
colnames(fine_dust_1)[3:ncol(fine_dust_1)] <- paste("T", gsub("시", "", colnames(fine_dust)[3:ncol(fine_dust)]), sep = "")
fine_dust_1 <- rename(fine_dust_1, Type = "측정망", Location = "측정소명")
colnames(fine_dust_soungbuk_1)[3:ncol(fine_dust_soungbuk_1)] <- paste("T", gsub("시", "", colnames(fine_dust_soungbuk)[3:ncol(fine_dust_soungbuk)]), sep = "")
fine_dust_soungbuk_1 <- rename(fine_dust_soungbuk_1, Type1 = "측정망", Location1 = "측정소명")

#그래프 그리기
f_melt <- melt(fine_dust_1)
f_melt <- melt(fine_dust_1, id = c("Type", "Location"))
f_soungbuk_melt <- melt(fine_dust_soungbuk_1)
f_soungbuk_melt <- melt(fine_dust_soungbuk_1, id = c("Type", "Location"))
f_plot <- f_melt %>% mutate(Time = paste("2020-10-14", gsub("T", "", variable), ":00:00", sep = " ")) %>% filter(!is.na(value))
f_soungbuk_plot <- f_soungbuk_melt %>% mutate(Time = paste("2020-10-14", gsub("T", "", variable), ":00:00", sep = " ")) %>% filter(!is.na(value))


Time_series_p <- ggplot(data = f_plot, aes(x = variable, y = value))
Time_series_p + geom_boxplot(aes(group = variable), fill = '#999966') + geom_point(data = f_soungbuk_plot, aes(x = variable, y = value), color ='#FF3333') +   xlab("Time") + ylab("PM 2.5") +
  ggtitle("- 2020.10.14 Seoul dust plot - (made by Yujin Kwak)")



