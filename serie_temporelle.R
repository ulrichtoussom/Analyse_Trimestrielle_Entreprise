

a - creer le tableau de donnees dans R



donnees <- data.frame(
  annee =rep(2022:2024 , each =4) ,
  trimestre =rep(1:4 , time =3) ,
  ventes = c(120 ,150 , 170 ,130 , 125, 155, 175 ,135, 130 ,160 ,180 ,140)
  
)


head(donnees)

b creer une variable temps 

#ajoute une colonne time a note dataset donnees 
donnees$time = seq.Date(from = as.Date("2022-01-01"), by="quarter" , length.out = nrow(donnees))
head(donnees)
#verifier l'existance des donnees 

serie_ts <-  ts(donnees$ventes , start = c(2022 , 1), frequency = 4)
head(donnees)


#visualiser la serie et detecter la saisonalite 

plot(serie_ts, main= "serie trimestrielle des ventes" , col = 'blue')


# estimer la tendance de progression 

#creer une variable temps numerique
temps <- 1:length(serie_ts)

#regression lineaire 
modele_tendance <- lm(serie_ts ~ temps)

#resumer du modele 
#apres avoir executer summary on trouve les valeur de a et de b entre autre alpha1 et alpha2 
summary(modele_tendance)

# tracer la serie avec la tendance 

plot(serie_ts, main = "serie avec tendance", ylab = "ventes", xlab= "temps", col= "blue")
abline(modele_tendance, col='blue', lwd=2)

#visualiser la tendance 

plot(serie_ts, main = "ventes et tendance", ylab ="ventes", col="darkgray" )
abline(modele_tendance, col="red", lwd = 2)

# les residus 

residus <- residuals(modele_tendance)
residus
#visualer les residus

plot(residus, type='o', col="purple", main = "residus de la tendance", ylab="residu", xlab="Trimestre" )
abline(h=0, lty=2 , col= 'gray')

#etape extraire les camposante (tandance et saison)
# a decomposition active 

decomp <- decompose(serie_ts, type= "additive")
plot(decomp)
#visualisation de la decomposition 



# Etape 6 desaisonnalisation 
#serie desaisonnalite 

serie_desaisonnalisee = serie_ts - decomp$seasonal
#tracer la serie desaisonnalite 

plot(serie_desaisonnalisee, main= "serie desaisonnalisee ", col="darkgreen", ylab="ventes")

#visualisation 
head(serie_desaisonnalisee)

#Etape 7 reconstituer les valeur attendu

valeurs_attendues <- decomp$trend + decomp$seasonal

#creer un vecteur logique pour reperer les valeurs non maquantes 

valide <- !is.na(valeurs_attendues)

# tracer la series observee (complete)
plot(serie_ts,  type="o", col="blue", main="serie observee vs attendue", ylab="ventes", xlab="Temps")

# d - ajouter la serie attendue uniquement la ou elle est definie 

lines(time(serie_ts)[valide], valeurs_attendues[valide], type='o', col="red")

#legende

legend("topleft", legend = c("observee", "reconstituee"), col = ("blue", "red"), lty = 1)





