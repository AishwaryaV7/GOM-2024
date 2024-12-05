#Thank you Dale Watt (2018 Summer of Maps Fellow) for providing this code and the accompanying blog post!

#MaxEnt - attempt to create environmental layers
install.packages("raster")
install.packages("rgdal")
install.packages("sf")
install.packages("tidyverse")
install.packages("fasterize")
library(sf)
library(raster)
library(rgdal)
library(tidyverse)
library(rgeos)
library(scales)
library(fasterize)
setwd('/Users/aishwarya-pringlelab/maxent/wc2 - 30sec resolution')
# set up projection parameter for use throughout script
projection <- "+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs"

#set up extent parameter for use throughout script
ext <- extent(-135,-50, 8, 72)

#process for Environmental Variable 1 
# read in raster data
assign(paste0("bio10_", "raw"), raster("croppedbio10.tif"))
assign(paste0("bio12_", "raw"), raster("croppedbio12.tif"))
assign(paste0("bio15_", "raw"), raster("croppedbio15.tif"))

# reproject to our shared parameter
assign(paste0("bio10_", "projected"),
       projectRaster(bio10_raw, crs=projection))
assign(paste0("bio12_", "projected"),
       projectRaster(bio12_raw, crs=projection))
assign(paste0("bio15_", "projected"),
       projectRaster(bio15_raw, crs=projection))

# create variable equal to final raster
assign(paste0("bio10_final"), bio10_projected)
assign(paste0("bio12_final"), bio12_projected)
assign(paste0("bio15_final"), bio15_projected)

# extend elev_final to the desired extent with NA values
bio10_extended <- extend(bio10_final, ext, value=NA)
bio12_extended <- extend(bio12_final, ext, value=NA)
bio15_extended <- extend(bio15_final, ext, value=NA)

#pick a variable as basis for sampling, and resample all
bio10_final_re <- resample(bio10_final, bio10_final)
bio12_final_re <- resample(bio12_final, bio10_final)
bio15_final_re <- resample(bio15_final, bio10_final)

#Next, we have to re-extend the datasets to make sure that their shared extent was not influenced by the resampling.
bio10_tend <- extend(bio10_final_re, ext, value=NA)
bio12_tend <- extend(bio12_final_re, ext, value=NA)
bio15_tend <- extend(bio15_final_re, ext, value=NA)

#Now we have three datasets that are identical in extent, resolution, 
#and many other properties. Our final step is to write out these environmental 
#datasets into the .asc format that the MaxEnt GUI uses.
writeRaster(bio10_tend, filename="cropbio10_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio12_tend, filename="cropbio12_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio15_tend, filename="cropbio15_output.asc", format='ascii', overwrite=TRUE)


#### To do all variables at once #####

assign(paste0("bio1_", "raw"), raster("bio_1.tif"))
assign(paste0("bio2_", "raw"), raster("bio_2.tif"))
assign(paste0("bio3_", "raw"), raster("bio_3.tif"))
assign(paste0("bio4_", "raw"), raster("bio_4.tif"))
assign(paste0("bio5_", "raw"), raster("bio_5.tif"))
assign(paste0("bio6_", "raw"), raster("bio_6.tif"))
assign(paste0("bio7_", "raw"), raster("bio_7.tif"))
assign(paste0("bio8_", "raw"), raster("bio_8.tif"))
assign(paste0("bio9_", "raw"), raster("bio_9.tif"))
assign(paste0("bio10_", "raw"), raster("bio_10.tif"))
assign(paste0("bio11_", "raw"), raster("bio_11.tif"))
assign(paste0("bio12_", "raw"), raster("bio_12.tif"))
assign(paste0("bio13_", "raw"), raster("bio_13.tif"))
assign(paste0("bio14_", "raw"), raster("bio_14.tif"))
assign(paste0("bio15_", "raw"), raster("bio_15.tif"))
assign(paste0("bio16_", "raw"), raster("bio_16.tif"))
assign(paste0("bio17_", "raw"), raster("bio_17.tif"))
assign(paste0("bio18_", "raw"), raster("bio_18.tif"))
assign(paste0("bio19_", "raw"), raster("bio_19.tif"))

