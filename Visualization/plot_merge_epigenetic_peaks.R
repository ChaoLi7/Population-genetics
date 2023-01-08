#
setwd("path")
library(ggplot2)

#read data
snp1<-read.table("clipboard",header = F)
head(snp1);dim(snp1)
Indel<-read.table("clipboard",header = FALSE)
head(Indel);dim(Indel)
ATAC_seq<-read.table("clipboard",header = FALSE)
head(ATAC_seq);dim(ATAC_seq)
Chip_seq<-read.table("clipboard",header = FALSE)
head(Chip_seq);dim(Chip_seq)
Conservation_seq<-read.table("clipboard",header = FALSE)
head(Conservation_seq);dim(Conservation_seq)
AB_Compartment_seq<-read.table("clipboard",header = FALSE)
head(AB_Compartment_seq);dim(AB_Compartment_seq)
TAD_seq<-read.table("clipboard",header = FALSE)
head(TAD_seq);dim(TAD_seq)
SVs<-read.table("clipboard",header = FALSE)
head(SVs);dim(SVs)
snp1_ATAC_seq<-read.table("clipboard",header = FALSE)
head(snp1_ATAC_seq);dim(snp1_ATAC_seq)
snp1_Chip_seq<-read.table("clipboard",header = FALSE)
head(snp1_Chip_seq);dim(snp1_Chip_seq)
Indel_ATAC_seq<-read.table("clipboard",header = FALSE)
head(Indel_ATAC_seq);dim(Indel_ATAC_seq)
Indel_Chip_seq<-read.table("clipboard",header = FALSE)
head(Indel_Chip_seq);dim(Indel_Chip_seq)
#plot
setwd("C:/Users/Chao/Desktop")
pdf("Select.region1.pdf", paper="a4")
grid.newpage()
pushViewport(viewport(layout = grid.layout(11,1)))
vplayout<-function(x,y)
  viewport(layout.pos.row = x,layout.pos.col = y)
plot_snp1<-ggplot()+
  geom_rect(data = snp1, aes(xmin =snp1[,2], xmax = snp1[,2], 
                             ymin = -0.02, ymax = 0.02,
                             fill = -log10(snp1[,3])))+
  scale_fill_gradient(low="blue", high="red")+
  #scale_fill_manual(colorRampPalette(c("navy","white","red"))(50))+
  scale_y_continuous(limits=c(-0.02,0.02),expand=c(0,0))+
  scale_x_continuous(limits=c(41880000,42180000),expand=c(0,0))+
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid=element_line(color="black",size=2),
        panel.grid.major=element_line(size=1,linetype =0,color="white"),
        panel.grid.minor=element_line(size=1,linetype =0,color="white"))+
  theme(legend.position = "none")+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(), 
        axis.ticks.y=element_blank())

plot_Indel<-ggplot()+
  geom_rect(data = Indel, aes(xmin =Indel[,2], xmax = Indel[,2], 
                              ymin = -0.02, ymax = 0.02,
                              fill = Indel[,4]))+
  scale_fill_gradient(low="blue", high="red")+
  #scale_fill_manual(colorRampPalette(c("navy","white","red"))(50))+
  scale_y_continuous(limits=c(-0.02,0.02),expand=c(0,0))+
  scale_x_continuous(limits=c(41880000,42180000),expand=c(0,0))+
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid=element_line(color="black",size=2),
        panel.grid.major=element_line(size=1,linetype =0,color="white"),
        panel.grid.minor=element_line(size=1,linetype =0,color="white"))+
  theme(legend.position = "none")+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(), 
        axis.ticks.y=element_blank())

plot_SVs<-ggplot()+
  geom_rect(data = SVs, aes(xmin =SVs[,2], xmax = SVs[,3], 
                            ymin = -0.02, ymax = 0.02,
                            fill = SVs[,4]))+
  scale_fill_gradient(low="blue", high="red")+
  #scale_fill_manual(colorRampPalette(c("navy","white","red"))(50))+
  scale_y_continuous(limits=c(-0.02,0.02),expand=c(0,0))+
  scale_x_continuous(limits=c(41880000,42180000),expand=c(0,0))+
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid=element_line(color="black",size=2),
        panel.grid.major=element_line(size=1,linetype =0,color="white"),
        panel.grid.minor=element_line(size=1,linetype =0,color="white"))+
  theme(legend.position = "none")+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(), 
        axis.ticks.y=element_blank())

