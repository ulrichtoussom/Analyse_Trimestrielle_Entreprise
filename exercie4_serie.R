

#exercice 4 

# identifier s'il s'agit d'un schema addittfif ou multipliatif 

donnees <- data.frame(
  annee =rep(2023:2024 , each =4) ,
  trimestre =rep(1:4 , time =2) ,
  ventes = c(20, 30, 60, 25, 22, 33, 66, 27)
  
)

head(donnees)


#ajoutons un collone temps a notre datset 

donnees$time = seq.Date(from = as.Date("2023-01-01"), by="quarter" , length.out = nrow(donnees))
head(donnees)
#verifier l'existence de donnees 

serie_ts <- ts(donnees$ventes , start = c(2023 , 1), frequency = 4)
head(donnees)

#verifions la serie et detection la saisonnalite 
plot(serie_ts, main= "serie trimestrielle des ventes" , col = 'blue')

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


# les residus 

residus <- residuals(modele_tendance)
residus
plot(residus, type='o', col="purple", main = "residus de la tendance", ylab="residu", xlab="Trimestre" )
abline(h=0, lty=2 , col= 'gray')

#etape extraire les camposante (tandance et saison)
# a decomposition active 

decomp <- decompose(serie_ts, type= "additive")
#saisonnaite <- decomp$
plot(decomp)
#visualisation de la decomposition 



# Etape 6 desaisonnalisation 
#serie desaisonnalite 

serie_desaisonnalisee = serie_ts - decomp$seasonal
saisonalite = decomp$seasonal
#tracer la serie desaisonnalite 

plot(serie_desaisonnalisee, main= "serie desaisonnalisee ", col="darkgreen", ylab="ventes")


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
head(valeurs_attendues)

#Etape 8 Lisser avec les moyennes mobiles

mm <- rollmean(serie_ts, k=4, align="center", fill=NA)
lines(mm, col='orange', lwd=2)

#Etape 9 Prevoir T1 et T2 2025

temps_futur <- data.frame(temps = 9:10)
previsions_tendance  <- predict(modele_tendance, newdata = temps_futur)

previsions_tendance[1]

previsions_tendance[2]
#ajoutons les composant saisonnaier 
coef_sais <- saisonalite

saisons <- tapply(saisonalite, coef_sais , mean )
saisons
sais_T1 <- saisons[1]
sais_T2 <- saisons[2]

#Les previsions 

previsions_T1_2025 <- previsions_tendance[1] + sais_T1
previsions_T2_2025 <- previsions_tendance[2] + sais_T2
previsions_T1_2025

#Etapes visualissation des previsions 

ts_future <- ts(c(serie_ts, previsions_T1_2025, previsions_T2_2025), start(2023,1), frequency = 4)
plot(ts_future, type="o", col="blue", main ="serie + previsions T1/T2 2025")
                
                












