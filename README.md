# Analyse_Trimestrielle_Entreprise
Méthodologie
L'approche utilisée pour atteindre les objectifs est la suivante :
1.	Identification du schéma de la série temporelle :
o	Des méthodes de visualisation (par exemple, un graphique de la série temporelle) seront utilisées pour observer si la composante saisonnière varie de manière constante (additif) ou proportionnelle (multiplicatif) avec le niveau de la série.
2.	Estimation de la tendance par régression :
o	Un modèle de régression linéaire sera ajusté aux données, avec la variable time comme prédicteur et les ventes comme variable dépendante. Cela permettra de capturer le mouvement à long terme de la série.
3.	Calcul des coefficients saisonniers :
o	La moyenne des ventes pour chaque trimestre sera calculée sur toutes les années disponibles. Ces moyennes seront ensuite normalisées pour obtenir les coefficients saisonniers.
4.	Désaisonnalisation de la série :
o	La série temporelle originale sera désaisonnalisée en supprimant l'influence de la composante saisonnière. Pour un schéma additif, les coefficients saisonniers seront soustraits de la série originale. Pour un schéma multiplicatif, la série originale sera divisée par les coefficients saisonniers.
5.	Prévision des ventes pour 2025 :
o	Le modèle de régression estimé à l'étape 2 sera utilisé pour prévoir la tendance des ventes pour les trimestres 1 et 2 de 2025.
o	Les prévisions de la tendance seront ensuite ajustées en multipliant (si le schéma est multiplicatif) ou en ajoutant (si le schéma est additif) les coefficients saisonniers correspondants pour obtenir les prévisions finales des ventes.
Structure du code
Le code R est organisé comme suit :
1.	Chargement des données :
o	Le dataframe donnees est créé.
2.	Analyse de la série temporelle :
o	Le schéma de la série est identifié (additif ou multiplicatif).
o	La tendance est estimée par régression.
o	Les coefficients saisonniers sont calculés.
o	La série est désaisonnalisée.
o	Les prévisions pour 2025-T1 et 2025-T2 sont générées.
Résultats attendus
À la fin de l'analyse, les résultats suivants seront disponibles :
•	Identification du schéma de la série temporelle (additif ou multiplicatif).
•	Équation du modèle de régression estimé pour la tendance.
•	Coefficients saisonniers pour chaque trimestre.
•	Série temporelle désaisonnalisée.
•	Prévisions des ventes pour le premier et le deuxième trimestre de 2025.

Conclusion
Ce projet fournira une analyse complète des données de ventes trimestrielles, permettant de comprendre les composantes de la série temporelle et de prévoir les ventes futures. Les résultats de cette analyse peuvent être utilisés pour prendre des décisions éclairées concernant la planification des ventes et la gestion des stocks.
