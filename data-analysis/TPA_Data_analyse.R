library("cluster")
library("tidyverse")

clients <- read.csv("C:/Users/micha/Documents/MBDS/TPA/tpa-paqms-mbds/data-analysis/Clients_10.csv", header = TRUE, sep = ",", dec = ".", stringsAsFactors = T)
immatriculations <- read.csv("C:/Users/micha/Documents/MBDS/TPA/tpa-paqms-mbds/data-analysis/Immatriculations.csv", header = TRUE, sep = ",", dec = ".", stringsAsFactors = T)

clients_immatriculations <- inner_join(clients, immatriculations, by = "immatriculation", relationship = "many-to-many")
#clients_immatriculations <- subset(clients_immatriculations, select = -immatriculation)

#clients_immatriculations_matrix <- daisy(clients_immatriculations)

#clientsimmatriculations_kmeans <- kmeans(clients_immatriculations_matrix, 4)

variables_clustering <- clients_immatriculations %>% select(age, nbEnfantsAcharge, nbPlaces, nbPortes, prix)

scaled_data <- scale(variables_clustering)

wss <- numeric(10)
for (i in 1:10) {
  wss[i] <- sum(kmeans(variables_clustering, centers = i)$withinss)
  print(summary(wss[i]))
}

plot(1:10, wss, type = "b", xlab = "Number of Clusters",
     ylab = "Within groups sum of squares")

k_optimal <- 7

kmeans_result <- kmeans(variables_clustering, centers = k_optimal, nstart = 20)

data$cluster <- as.factor(kmeans_result$cluster)

categories <- c("Familiale", "Sportive", "Citadine")
data$Categorie <- categories[data$cluster]

print(data)
