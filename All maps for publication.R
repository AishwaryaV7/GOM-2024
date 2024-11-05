##### Developing maps by year of community science observations of GOM ####
library(ggplot2)
library(sf)
library(rnaturalearth)
#set working directory
setwd()

# 1) Manually downloaded observations from Inaturalist and MushroomObserver and applied
# the following filters: years: 2016-2023, observation #, longitude, latitude, date observed
my_df <- data.frame(read.csv(file = "iNat_MO_observations_2023.csv"))

#download the countries that you want. Note the "ne_states" returns the states/territories of the countries
state_prov <- rnaturalearth::ne_states(c("united states of america", "canada", "mexico"), returnclass="sf")

# this following list is splitting the dataset by year and what states GOM was in. States were
# manually input after plotting the datapoints. this list creates the yellow states in Fig.3 of Veerabahu et al. 2025
invaded_p1 <- subset(state_prov, name %in% c("Wisconsin","Iowa", "New York", "Michigan", 
                                          "Illinois"))
invaded_p2 <- subset(state_prov, name %in% c("Wisconsin","Iowa", "New York", "Michigan", 
                                             "Illinois", "Ohio", "Pennsylvania"))
invaded_p3 <- subset(state_prov, name %in% c("Wisconsin","Iowa", "New York", "Michigan", 
                                             "Illinois", "Ohio", "Pennsylvania",
                                             "Maryland", "Delaware", "Indiana", "Ontario",
                                             "Minnesota"))
invaded_p4 <- subset(state_prov, name %in% c("Wisconsin","Iowa", "New York", "Michigan", 
                                             "Illinois", "Ohio", "Pennsylvania",
                                             "Maryland", "Delaware", "Indiana", "Ontario",
                                             "Colorado", "Vermont", "Virginia",
                                             "Minnesota", "Massachusetts"))
invaded_p5 <- subset(state_prov, name %in% c("Wisconsin","Iowa", "New York", "Michigan", 
                                             "Illinois", "Ohio", "Pennsylvania",
                                             "Maryland", "Delaware", "Indiana", "Ontario",
                                             "Colorado", "Vermont", "Virginia",
                                             "Minnesota", "Massachusetts", "Nebraska",
                                             "Connecticut"))
invaded_p6 <- subset(state_prov, name %in% c("Wisconsin","Iowa", "New York", "Michigan", 
                                             "Illinois", "Ohio", "Pennsylvania",
                                             "Maryland", "Delaware", "Indiana", "Ontario",
                                             "Colorado", "Vermont", "Virginia",
                                             "Minnesota", "Massachusetts", "Nebraska",
                                             "Connecticut", "New Jersey"))
invaded_p7 <- subset(state_prov, name %in% c("Wisconsin","Iowa", "New York", "Michigan", 
                                             "Illinois", "Ohio", "Pennsylvania",
                                             "Maryland", "Delaware", "Indiana", "Ontario",
                                             "Colorado", "Vermont", "Virginia",
                                             "Minnesota", "Massachusetts", "Nebraska",
                                             "Connecticut", "New Jersey", "Missouri",
                                             "Kansas", "Texas"))
invaded_p8 <- subset(state_prov, name %in% c("Wisconsin","Iowa", "New York", "Michigan", 
                                             "Illinois", "Ohio", "Pennsylvania",
                                             "Maryland", "Delaware", "Indiana", "Ontario",
                                             "Colorado", "Vermont", "Virginia",
                                             "Minnesota", "Massachusetts", "Nebraska",
                                             "Connecticut", "New Jersey", "Missouri",
                                             "Kansas", "Texas", "Tennessee",
                                             "New Hampshire"))

#this list subsets the observation data points by year
p1_df <- subset(my_df, year == "2016")
p2_df <- subset(my_df, year == "2017")
p3_df <- subset(my_df, year == "2018")
p4_df <- subset(my_df, year == "2019")
p5_df <- subset(my_df, year == "2020")
p6_df <- subset(my_df, year == "2021")
p7_df <- subset(my_df, year == "2022")
p8_df <- subset(my_df, year == "2023")

#create each map of GOM observed that year
p1 <- ggplot(data=state_prov) + 
  geom_sf(fill="white", lwd = 0.2, colour = "lightgrey")+
  geom_sf(data = invaded_p1, fill= "yellow", alpha = 0.5) +#, colour = "lightgrey")
  coord_sf(xlim=c(-110, -65), ylim=c(25, 50)) +
  geom_point(data = p1_df, mapping = aes(x=longitude, y=latitude), color = "orange", size = 3,alpha = 0.6, stroke = 0) +
  theme_void() +
  theme(panel.background = element_rect(color = "black", fill = "grey90"))+
  scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(expand=c(0,0))
  ggsave(p1, filename="map1.png", width=8, height=4.64)
p1 #view map

p2 <- ggplot(data=state_prov) + 
  geom_sf(fill="white", lwd = 0.2, colour = "lightgrey")+
  geom_sf(data = invaded_p2, fill= "yellow", alpha = 0.5)+
  coord_sf(xlim=c(-110, -65), ylim=c(25, 50)) +
  geom_point(data = p2_df, mapping = aes(x=longitude, y=latitude), color = "orange", size = 3,alpha = 0.6, stroke = 0) +
  theme_void()+
  theme(panel.background = element_rect(color = "black", fill = "grey90"))+   scale_x_continuous(expand=c(0,0)) +
  scale_y_continuous(expand=c(0,0))
  ggsave(p2, filename="map2.png", width=8, height=4.64)
p2

