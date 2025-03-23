# OPENCLASSROOMS - Parcours Data Scientist - Projet n°7
# Implémentez un modèle de scoring - 80 h

------------------------------
## Mission - Élaborez le modèle de scoring
------------------------------

Vous êtes Data Scientist au sein d'une société financière, nommée **"Prêt à dépenser"**, qui propose des crédits à la consommation pour des personnes ayant peu ou pas du tout d'historique de prêt.

L’entreprise souhaite **mettre en œuvre un outil de “scoring crédit” pour calculer la probabilité** qu’un client rembourse son crédit, puis classifier la demande en crédit accordé ou refusé. Elle souhaite donc développer un **algorithme de classification** en s’appuyant sur des sources de données variées (données comportementales, données provenant d'autres institutions financières, etc.)

**Votre mission :**
* Construire un modèle de scoring qui donnera une prédiction sur la probabilité de faillite d'un client de façon automatique.
* Analyser les features qui contribuent le plus au modèle, d’une manière générale (feature importance globale) et au niveau d’un client (feature importance locale), afin, dans un soucis de transparence, de permettre à un chargé d’études de mieux comprendre le score attribué par le modèle.
* Mettre en production le modèle de scoring de prédiction à l’aide d’une API et réaliser une interface de test de cette API.
* Mettre en œuvre une approche globale MLOps de bout en bout, du tracking des expérimentations à l’analyse en production du data drift.

Michaël, votre manager, vous incite à sélectionner un ou des kernels Kaggle pour vous faciliter l’analyse exploratoire, la préparation des données et le feature engineering nécessaires à l’élaboration du modèle de scoring. 

Voici le mail qu’il vous a envoyé.

*Bonjour,*

*Afin de pouvoir faire évoluer régulièrement le modèle, je souhaite tester la mise en œuvre une démarche de type MLOps d’automatisation et d’industrialisation de la gestion du cycle de vie du modèle.*

*Vous trouverez en pièce jointe **la liste d’outils à utiliser** pour créer une plateforme MLOps qui s’appuie sur des outils Open Source.* 

*Je souhaite que vous puissiez mettre en oeuvre au minimum **les étapes orientées MLOps** suivantes :* 
* *Dans le notebook d’entraînement des modèles, générer à l’aide de MLFlow un tracking d'expérimentations*
* *Lancer l’interface web 'UI MLFlow" d'affichage des résultats du tracking*
* *Réaliser avec MLFlow un stockage centralisé des modèles dans un “model registry”*
* *Tester le serving MLFlow*
* *Gérer le code avec le logiciel de version Git*
* *Partager le code sur Github pour assurer une intégration continue*
* *Utiliser Github Actions pour le déploiement continu et automatisé du code de l’API sur le cloud*
* *Concevoir des tests unitaires avec Pytest (ou Unittest) et les exécuter de manière automatisée lors du build réalisé par Github Actions*
 
*J’ai également rassemblé des conseils pour vous aider à vous lancer dans ce projet !*

*Concernant **l’élaboration du modèle** soyez vigilant sur deux points spécifiques au contexte métier :* 
* *Le déséquilibre entre le nombre de bons et de moins bons clients doit être pris en compte pour élaborer un modèle pertinent, avec une méthode au choix*
* *Le déséquilibre du coût métier entre un faux négatif (FN - mauvais client prédit bon client : donc crédit accordé et perte en capital) et un faux positif (FP - bon client prédit mauvais : donc refus crédit et manque à gagner en marge)*
    * *Vous pourrez supposer, par exemple, que le coût d’un FN est dix fois supérieur au coût d’un FP*
    * *Vous créerez un score “métier” (minimisation du coût d’erreur de prédiction des FN et FP) pour comparer les modèles, afin de choisir le meilleur modèle et ses meilleurs hyperparamètres. Attention cette minimisation du coût métier doit passer par l’optimisation du seuil qui détermine, à partir d’une probabilité, la classe 0 ou 1 (un “predict” suppose un seuil à 0.5 qui n’est pas forcément l’optimum)*
    * *En parallèle, maintenez pour comparaison et contrôle des mesures plus techniques, telles que l’AUC et l’accuracy*
 
*D’autre part je souhaite que vous mettiez en œuvre une démarche d’élaboration des modèles avec **Cross-Validation et optimisation des hyperparamètres, via GridsearchCV ou équivalent.***

*Un dernier conseil : si vous obtenez des scores supérieurs au 1er du challenge Kaggle (AUC > 0.82), posez-vous la question si vous n’avez pas de l’overfitting dans votre modèle !*

*Vous exposerez votre **modèle de prédiction sous forme d’une API** qui permet de calculer la probabilité de défaut du client, ainsi que sa classe (accepté ou refusé) en fonction du seuil optimisé d’un point de vue métier.*

***Le déploiement de l’API** sera réalisée sur une plateforme Cloud, de préférence une solution gratuite.*

*Je vous propose d’utiliser un Notebook ou une application Streamlit pour réaliser en local  l’**interface de test de l’API**.*

*Bon courage !*

*Mickael*

------------------------------
## Mission - Intégrez et optimisez le système MLOps
------------------------------

Vous continuez votre mission au sein de "Prêt à dépenser". Deux semaines après votre dernière échange sur l'outil scoring, vous avez bien avancé et Mickael vous envoie un nouveau mail.

*Bonjour,*

*Comme vous avez pu le constater le cycle de vie du modèle n’est pas complet, j’ai oublié dans la démarche MLOps la dernière étape de suivi de la performance du modèle en production. C’est un peu normal car le modèle n’est pas encore en production !*

*En prévision, je souhaiterais que vous testiez l’utilisation de la librairie **evidently** pour détecter dans le futur du **Data Drift** en production. Pour cela vous prendrez comme hypothèse que le dataset “application_train” représente les datas pour la modélisation et le dataset “application_test” représente les datas de nouveaux clients une fois le modèle en production.*

*L’analyse à l’aide d’**evidently** vous permettra de **détecter éventuellement du Data Drift sur les principales features**, entre les datas d’entraînement et les datas de production, au travers du tableau HTML d’analyse que vous aurez généré grâce à evidently.*

*P.S.: Je remets en pièce jointe la même liste d’outils MLOps que je vous ai partagée précédemment.*

*Merci par avance !*

*Mickael*

------------------------------
## Source 
------------------------------

Les données sont disponibles à l’adresse suivante : 

[Lien](https://s3-eu-west-1.amazonaws.com/static.oc-static.com/prod/courses/files/Parcours_data_scientist/Projet+-+Impl%C3%A9menter+un+mod%C3%A8le+de+scoring/Projet+Mise+en+prod+-+home-credit-default-risk.zip)


------------------------------
## Objectifs pédagogiques
------------------------------

  * Définir et mettre en œuvre un pipeline d’entraînement des modèles
  * Définir la stratégie d’élaboration d’un modèle d’apprentissage supervisé
  * Évaluer les performances des modèles d’apprentissage supervisé
  * Mettre en œuvre un logiciel de version de code
  * Suivre la performance d’un modèle en production et en assurer la maintenance
  * Concevoir un déploiement continu d'un moteur d’inférence sur une plateforme Cloud
