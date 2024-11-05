library(vegan)
library(dplyr)
library(ggplot2)

setwd('/Users/aishwarya-pringlelab/R Studio')
gom3 <- data.frame(read.csv(file = "Unoise_GOM 2024.csv")) #by height
gom6 <- data.frame(read.csv(file = "DropGOMtest.csv")) #dropped GOM and the heights that only had GOM

### turning vectors into variables #### 
#because it wont BECAUSE THEY'RE NUMERICAL,
#words should be automatically treated as factors
gom3$ttmt<-as.factor(gom3$ttmt)
levels(gom3$ttmt)
gom3$tree<-as.factor(gom3$tree)
levels(gom3$tree)
gom3$ht<-as.factor(gom3$ht)
levels(gom3$ht)

##### Matrix Calculation ####

gom.mat <- gom3[,9:358] #10 is GOM dropped
 
#drop columns that sum to zero - ~100 OTU's get dropped
gom.mat <- gom.mat[,colSums(gom.mat)>0]
gom.mat[gom.mat>0]<-1

#calculate the distance, raupcrick method 1 - 
gomraup <- raupcrick(gom.mat, null="r1", nsimul=999, chase=FALSE)

#### NMDS ####
gomraup.nmds<-metaMDS(gomraup, k=4, autotransform=FALSE, wascores=F, trymax=300)
plot(gomraup.nmds$points, xlab='NMDS axis 1', ylab="NMDS axis 2", cex = 0, xlim = c(-1.15,1.0), ylim = c(-1.0, 1.0))
points(gomraup.nmds$points[gom3$detection=="detected",1],gomraup.nmds$points[gom3$detection=="detected",2], pch= 19, cex = 0.8, col = 'darkgoldenrod1', lwd = 2)
points(gomraup.nmds$points[gom3$detection=="undetected",1],gomraup.nmds$points[gom3$detection=="undetected",2], pch= 19, cex = 0.8, col = 'dodgerblue',lwd = 1.5)

ordiellipse(gomraup.nmds$points, groups = gom3$detection, show.groups = "detected", 
            draw = "polygon", col = "goldenrod1", kind = "sd", conf = 0.85, lwd = 0.01, alpha = 80) 
ordiellipse(gomraup.nmds$points, groups = gom3$detection, show.groups = "undetected", 
            draw = "polygon", col = "dodgerblue", kind = "sd", conf = 0.85, lwd = 0.01, alpha = 80)



## Testing the stress of the NMDS. > 0.1 is great, >0.2 is okay, >0.3 no good
gomraup.nmds$stress

#### permanova to test differences in community composition #### 

gomD<-adonis2(gomraup~gom3$detection, permutations=9999)
gomD
#dropGOM test
gomH<-adonis2(gomraup~gom6$detection, permutations=9999)
gomH

#betadisper
betadisper <- betadisper(gomraup, gom3$detection)
gomB<-anova(betadisper)
gomB

######## All the same code, but "by tree" this time ####
# NOTE! I didn't change the names of the dataframe, or nmds object so this 
# should be re-run all together.
gom4 <- data.frame(read.csv(file = "Unoise_By Tree_GOM2024.csv"))

#make a matrix? 6 when dropping GOM
gom.mat <- gom4[,5:357]

#drop columns that sum to zero 
gom.mat <- gom.mat[,colSums(gom.mat)>0]
gom.mat[gom.mat>0]<-1

#calculate the distance, raupcrick method 1 - 
gomraup <- raupcrick(gom.mat, null="r1", nsimul=999, chase=FALSE)
#gom.nmds <- metaMDS(gom.mat, "raup", trymax = 100)
gomraup.nmds<-metaMDS(gomraup, k=3, autotransform=FALSE, wascores=F, trymax=100)
plot(gomraup.nmds$points[,c(1,2)], xlab='NMDS axis 1', ylab="NMDS axis 2")
points(gomraup.nmds$points[gom4$detection=="detected",1],gomraup.nmds$points[gom4$detection=="detected",2], pch= 19, cex = 1, col = 'darkgoldenrod1', lwd = 2)
points(gomraup.nmds$points[gom4$detection=="undetected",1],gomraup.nmds$points[gom4$detection=="undetected",2], pch= 19, cex = 1, col = 'dodgerblue', bg= 'white',lwd = 1.5)
ordiellipse(gomraup.nmds$points[,c(1,2)], groups = gom4$detection, show.groups = "detected", 
            draw = "polygon", col = "goldenrod1", kind = "sd", conf = 0.8, lwd = 0.01) 
ordiellipse(gomraup.nmds$points[,c(1,2)], groups = gom4$detection, show.groups = "undetected", 
            draw = "polygon", col = "dodgerblue", kind = "sd", conf = 0.8, lwd = 0.01, alpha = 50)

#permanova testing adonis.
gomTree<-adonis2(gomraup~gom4$detection, permutations=9999)
gomTree

#betadiver
betadisperTree <- betadisper(gomraup, gom4$detection)
gomZ<-anova(betadisperTree)
gomZ 

## STRESS!
gomraup.nmds$stress