p3 <- ggplot(data=state_prov) + 
  geom_sf(fill="white", lwd = 0.2, colour = "lightgrey")+
  geom_sf(data = invaded_p3, fill= "yellow", alpha = 0.5)+
  coord_sf(xlim=c(-110, -65), ylim=c(25, 50)) +
  geom_point(data = p3_df, mapping = aes(x=longitude, y=latitude), color = "orange", size = 3,alpha = 0.6, stroke = 0) +
  theme_void()+
  theme(panel.background = element_rect(color = "black", fill = "grey90"))+
  scale_x_continuous(expand=c(0,0)) +   scale_y_continuous(expand=c(0,0))
ggsave(p3, filename="map3.png", width=8, height=4.64)
p3

p4 <- ggplot(data=state_prov) + 
  geom_sf(fill="white", lwd = 0.2, colour = "lightgrey")+
  geom_sf(data = invaded_p4, fill= "yellow", alpha = 0.5)+
  coord_sf(xlim=c(-110, -65), ylim=c(25, 50)) +
  geom_point(data = p4_df, mapping = aes(x=longitude, y=latitude), color = "orange", size = 3,alpha = 0.6, stroke = 0) +
  theme_void()+
  theme(panel.background = element_rect(color = "black", fill = "grey90"))+
  scale_x_continuous(expand=c(0,0)) +   scale_y_continuous(expand=c(0,0))
ggsave(p4, filename="map4.png", width=8, height=4.64)
p4

p5 <- ggplot(data=state_prov) + 
  geom_sf(fill="white", lwd = 0.2, colour = "lightgrey")+
  geom_sf(data = invaded_p5, fill= "yellow", alpha = 0.5)+
  coord_sf(xlim=c(-110, -65), ylim=c(25, 50)) +
  geom_point(data = p5_df, mapping = aes(x=longitude, y=latitude), color = "orange", size = 3,alpha = 0.6, stroke = 0) +
  theme_void()+
  theme(panel.background = element_rect(color = "black", fill = "grey90"))+
  scale_x_continuous(expand=c(0,0)) +   scale_y_continuous(expand=c(0,0))
ggsave(p5, filename="map5.png", width=8, height=4.64)
p5

p6 <- ggplot(data=state_prov) + 
  geom_sf(fill="white", lwd = 0.2, colour = "lightgrey")+
  geom_sf(data = invaded_p6, fill= "yellow", alpha = 0.5)+
  coord_sf(xlim=c(-110, -65), ylim=c(25, 50)) +
  geom_point(data = p6_df, mapping = aes(x=longitude, y=latitude), color = "orange", size = 3,alpha = 0.4, stroke = 0) +
  theme_void()+
  theme(panel.background = element_rect(color = "black", fill = "grey90"))+
  scale_x_continuous(expand=c(0,0)) +   scale_y_continuous(expand=c(0,0))
ggsave(p6, filename="map6.png", width=8, height=4.64)
p6

p7 <- ggplot(data=state_prov) + 
  geom_sf(fill="white", lwd = 0.2, colour = "lightgrey")+
  geom_sf(data = invaded_p7, fill= "yellow", alpha = 0.5)+
  coord_sf(xlim=c(-110, -65), ylim=c(25, 50)) +
  geom_point(data = p7_df, mapping = aes(x=longitude, y=latitude), color = "orange", size = 3,alpha = 0.4, stroke = 0) +
  theme_void()+
  theme(panel.background = element_rect(color = "black", fill = "grey90"))+
  scale_x_continuous(expand=c(0,0)) +   scale_y_continuous(expand=c(0,0))
ggsave(p7, filename="map7.png", width=8, height=4.64)
p7

p8 <- ggplot(data=state_prov) + 
  geom_sf(fill="white", lwd = 0.2, colour = "lightgrey")+
  geom_sf(data = invaded_p8, fill= "yellow", alpha = 0.5)+
  coord_sf(xlim=c(-110, -65), ylim=c(25, 50)) +
  geom_point(data = p8_df, mapping = aes(x=longitude, y=latitude), color = "orange", size = 3,alpha = 0.4, stroke = 0) +
  theme_void() +
  theme(panel.background = element_rect(color = "black", fill = "grey90"))+
  scale_x_continuous(expand=c(0,0)) +   scale_y_continuous(expand=c(0,0))
ggsave(p8, filename="map8.png", width=8, height=4.64)
p8

#ggsave("p1.pdf", width = 84, height = 58.8, units = 'mm', dpi = 300)

##### World Map plotting GOM in the native and Invasive Range ####

#retrieve world map, outlined by country
world <- rnaturalearth::ne_countries(scale = 'medium', returnclass = c("sf","sv"))

# 1) Reached out to collaborators in Asia for curated/confirmed records of Pleurotus citrinopileatus
# in the native Asian range
# 2) Manually downloaded iNaturalist and Mushroom Observer observations of Pleurotus citrinopileatus
# and filtered out observations of cultivated GOM and incorrectly identified as GOM

#create data frame of observations with 3 columns: observation #, latitude, longitude
ranges <- data.frame(read.csv(file = "Native and Invasive Ranges Combined.csv"))

#create plot object of map with plotted points of observations
GOM_world <- ggplot()+
  geom_sf(data = world, fill = "white", colour = "lightgrey", lwd = 0.2)+
  geom_point(data = ranges, mapping = aes(x=Longitude, y=Latitude, group = Range, color = Range), size = 1.5)+
  scale_color_manual(values = c("orange", "green4"))+
  coord_sf(xlim=c(-160, 160), ylim=c(0, 80))+
  theme(panel.background = element_rect(fill = "lightgrey"))

#view plot object
GOM_world 

