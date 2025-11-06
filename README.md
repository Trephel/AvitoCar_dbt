# 🚗 AvitoCar_dbt

**Objectif du Projet :**  
Mettre en place un entrepôt de données moderne avec **dbt** sur **PostgreSQL** afin de transformer des données de ventes automobiles (Avito.ma) et générer des insights business visualisés dans **Power BI**.

---

## 🔧 Stack Technique

| Composant | Rôle |
|-----------|-------|
| **PostgreSQL** | Data Warehouse |
| **dbt Core** | Modélisation & Transformation (ELT) |
| **Power BI** | Visualisation & Reporting |

---

## 🧱 Architecture dbt (Modèles)

Le projet suit une architecture ELT moderne basée sur les couches suivantes :

┌──────────────┐
│ Source │ (raw data - Avito)
└──────┬───────┘



▼

┌──────────────┐
│ Staging │ (clean / normalize data)
└──────┬───────┘



▼
┌──────────────┐
│ Dimensions │ (Brand, Model, City, Fuel, etc.)
└──────┬───────┘



▼
┌──────────────┐
│ Facts │ (Listings & Options)
└──────────────┘


## ✅ Fonctions Clés du Projet

- Nettoyage & normalisation des données sources
- Création d’un modèle dimensionnel (Star Schema)
- Mise en place de tests dbt (qualité & cohérence)
- Documentation automatique des modèles
- Export des données pour dashboards Power BI

---

## 📊 Dashboard Power BI

Des KPI clés ont été construits pour analyser le marché automobile :

- Prix moyens par marque / modèle / ville
- Options les plus recherchées
- Répartition carburants / boîtes de vitesses
- Analyse disponibilité & tendances du marché