plot_ATAC_seq<-ggplot(ATAC_seq,aes(ATAC_seq[,2]))+
  geom_rect(xmin =ATAC_seq[,2], xmax = ATAC_seq[,3], 
            ymin = -0.02, ymax = 0.02,fill = "black")+ 
  scale_y_continuous(limits=c(-0.02,0.02),expand=c(0,0))+
  scale_x_continuous(limits=c(41880000,42180000),expand=c(0,0))+
  theme(panel.grid.minor=element_blank())+
  theme(panel.grid.major=element_blank(),panel.border=element_blank())+
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid=element_line(color="black",size=2),
        panel.grid.major=element_line(size=1,linetype =0,color="white"),
        panel.grid.minor=element_line(size=1,linetype =0,color="white"))+
  theme(legend.position = "none")+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(), 
        axis.ticks.y=element_blank())+
  xlab(NULL)

plot_Chip_seq<-ggplot(Chip_seq,aes(Chip_seq[,2]))+
  geom_rect(xmin =Chip_seq[,2], xmax = Chip_seq[,3], 
            ymin = 0, ymax = Chip_seq[,5],fill = "black")+ 
  scale_y_continuous(limits=c(0,50),expand=c(0,0))+
  scale_x_continuous(limits=c(41880000,42180000),expand=c(0,0))+
  theme(panel.grid.minor=element_blank())+
  theme(panel.grid.major=element_blank(),panel.border=element_blank())+
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid=element_line(color="black",size=2),
        panel.grid.major=element_line(size=1,linetype =0,color="white"),
        panel.grid.minor=element_line(size=1,linetype =0,color="white"))+
  theme(legend.position = "none")+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(), 
        axis.ticks.y=element_blank())+
  xlab(NULL)

AB_Compartment_seq_values=c("A"="orchid3","B"="green4")
plot_AB_Compartment_seq<-ggplot()+
  geom_rect(data = AB_Compartment_seq, aes(xmin =AB_Compartment_seq[,2], xmax = AB_Compartment_seq[,3], 
                                           ymin = -0.02, ymax = 0.02,
                                           fill = AB_Compartment_seq[,4]))+
  scale_fill_manual(values = AB_Compartment_seq_values)+
  #scale_fill_(colorRampPalette(c("navy","white","red"))(50))+
  scale_y_continuous(limits=c(-0.02,0.02),expand=c(0,0))+
  scale_x_continuous(limits=c(41880000,42180000),expand=c(0,0))+
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid=element_line(color="black",size=2),
        panel.grid.major=element_line(size=1,linetype =0,color="white"),
        panel.grid.minor=element_line(size=1,linetype =0,color="white"))+
  theme(legend.position = "none")+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(), 
        axis.ticks.y=element_blank())

TAD_seq_values=c("TAD1"="blue","TAD2"="green4")
plot_TAD_seq<-ggplot()+
  geom_rect(data = TAD_seq, aes(xmin =TAD_seq[,2], xmax = TAD_seq[,3], 
                                ymin = -0.02, ymax = 0.02,
                                fill = TAD_seq[,4]))+
  scale_fill_manual(values = TAD_seq_values)+
  #scale_fill_(colorRampPalette(c("navy","white","red"))(50))+
  scale_y_continuous(limits=c(-0.02,0.02),expand=c(0,0))+
  scale_x_continuous(limits=c(41880000,42180000),expand=c(0,0))+
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid=element_line(color="black",size=2),
        panel.grid.major=element_line(size=1,linetype =0,color="white"),
        panel.grid.minor=element_line(size=1,linetype =0,color="white"))+
  theme(legend.position = "none")+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(), 
        axis.ticks.y=element_blank())

plot_Conservation_seq<-ggplot(Conservation_seq,aes(Conservation_seq[,2]))+
  geom_rect(xmin =Conservation_seq[,2], xmax = Conservation_seq[,3], 
            ymin = 0, ymax = 0.02,fill = "black")+ 
  scale_y_continuous(limits=c(0,0.02),expand=c(0,0))+
  scale_x_continuous(limits=c(41880000,42180000),expand=c(0,0))+
  theme(panel.grid.minor=element_blank())+
  theme(panel.grid.major=element_blank(),panel.border=element_blank())+
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid=element_line(color="black",size=2),
        panel.grid.major=element_line(size=1,linetype =0,color="white"),
        panel.grid.minor=element_line(size=1,linetype =0,color="white"))+
  theme(legend.position = "none")+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(), 
        axis.ticks.y=element_blank())+
  xlab(NULL)

