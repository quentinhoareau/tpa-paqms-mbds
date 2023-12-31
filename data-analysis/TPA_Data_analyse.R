install.packages(c("cluster", "rpart", "C50", "tree", "ggplot2"))

library(cluster)
library(rpart)
library(C50)
library(tree)
library(ggplot2)


clients <- read.csv("./Clients_clean.csv", header = TRUE, sep = ",", dec = ".", stringsAsFactors = T)
immatriculations <- read.csv("./Immatriculations.csv", header = TRUE, sep = ",", dec = ".", stringsAsFactors = T)
nouveaux_clients <- read.csv("./Marketing.csv", header = TRUE, sep = ",", dec = ".", stringsAsFactors = T)

clients_immatriculations <- merge(clients, immatriculations, by = "immatriculation")

features <- clients_immatriculations[, c("age", "taux", "nbEnfantsAcharge", "puissance", "nbPlaces", "nbPortes", "prix")]

set.seed(123)
k_values <- 1:10
withinss <- numeric(length(k_values))

for (k in k_values) {
  kmeans_result <- kmeans(features, centers = k)
  withinss[k] <- kmeans_result$tot.withinss
}

elbow_plot <- data.frame(K = k_values, Withinss = withinss)
ggplot(elbow_plot, aes(x = K, y = Withinss)) +
  geom_line() +
  geom_point() +
  labs(title = "Graphique de Coude",
       x = "Nombre de Clusters (K)",
       y = "Somme des Carrés Intra-Cluster (Withinss)")

kmeans_result <- kmeans(features, centers = 6)
clients_immatriculations$cluster <- kmeans_result$cluster

for (i in 1:7) {
  boxplot(features[, i] ~ kmeans_result$cluster, main = paste("Variable", i), xlab = "Cluster", ylab = names(features)[i])
}

cluster_categories <- c("Berline", "Familiale", "Sportive", "Citadine", "Compacte", "Break")
clients_immatriculations$Categorie <- cluster_categories[clients_immatriculations$cluster]

clients <- merge(clients, clients_immatriculations[, c("immatriculation", "Categorie")], by = "immatriculation")

set.seed(456)
indices_train <- sample(nrow(clients), 0.8 * nrow(clients))
ensemble_apprentissage <- clients[indices_train, ]
ensemble_test <- clients[-indices_train, ]

ensemble_apprentissage$Categorie <- as.factor(ensemble_apprentissage$Categorie)
ensemble_apprentissage <- na.omit(ensemble_apprentissage)

modele_rpart <- rpart(Categorie ~ age + taux + nbEnfantsAcharge, data = ensemble_apprentissage)
taux_succes_rpart <- sum(predict(modele_rpart, ensemble_test, type = "class") == ensemble_test$Categorie) / nrow(ensemble_test)

modele_C50 <- C5.0(Categorie ~ age + taux + nbEnfantsAcharge, data = ensemble_apprentissage)
taux_succes_C50 <- sum(predict(modele_C50, ensemble_test) == ensemble_test$Categorie) / nrow(ensemble_test)

modele_tree <- tree(Categorie ~ age + taux + nbEnfantsAcharge, data = ensemble_apprentissage)
taux_succes_tree <- sum(predict(modele_tree, ensemble_test) == ensemble_test$Categorie) / nrow(ensemble_test)

nouveaux_clients$Categorie <- predict(modele_C50, nouveaux_clients)

write.csv(nouveaux_clients, "./Results.csv", row.names = FALSE)