assign(paste0("bio1_", "projected"),
       projectRaster(bio1_raw, crs=projection))
assign(paste0("bio2_", "projected"),
       projectRaster(bio2_raw, crs=projection))
assign(paste0("bio3_", "projected"),
       projectRaster(bio3_raw, crs=projection))
assign(paste0("bio4_", "projected"),
       projectRaster(bio4_raw, crs=projection))
assign(paste0("bio5_", "projected"),
       projectRaster(bio5_raw, crs=projection))
assign(paste0("bio6_", "projected"),
       projectRaster(bio6_raw, crs=projection))
assign(paste0("bio7_", "projected"),
       projectRaster(bio7_raw, crs=projection))
assign(paste0("bio8_", "projected"),
       projectRaster(bio8_raw, crs=projection))
assign(paste0("bio9_", "projected"),
       projectRaster(bio9_raw, crs=projection))
assign(paste0("bio10_", "projected"),
       projectRaster(bio10_raw, crs=projection))
assign(paste0("bio11_", "projected"),
       projectRaster(bio11_raw, crs=projection))
assign(paste0("bio12_", "projected"),
       projectRaster(bio12_raw, crs=projection))
assign(paste0("bio13_", "projected"),
       projectRaster(bio13_raw, crs=projection))
assign(paste0("bio14_", "projected"),
       projectRaster(bio14_raw, crs=projection))
assign(paste0("bio15_", "projected"),
       projectRaster(bio15_raw, crs=projection))
assign(paste0("bio16_", "projected"),
       projectRaster(bio16_raw, crs=projection))
assign(paste0("bio17_", "projected"),
       projectRaster(bio17_raw, crs=projection))
assign(paste0("bio18_", "projected"),
       projectRaster(bio18_raw, crs=projection))
assign(paste0("bio19_", "projected"),
       projectRaster(bio19_raw, crs=projection))

assign(paste0("bio1_final"), bio1_projected)
assign(paste0("bio2_final"), bio1_projected)
assign(paste0("bio3_final"), bio1_projected)
assign(paste0("bio4_final"), bio1_projected)
assign(paste0("bio5_final"), bio1_projected)
assign(paste0("bio6_final"), bio1_projected)
assign(paste0("bio7_final"), bio1_projected)
assign(paste0("bio8_final"), bio1_projected)
assign(paste0("bio9_final"), bio1_projected)
assign(paste0("bio10_final"), bio10_projected)
assign(paste0("bio11_final"), bio1_projected)
assign(paste0("bio12_final"), bio12_projected)
assign(paste0("bio13_final"), bio1_projected)
assign(paste0("bio14_final"), bio1_projected)
assign(paste0("bio15_final"), bio15_projected)
assign(paste0("bio16_final"), bio1_projected)
assign(paste0("bio17_final"), bio1_projected)
assign(paste0("bio18_final"), bio1_projected)
assign(paste0("bio19_final"), bio1_projected)

bio1_extended <- extend(bio1_final, ext, value=NA)
bio2_extended <- extend(bio2_final, ext, value=NA)
bio3_extended <- extend(bio3_final, ext, value=NA)
bio4_extended <- extend(bio4_final, ext, value=NA)
bio5_extended <- extend(bio5_final, ext, value=NA)
bio6_extended <- extend(bio6_final, ext, value=NA)
bio7_extended <- extend(bio7_final, ext, value=NA)
bio8_extended <- extend(bio8_final, ext, value=NA)
bio9_extended <- extend(bio9_final, ext, value=NA)
bio10_extended <- extend(bio10_final, ext, value=NA)
bio11_extended <- extend(bio11_final, ext, value=NA)
bio12_extended <- extend(bio12_final, ext, value=NA)
bio13_extended <- extend(bio13_final, ext, value=NA)
bio14_extended <- extend(bio14_final, ext, value=NA)
bio15_extended <- extend(bio15_final, ext, value=NA)
bio16_extended <- extend(bio16_final, ext, value=NA)
bio17_extended <- extend(bio17_final, ext, value=NA)
bio18_extended <- extend(bio18_final, ext, value=NA)
bio19_extended <- extend(bio19_final, ext, value=NA)

