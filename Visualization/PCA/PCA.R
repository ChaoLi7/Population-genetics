#PCA
#labels	PC1	PC2	PC3

setwd("path")
library(ggplot2)
library(ggpubr)
library(gcookbook)
library("readxl")

data <- read_excel("file.xlsx", sheet = "PCA_data") #3.13、3.06
head(data);dim(data)

values=c("LOW"="green4","SN"="orchid3","CQ"="yellow4",
         "LZ"="peru","NM"="saddlebrown","RT"="wheat4")

ggplot(data, aes(x = data$V3, y =data$V4),width = 1)+
  geom_point( aes(col=data$V1),shape=19,size=3) +
  scale_color_manual(values = values)+ 
  scale_fill_manual(values=values) +
  theme_bw()+theme(panel.grid.minor=element_blank())+
  theme(panel.background=element_blank())+ theme(axis.text.x = element_text(colour = "black",size = 10))+
  theme(axis.text.y = element_text(colour = "black",size = 10))+
  theme(plot.margin=unit(c(1,1,1.5,1.5), "lines"),axis.ticks.margin=unit(0.25,"lines"))+ #coord_flip()+
  xlab("PC1") +ylab("PC2") +
  ggtitle("title")+ #title
  theme(
    panel.grid.minor = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(size=8,colour="black"),
    legend.key.size = unit(0.5, "lines"),
    legend.key = element_blank(),
  )