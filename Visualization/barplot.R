setwd("path")
library(gcookbook)
library(ggplot2)
library("readxl")

data <- read_excel("file.xlsx", sheet = "map_data") #3.13、3.06
head(data);dim(data)

order<-c(1:length(data[,1]))
data1<-cbind(data,order)
value<-c("blue","red")
value <- colorRampPalette(c("dodgerblue3", "aliceblue"))(length(data[,1]))
ggplot(data, aes(x = order,y=-log10(Q_Value),
                 fill =rev(data$PATHWAY)))+
  geom_bar(stat = "identity",width = 0.8,  position="dodge",
           aes(x = order, y = -log10(Q_Value),fill=data$PATHWAY))+
  coord_flip()+theme(legend.position = 'NA')+
  scale_fill_manual(values =value)+
  scale_x_continuous(limits=c(min(data$order)-0.5,max(data$order)+0.5),breaks=seq(1,20,by=1),
                     expand=c(0,0),labels=c((paste(data[,1],sep=",")))) +
  scale_y_continuous(limits=c(0,6),breaks=seq(0,6,by=2),expand=c(0,0))+
  theme_set(theme_bw())+theme(panel.grid.minor=element_blank())+theme(panel.grid.major=element_blank())+
  theme(panel.background=element_blank())+ theme(axis.text.x = element_text(colour = "black"))+
  theme(axis.text.y = element_text(colour = "black"))+
  xlab("Kegg pathway (top 20)") +ylab("-log10( adjusted q-value)") +
  ggtitle("")+
  theme(plot.title = element_text(colour = "black"),
        axis.title.x = element_text( colour = "black"),
        axis.title.y = element_text( colour = "black", angle=90),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border=element_blank(), # 取消绘图区域四周的边框
        axis.line=element_line(colour="black"), # 添加坐标轴（即x轴与y轴）的直线
        legend.position = 'NA'
  )




#gene region
pdf("fst.pdf")
par(mfrow=c(3,2))
args=commandArgs(TRUE)
Filename=args[1]
print(Filename)
filelist<-read.table("Filename",head=F)
for (i in 1:dim(filelist)[1]){
  filecp=as.character(filelist[i,1])
  print(filecp)
  prefix=unlist(strsplit(filecp,split="."))
  outprefix=prefix[length(prefix)]
  outname=paste(outprefix,filelist[i,1],sep=".")
  data<-read.table(filecp,head=F)
  plot(data[,4],data[,5],type="l",pch=15,cex=0.5,xlab="Genome pos",ylab="Fst")
  #lines(x,z,type="l",col="blue",pch=c(16)) #追加线
  abline(h=0.175,col="red")
  #abline(v=3,col="red")
  title(main=outname)
}
dev.off()

#world cloud
library(wordcloud2)  
data<-read.table("clipboard",header = T,sep = "\t")
head(data)
wordcloud2(data,minRotation = -pi/4, maxRotation = -pi/4, 
           rotateRatio = 0,  color = 'random-dark',
           size = 0.3,shape = 'circle')  





