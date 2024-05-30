#expression correlation matrix
			 
  setwd("/bin/expression")
  test <- read.table(file='expression.tsv',header = T)
  expression_corr <- cor(test[,2:27], method = 'spearman')  
  
  library(pheatmap)
  library(RColorBrewer)
  b<-as.matrix(expression_corr)
  pheatmap(b,
           cluster_rows = T,
           cluster_cols = T,
           border_color="NA",
           show_rownames = TRUE, 
           color = colorRampPalette(c("#FFFFC8","#F5A100","#7D0025"))(50),
           main = 'Heatmap')
  #boarder
  library(corrplot)
  corrplot(corr = b)
