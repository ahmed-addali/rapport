% Diagrammes de Cas d'Utilisation - Guide d'Intégration LaTeX

## Fichiers PlantUML générés pour le rapport Guidni

### Chapitre 3 - Lancement de Projet
- `fig_03_usecase_global.png` : Diagramme de cas d'utilisation global
  - Source: `plantuml/usecase_global.puml`
  - Acteurs: Touriste, Administrateur
  - 9 cas d'utilisation principaux

### Chapitre 4 - Sprint 1 (Agent Planificateur)
- `fig_04_usecase_sprint1.png` : Cas d'utilisation Sprint 1
  - Source: `plantuml/usecase_sprint1.puml`
  - 4 UC: questions contextuelles, RAG, outils, mémoire
  
- `fig_04_sequence_sprint1_primary.png` : Séquence principale - Flux RAG
  - Source: `plantuml/sequence_sprint1_primary.puml`
  - Montre le pipeline complet avec Qdrant et mémoire Redis
  
- `fig_04_sequence_sprint1_secondary.png` : Séquence secondaire - Outil Météo
  - Source: `plantuml/sequence_sprint1_secondary.puml`
  - Exemple d'exécution d'un outil spécifique
  
- `fig_04_classes_agent.png` : Diagramme de classes - Agent Planificateur
  - Source: `plantuml/class_sprint1_agent.puml`
  - Classes: AgentPlanificateur, StateGraph, BaseTool, RAGPipeline

### Chapitre 5 - Sprint 2 (Moteur LinUCB)
- `fig_05_usecase_sprint2.png` : Cas d'utilisation Sprint 2
  - Source: `plantuml/usecase_sprint2.puml`
  - 5 UC: collecte, features, scores LinUCB, ranker, nightly job
  
- `fig_05_sequence_sprint2_primary.png` : Séquence principale - Calcul LinUCB
  - Source: `plantuml/sequence_sprint2_primary.puml`
  - Détaille le produit Kronecker 306D et le ranker 10 étapes
  
- `fig_05_sequence_sprint2_secondary.png` : Séquence secondaire - Nightly Job
  - Source: `plantuml/sequence_sprint2_secondary.puml`
  - Entraînement quotidien et validation du modèle
  
- `fig_05_classes_linucb.png` : Diagramme de classes - Moteur LinUCB
  - Source: `plantuml/class_sprint2_linucb.puml`
  - Classes: LinUCBEngine, FeatureEngineering, TenStepRanker, NightlyJob

### Chapitre 6 - Sprint 3 (Tests et Évaluation)
- `fig_06_usecase_sprint3.png` : Cas d'utilisation Sprint 3
  - Source: `plantuml/usecase_sprint3.puml`
  - 5 UC: tests unitaires, intégration, performance, E2E, couverture
  
- `fig_06_sequence_sprint3_primary.png` : Séquence principale - Exécution tests
  - Source: `plantuml/sequence_sprint3_primary.puml`
  - pytest, coverage, génération rapports
  
- `fig_06_sequence_sprint3_secondary.png` : Séquence secondaire - Benchmark performance
  - Source: `plantuml/sequence_sprint3_secondary.puml`
  - Tests de charge et métriques SLA

### Chapitre 7 - Sprint 4 (Intégration et Déploiement)
- `fig_07_usecase_sprint4.png` : Cas d'utilisation Sprint 4
  - Source: `plantuml/usecase_sprint4.puml`
  - 5 UC: déploiement, health endpoints, dashboard, OpenAPI, démo
  
- `fig_07_sequence_sprint4_primary.png` : Séquence principale - CI/CD et déploiement
  - Source: `plantuml/sequence_sprint4_primary.puml`
  - Pipeline Kubernetes, rolling update, health checks
  
- `fig_07_sequence_sprint4_secondary.png` : Séquence secondaire - Démo E2E
  - Source: `plantuml/sequence_sprint4_secondary.puml`
  - Scénario utilisateur complet intégrant tous les sprints

### Architecture Globale
- `fig_03_architecture_globale.png` : Architecture système complète
  - Source: `plantuml/class_architecture.puml`
  - 5 couches: Présentation, API, Métier, Données, Services Externes

## Instructions d'intégration LaTeX

Dans vos fichiers `.tex`, utilisez:

```latex
\begin{figure}[H]
    \centering
    \includegraphics[width=\textwidth]{diagrams/fig_XX_nom_du_diagramme.png}
    \caption{Description du diagramme}
    \label{fig:XX_nom_du_diagramme}
\end{figure}
```

## Génération des PNG

Exécutez le script de génération:
```bash
cd /workspace/diagrams
./generate_diagrams.sh
```

Prérequis:
- Java installé
- plantuml.jar téléchargé à `/opt/plantuml/plantuml.jar`

Téléchargement de PlantUML:
```bash
sudo mkdir -p /opt/plantuml
cd /opt/plantuml
sudo wget https://github.com/plantuml/plantuml/releases/download/v1.2024.7/plantuml-1.2024.7.jar
sudo mv plantuml-1.2024.7.jar plantuml.jar
```
