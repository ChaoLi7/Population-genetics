#mapp 20,9
#data format
#elevation	Latitude	Longitude
#4000	29.65 	93.98 
#4000	29.65 	93.98 
#4000	29.65 	93.98 
#4000	29.65 	93.98 
#4000	29.65 	93.98 
#4000	29.65 	93.98 
#4000	29.65 	93.98 
##########

setwd("path")
library(ggplot2)  
library(ggthemes)
library(dplyr)
library(ggalt)   

world <- map_data("world")
world <- world[world$region != "Antarctica",]    ####去丢南极洲
head(world)  
data <- read_excel("file.xlsx", sheet = "map_data") #3.13、3.06
head(data);dim(data)

gg <- ggplot()
gg <- gg + geom_map(data=world, map=world,
                    aes(x=long, y=lat, map_id=region),
                    color="#7f7f7f", fill="#EBEBEB", size=0.02, alpha=1)
gg+geom_point(aes(data$Longitude,data$Latitude))
gg+geom_point(aes(data$Longitude,data$Latitude,size=data$Count,colour=data$Elevation,alpha=0.1))+
  scale_color_gradientn(values = seq(0,1,0.2),colours = c('#308014','#0000FF','#C71585'))+
  scale_fill_gradientn(values = seq(0,1,0.2),colours = c('#308014','#0000FF','#C71585'))