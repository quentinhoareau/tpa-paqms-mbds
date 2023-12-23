library(cluster)
library(ggplot2)
library(tidyverse)

clients <- read.csv("Clients_10.csv", header = TRUE, dec = ".",
                    stringsAsFactors = TRUE)

immatriculations <- read.csv("Immatriculations.csv", header = TRUE, dec = ".",
                             stringsAsFactors = TRUE)

immatriculations <- immatriculations[100000:1500000,]

str(clients)
str(immatriculations)

clients_immatriculations <- merge(clients, immatriculations, by = "immatriculation")
clients_immatriculations[-1]

str(clients_immatriculations)
matrice_distances <- daisy(clients_immatriculations)

# CLUSTERING 

cluster <- kmeans(matrice_distances, 4)

str(cluster$centers)

# PLOT

ggplot(clients_immatriculations, aes(x = nbPlaces, y = nbEnfantsAcharge, color = as.factor(cluster$cluster))) +
  geom_point() +
  scale_color_discrete(name = "Cluster") +
  theme(legend.position = "bottom") +
  labs(x = "Places", y = "Nb Enfants") +
  geom_jitter(width = 0.3, height = 0.3)




