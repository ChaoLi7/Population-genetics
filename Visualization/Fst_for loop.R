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

