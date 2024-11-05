library(spThin)
setwd('/Users/aishwarya-pringlelab/maxent/')
df <- data.frame(read.csv("GOM_northamerica.csv"))
head(df)

thinned_dataset_full <-
  thin( loc.data = df, 
        lat.col = "latitude", long.col = "longitude", 
        spec.col = "id", 
        thin.par = 10, reps = 100, 
        locs.thinned.list.return = TRUE, 
        write.files = TRUE, 
        max.files = 5, 
        out.dir = "Thinned Files", out.base = "NA_thinned_10km", 
        write.log.file = FALSE,
        log.file = "NA_thinned_full_log_file.txt" )





