🚗 AvitoCar_dbt

Ce projet vise à construire un entrepôt de données moderne pour les annonces automobiles Avito (Maroc) et générer des insights business exploitables via Power BI.

Les données proviennent du dataset Kaggle suivant :
Ce projet utilise des données provenant d’Avito Maroc (annonces automobiles) publiées sur Kaggle.
🔗 Source : [Avito Car Dataset](https://www.kaggle.com/datasets/soufianebch/maroc-avito-car-dataset)

⚠️ Les données sont utilisées uniquement à des fins d’apprentissage et d’analyse. Merci au contributeur original.

🎯 Objectif du Projet

Mettre en place une architecture ELT moderne avec :

Extraction & Load : ingestion automatisée du CSV via Airbyte vers PostgreSQL

Transformation : modélisation et nettoyage via dbt, avec tests de qualité et documentation automatique

Visualisation : création de dashboards interactifs dans Power BI pour explorer le marché automobile

L’objectif est de transformer un dataset brut en informations business concrètes, prêtes à la prise de décision.

🔧 Stack Technique

| Composant      | Rôle                                                              |
| -------------- | ----------------------------------------------------------------- |
| **Airbyte**    | Ingestion automatisée CSV → Postgres                              |
| **PostgreSQL** | Data Warehouse centralisé                                         |
| **dbt Core**   | Transformation & modélisation (ELT, Star Schema, Medaillon Layer) |
| **Power BI**   | Dashboards interactifs pour KPIs                                  |


Le projet suit une approche couches Medaillon :

Raw (Bronze) : données sources brutes

Staging (Silver) : nettoyage, typage, normalisation

Intermediate / Dimensions : création de tables dimensionnelles (Brand, Model, City, Fuel)

Marts / Facts (Gold) : tables métiers prêtes pour les KPIs et dashboards Power BI

🟢 Cette architecture permet un workflow clair, réutilisable et testable, en conformité avec les normes d’entreprise.

✅ Fonctionnalités Clés

Transformation et normalisation des données brutes

Création d’un modèle dimensionnel (Star Schema)

Tests de qualité intégrés dans dbt (not_null, unique, accepted_values)

Documentation automatique des modèles et colonnes

Export pour dashboards interactifs Power BI

📊 Exemples de KPIs construits

Prix moyens par marque, modèle, ville et année

Options les plus recherchées par les acheteurs

Répartition carburant / boîte de vitesses

Disponibilité et tendances du marché

🚀 À venir / Roadmap

Optimisation du pipeline dbt pour intégrer des mises à jour incrémentales

Intégration de CI/CD avec GitHub Actions pour automatiser les tests et déploiements

Dashboards Power BI avancés avec filtres et visualisations interactives