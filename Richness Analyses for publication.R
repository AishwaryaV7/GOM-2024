library(vegan)
library(dplyr)
library(ggplot2)
library(mvabund)

###### by height #####
setwd('/Users/aishwarya-pringlelab/R Studio')
gom3 <- data.frame(read.csv(file = "Unoise_GOM 2024.csv"))
mom <- data.frame((gom3[,8:358]))
mom <- data.frame((gom3[,9:358])) #GOM dropped

mom <- 1*(mom > 1)
mom <- mom[,colSums(mom)!=0]
rich <- specnumber(mom)

mod.rich <- glm(rich ~ gom3$detection, family = "poisson")
summary(mod.rich)

#optional: adding Site as fixed effect 
mod.rich <- glm(rich ~ gom3$Site + gom3$detection, family = "poisson")
summary(mod.rich)

#boxplot for comparing richness by height
boxplot(rich ~ gom3$detection, 
        ylab = "OTU Richness",
        xlab = "" ,
        col = c("goldenrod1","dodgerblue"), 
        names = c("",""), 
        las = 2,
        lwd = 0.8,
)
par(bg=NA)

#look at pairwise affect on individual OTUs
mod.mglm <- manyglm(mom ~ gom3$detection, family = "binomial")
out <- anova(mod.mglm, p.uni = "unadjusted")
sigs <- colnames(mom)[as.vector(out$uni.p[2,] < 0.05)]
out
sigs
write.csv(out$uni.p, file = "sigs.csv")

#optional, dropping gom and using an adjusted p value for the problem of multiple testing
nogom <- data.frame((gom3[,10:358]))
nogom <- 1*(nogom > 1)
nogom <- nogom[,colSums(nogom)!=0]
mod.nogommglm <- manyglm(nogom ~ gom3$detection, family = "binomial")
outnogom <- anova(mod.nogommglm, p.uni = "adjusted")
sigsnogom <- colnames(nogom)[as.vector(outnogom$uni.p[2,] < 0.05)]


#### RICHNESS BY TREE #####
#Richness - the GLM tells you the effect of your independent variable on your dependent variable
# aka GOM presence on richness
setwd('/Users/aishwarya-pringlelab/R Studio')
gom4 <- data.frame(read.csv(file = "Unoise_By Tree_GOM2024.csv"))

mom <- data.frame((gom4[,5:357]))

mom <- 1*(mom > 1)
mom <- mom[,colSums(mom)!=0]
rich <- specnumber(mom)

#means are 26 vs 47
boxplot(rich ~ gom4$detection, 
        ylab = "OTU Richness",
        xlab = "" ,
        col = c("goldenrod1","dodgerblue"), 
        names = c("",""), 
        las = 2,
        lwd = 0.8,
)

#GLM to compare richness between groups - Simple way
mod.rich <- glm(rich ~ gom4$detection, family = "poisson")
summary(mod.rich)

#Validation, comparing models using Likelihood Ratio Test way
mod.rich <- glm(rich ~ gom4$Site + gom4$detection, family = "poisson")
summary(mod.rich)
anova(glm(rich ~ gom4$Site, family = "poisson"), mod.rich, test = "LRT")


#now to look at composition, looking at the effect of GOM on *each* OTU
mod.mglm <- manyglm(mom ~ gom4$detection, family = "binomial")
out <- anova(mod.mglm, p.uni = "unadjusted")
sigs <- colnames(mom)[as.vector(out$uni.p[2,] < 0.05)]
summary(mod.mglm)
sigs
write.csv(out$uni.p, file = "sigs.csv")
# out$uni.p will give you the probability scores of each pairing boxplot

boxplot(rich ~ gom4$detection, 
        ylab = "OTU Richness",
        xlab = "" ,
        col = c("goldenrod1","dodgerblue"), 
        names = c("",""), 
        las = 2,
        lwd = 0.8,
)