bio1_final_re <- resample(bio1_final, bio19_final)
bio2_final_re <- resample(bio2_final, bio19_final)
bio3_final_re <- resample(bio3_final, bio19_final)
bio4_final_re <- resample(bio4_final, bio19_final)
bio5_final_re <- resample(bio5_final, bio19_final)
bio6_final_re <- resample(bio6_final, bio19_final)
bio7_final_re <- resample(bio7_final, bio19_final)
bio8_final_re <- resample(bio8_final, bio19_final)
bio9_final_re <- resample(bio9_final, bio19_final)
bio10_final_re <- resample(bio10_final, bio10_final)
bio11_final_re <- resample(bio11_final, bio19_final)
bio12_final_re <- resample(bio12_final, bio10_final)
bio13_final_re <- resample(bio13_final, bio19_final)
bio14_final_re <- resample(bio14_final, bio19_final)
bio15_final_re <- resample(bio15_final, bio10_final)
bio16_final_re <- resample(bio16_final, bio19_final)
bio17_final_re <- resample(bio17_final, bio19_final)
bio18_final_re <- resample(bio18_final, bio19_final)
bio19_final_re <- resample(bio19_final, bio19_final)

bio1_tend <- extend(bio1_final_re, ext, value=NA)
bio2_tend <- extend(bio2_final_re, ext, value=NA)
bio3_tend <- extend(bio3_final_re, ext, value=NA)
bio4_tend <- extend(bio4_final_re, ext, value=NA)
bio5_tend <- extend(bio5_final_re, ext, value=NA)
bio6_tend <- extend(bio6_final_re, ext, value=NA)
bio7_tend <- extend(bio7_final_re, ext, value=NA)
bio8_tend <- extend(bio8_final_re, ext, value=NA)
bio9_tend <- extend(bio9_final_re, ext, value=NA)
bio10_tend <- extend(bio10_final_re, ext, value=NA)
bio11_tend <- extend(bio11_final_re, ext, value=NA)
bio12_tend <- extend(bio12_final_re, ext, value=NA)
bio13_tend <- extend(bio13_final_re, ext, value=NA)
bio14_tend <- extend(bio14_final_re, ext, value=NA)
bio15_tend <- extend(bio15_final_re, ext, value=NA)
bio16_tend <- extend(bio16_final_re, ext, value=NA)
bio17_tend <- extend(bio17_final_re, ext, value=NA)
bio18_tend <- extend(bio18_final_re, ext, value=NA)
bio19_tend <- extend(bio19_final_re, ext, value=NA)

writeRaster(bio1_tend, filename="bio1_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio2_tend, filename="bio2_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio3_tend, filename="bio3_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio4_tend, filename="bio4_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio5_tend, filename="bio5_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio6_tend, filename="bio6_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio7_tend, filename="bio7_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio8_tend, filename="bio8_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio9_tend, filename="bio9_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio10_tend, filename="bio10_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio11_tend, filename="bio11_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio12_tend, filename="bio12_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio13_tend, filename="bio13_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio14_tend, filename="bio14_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio15_tend, filename="bio15_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio16_tend, filename="bio16_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio17_tend, filename="bio17_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio18_tend, filename="bio18_output.asc", format='ascii', overwrite=TRUE)
writeRaster(bio19_tend, filename="bio19_output.asc", format='ascii', overwrite=TRUE)

##### Trying to separate out bands in a megaraster ####
#separate out individuals bands from mega-raster (like the future bioclimate file)

library(raster)
r <- stack("wc2.1_2.5m_bioc_BCC-CSM2-MR_ssp370_2021-2040.tif")
nlayers(r)
for(i in 1:nlayers(r)){
  band <- r[[i]]
  writeRaster(band,paste('band',i,'.tif', sep=''))
}

