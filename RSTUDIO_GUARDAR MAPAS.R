rm(list = ls())
#setwd("")

gpklink = file.choose()

library(sf)
library(ggplot2)

map1=read_sf(gpklink, layer = "mapa_seattle")

map1gg=ggplot() + theme_bw() + geom_sf(data = map1, fill = 'pink', color = 'black', linewidth = 0.5)
map1gg

saveRDS(map1gg,file='MAPA1.rds')
#--------------------------------------------------------
map2=read_sf(gpklink, layer = "centros_educativos")

map2gg=ggplot() + theme_void() + geom_sf(data = map1, fill = 'pink', color = 'black') + geom_sf(data = map2, color = 'blue', size = 1)
map2gg

saveRDS(map2gg,file='MAPA2.rds')
#---------------------------------------------------------
map3=read_sf(gpklink, layer = "gasolineras_inventario")

map3gg=ggplot() + theme_void() + geom_sf(data = map1, fill = 'pink', color = 'black') + geom_sf(data = map3, color = 'darkgreen', size = 1.5)
map3gg

saveRDS(map3gg,file='MAPA3.rds')
#----------------------------------------------------------
map4=read_sf(gpklink, layer = "propuesta_centroides")

map4gg=ggplot() + 
  theme_void() + 
  geom_sf(data = map1, fill = 'pink', color = 'black') + 
  geom_sf(data = map3, aes(color = fclass), size = 1.5) + 
  geom_sf(data = map4, color = 'blue', size = 3, shape = 17) +
  scale_color_manual(values = c("Bien ubicadas" = "darkgreen", "Mal ubicadas (<200m)" = "red"))

map4gg

saveRDS(map4gg,file='MAPA4.rds')