rm(list = ls())
# Selecciona el archivo 'seattle_analisis.gpkg' desde tu computadora
gpklink = file.choose()

library(sf)
library(ggplot2)

# 1. CARGAR LAS CAPAS DESDE EL GEOPACKAGE
map1        = read_sf(gpklink, layer = "mapa_seattle")
colegios    = read_sf(gpklink, layer = "centros_educativos")
g_totales   = read_sf(gpklink, layer = "gasolineras_totales")  # Tus 125 estaciones
g_buenas    = read_sf(gpklink, layer = "gasolineras_buenas")   # Las 122 que cumplen
g_malas     = read_sf(gpklink, layer = "gasolineras_malas")    # Las 3 que violan la norma
propuestas  = read_sf(gpklink, layer = "propuesta_centroides") # Tus 3 nuevos centroides

# =================================================================
# MAPA 1: Solo la base de la ciudad
# =================================================================
map1gg = ggplot() + 
  theme_bw() + 
  geom_sf(data = map1, fill = 'pink', color = 'black', linewidth = 0.5)

map1gg
saveRDS(map1gg, file='MAPA1.rds')

# =================================================================
# MAPA 2: La base + los puntitos de los colegios
# =================================================================
map2gg = ggplot() + 
  theme_void() + 
  geom_sf(data = map1, fill = 'pink', color = 'black') + 
  geom_sf(data = colegios, color = 'blue', size = 1.2)

map2gg
saveRDS(map2gg, file='MAPA2.rds')

# =================================================================
# MAPA 3: La base + TODAS las estaciones de gasolina totales
# =================================================================
map3gg = ggplot() + 
  theme_void() + 
  geom_sf(data = map1, fill = 'pink', color = 'black') + 
  geom_sf(data = g_totales, color = 'darkgreen', size = 1.2)

map3gg
saveRDS(map3gg, file='MAPA3.rds')

# =================================================================
# MAPA 4: El gran mapa final de diagnóstico y solución
# =================================================================
map4gg = ggplot() + 
  theme_void() + 
  geom_sf(data = map1, fill = 'pink', color = 'black') + 
  geom_sf(data = g_buenas, aes(color = "Bien ubicadas", shape = "Bien ubicadas"), size = 1.8) +       
  geom_sf(data = g_malas, aes(color = "Mal ubicadas (<200m)", shape = "Mal ubicadas (<200m)"), size = 1.8) +              
  geom_sf(data = propuestas, aes(color = "Ubicación propuesta", shape = "Ubicación propuesta"), size = 2) +
  scale_color_manual(name = "Leyenda", 
                     values = c("Bien ubicadas" = "darkgreen", 
                                "Mal ubicadas (<200m)" = "red", 
                                "Ubicación propuesta" = "blue")) +
  scale_shape_manual(name = "Leyenda", 
                     values = c("Bien ubicadas" = 16, 
                                "Mal ubicadas (<200m)" = 16, 
                                "Ubicación propuesta" = 17)) +
  theme(legend.position = "right",
        legend.background = element_rect(fill = "white", color = "gray"))

map4gg
saveRDS(map4gg, file='MAPA4.rds')