plot_snp1_ATAC_seq<-ggplot()+
  geom_rect(data = snp1_ATAC_seq, aes(xmin =snp1_ATAC_seq[,2], xmax = snp1_ATAC_seq[,2], 
                                      ymin = -0.02, ymax = 0.02,
                                      fill = -log10(snp1_ATAC_seq[,3])))+
  scale_fill_gradient(low="blue", high="red")+
  #scale_fill_manual(colorRampPalette(c("navy","white","red"))(50))+
  scale_y_continuous(limits=c(-0.02,0.02),expand=c(0,0))+
  scale_x_continuous(limits=c(41880000,42180000),expand=c(0,0))+
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid=element_line(color="black",size=2),
        panel.grid.major=element_line(size=1,linetype =0,color="white"),
        panel.grid.minor=element_line(size=1,linetype =0,color="white"))+
  theme(legend.position = "none")+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(), 
        axis.ticks.y=element_blank())

plot_snp1_Chip_seq<-ggplot()+
  geom_rect(data = snp1_Chip_seq, aes(xmin =snp1_Chip_seq[,2], xmax = snp1_Chip_seq[,2], 
                                      ymin = -0.02, ymax = 0.02,
                                      fill = -log10(snp1_Chip_seq[,3])))+
  scale_fill_gradient(low="blue", high="red")+
  #scale_fill_manual(colorRampPalette(c("navy","white","red"))(50))+
  scale_y_continuous(limits=c(-0.02,0.02),expand=c(0,0))+
  scale_x_continuous(limits=c(41880000,42180000),expand=c(0,0))+
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid=element_line(color="black",size=2),
        panel.grid.major=element_line(size=1,linetype =0,color="white"),
        panel.grid.minor=element_line(size=1,linetype =0,color="white"))+
  theme(legend.position = "none")+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(), 
        axis.ticks.y=element_blank())  

plot_Indel_ATAC_seq<-ggplot()+
  geom_rect(data = Indel_ATAC_seq, aes(xmin =Indel_ATAC_seq[,2], xmax = Indel_ATAC_seq[,2], 
                                       ymin = -0.02, ymax = 0.02,
                                       fill = Indel_ATAC_seq[,3]))+
  scale_fill_gradient(low="blue", high="red")+
  #scale_fill_manual(colorRampPalette(c("navy","white","red"))(50))+
  scale_y_continuous(limits=c(-0.02,0.02),expand=c(0,0))+
  scale_x_continuous(limits=c(41880000,42180000),expand=c(0,0))+
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid=element_line(color="black",size=2),
        panel.grid.major=element_line(size=1,linetype =0,color="white"),
        panel.grid.minor=element_line(size=1,linetype =0,color="white"))+
  theme(legend.position = "none")+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(), 
        axis.ticks.y=element_blank())   

plot_Indel_Chip_seq<-ggplot()+
  geom_rect(data = Indel_Chip_seq, aes(xmin =Indel_Chip_seq[,2], xmax = Indel_Chip_seq[,2], 
                                       ymin = -0.02, ymax = 0.02,
                                       fill = Indel_Chip_seq[,3]))+
  scale_fill_gradient(low="blue", high="red")+
  #scale_fill_manual(colorRampPalette(c("navy","white","red"))(50))+
  scale_y_continuous(limits=c(-0.02,0.02),expand=c(0,0))+
  scale_x_continuous(limits=c(41880000,42180000),expand=c(0,0))+
  theme(panel.background=element_rect(fill="white",color="black"),
        panel.grid=element_line(color="black",size=2),
        panel.grid.major=element_line(size=1,linetype =0,color="white"),
        panel.grid.minor=element_line(size=1,linetype =0,color="white"))+
  theme(legend.position = "none")+
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(), 
        axis.ticks.y=element_blank())  

print(plot_snp1,vp=vplayout(1,1))
print(plot_Indel,vp=vplayout(2,1))
print(plot_SVs,vp=vplayout(3,1))
print(plot_ATAC_seq,vp=vplayout(4,1))
print(plot_Chip_seq,vp=vplayout(5,1))
print(plot_AB_Compartment_seq,vp=vplayout(6,1))
print(plot_TAD_seq,vp=vplayout(7,1))
print(plot_Conservation_seq,vp=vplayout(8,1))
print(plot_snp1_ATAC_seq,vp=vplayout(9,1))
print(plot_snp1_Chip_seq,vp=vplayout(10,1))
print(plot_Indel_ATAC_seq,vp=vplayout(11,1))
print(plot_Indel_Chip_seq,vp=vplayout(12,1))

dev.off()