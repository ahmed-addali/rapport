\chapter{Sprint 5 : Tests, Évaluation \& Déploiement}

\section{Sprint Planning}

Le cinquième et ultime Sprint du projet, programmé sur les quatre dernières semaines de février 2025, parachève le développement de l'application Guidni. À ce stade de l'élaboration, l'intégralité des sous-systèmes logiciels, tant l'Agent Planificateur LangGraph que le pipeline sémantique RAG et le Moteur LinUCB, a été arrimée techniquement. La planification de cette itération (Sprint Planning) a réorienté les efforts vers la consolidation pure : la chasse aux anomalies (zéro bogue fonctionnel majeur), la quantification des performances scientifiques et le déploiement opérationnel.

En l'absence de développement de nouvelles fonctionnalités au niveau architectural, le Sprint Backlog intégrait des scénarios liés à l'assurance qualité (Quality Assurance). Les impératifs stipulaient la mise en œuvre de batteries de tests exhaustifs, des campagnes d'évaluation quantitatives concernant la justesse des algorithmes implémentés, et l'établissement concret d'un environnement de production. Le Product Owner a insisté sur l'identification chiffrée de la vélocité via l'analyse du Burndown Chart justifiant le bon aboutissement de la méthodologie Scrum.

Pour cette phase terminale, la Definition of Done évoluait vers un format de recette finale. Le projet ne pouvait être formellement accepté par le Scrum Master et encadrant que si d'une part les taux de couverture de tests garantissaient la solidité du backend FastAPI, et d'autre part, si des simulations chiffrées corroboraient la validité de l'intelligence artificielle et du modèle d'apprentissage par modèles statistiques sous-jacents.

\section{Stratégie de tests}

Afin de sécuriser scrupuleusement les fondations de l'application, nous avons institué une stratégie de tests stratifiée, orchestrée par le paramétrage du composant \texttt{pytest}. La première couche concerne les tests unitaires : chaque fonction pure, de la normalisation des vecteurs \(\phi\) au filtrage par contrainte budgétaire, a subi des épreuves par assertion. Cette démarche déterministe prévient fermement la régression arithmétique lorsque la matrice de corrélation \(\mathcal{A}\) encaisse un afflux de métriques issues d'actions émulées.

Le passage au palier supérieur consistait en une phase de tests d'intégration, vérifiant conjointement la fluidité des interactions entre les composants isolés et la persistance relationnelle au sein de PostgreSQL. En d'autres mots, la manipulation par l'Event Loop de FastAPI fut validée pour empêcher tout blocage mortel. La dernière vérification porte sur les tests système de bout-en-bout (End-to-End). Ils mettent formellement en compétition l'agent LangGraph pour assurer l'orchestration asynchrone des dix-huit ponts analytiques. Le diagramme Figure 5.1 illustre cette chronologie méthodique.

\begin{figure}[H]
    \centering
    \caption{Figure 5.1 — Chaîne d'évaluations et simulations validant le déploiement}
    \vspace{0.3cm}
    \includegraphics[width=0.85\textwidth]{diagrams/fig_05_evaluation.png}
\end{figure}

L'agrégation des résultats de ces campagnes logicielles a conduit au renforcement de règles d'authentification et de timeouts réseau pour l'intégration de fournisseurs distants (tels que Groq ou Gemini). Les éventuelles carences au niveau des délais de latence originellement pointées ont été nivelées durant cet enchaînement progressif, déverrouillant ainsi la voie aux évaluations mathématiques substantielles de la performance intrinsèque de l'IA.

\section{Évaluation du pipeline RAG}

La vérification de l'adéquation algorithmique commence par statuer sur la pertinence de la restitution documentaire du pipeline de génération augmentée de la recherche (RAG). Une extraction d'informations dysfonctionnelle, induite par une dimension sémantique erronée, produirait des retours non factuels voire des hallucinations prononcées chez l'Agent Planificateur. Une tâche explicite a par conséquent mené au déclenchement scripté ( via \texttt{pytest -m evaluation} ) d'une batterie de tests en boite noire.

Cette évaluation quantitative repose sur l'injection de vingt requêtes textuelles test préétablies. Cet échantillonnage couvre le spectre trilingue de l'outil (français, anglais, arabe) et soumet le module BAAI/bge-m3 à des critères discriminants complexes, alliant contraintes géographiques, notions descriptives subjectives (romantisme, adrénaline) et limitations de budget. L'orchestration inclut également la phase de reranking via le composant bge-reranker-v2-m3 pour attester numériquement du bénéfice du tri.

Les données recueillies attestent d'une préservation de la sémantique originelle très élevée (Precision@K) justifiant pleinement l'hybridation des langages lors de la recherche dans un vaste catalogue hôtelier ou évènementiel. En parvenant à identifier les attraits pertinents ignorés par les traditionnels filtres SQL rudimentaires, le système a prouvé qu'il fournissait des arguments qualifiés adéquats aux outils de l'outil orchestrateur pour qu'il conçoive son emploi du temps rigoureusement et contextuellement.

\section{Simulation du moteur LinUCB}

Si le module RAG brille par ses extractions statiques, le cœur asynchrone LinUCB se démarque par sa capacité d'adaptation en environnement dynamique. Pour l'éprouver sans mobiliser un afflux de visiteurs réels, la stratégie a consisté à instiguer un banc d'essai émulant la navigation de touristes digitaux. Un environnement générant cinq cents sessions d'exploration arbitraires mais obéissant à des comportements de clics orientés a été programmé, reproduisant fidèlement les vecteurs \(x_{\text{user}}\).

Tout au long du tir de barrage automatisé, l'acquisition des points de récompense (de 0.0 pour un passage oculaire abstrait à 1.0 pour une réservation franche) instruit activement la matrice locale \(\mathcal{A}\). La vérification mathématique fondamentale reposait sur l'examen du taux de convergence : le cumul de l'expectative de récompense (Cumulative Reward) se devait de croître indéniablement au fil de l'accumulation des itérations informatiques, supplantant par la même occasion une stratégie empirique purement aléatoire.

Le traitement des données issues des graphiques de validation montre explicitement un infléchissement radical vers l'exploitation au-delà des premières centaines de visites virtuelles (franchissement de la phase dite du Cold Start), rendant la plateforme guidée capable de privilégier des lieux dont les descripteurs \(\phi\) s'harmonisent finement avec l'empreinte saisonnière ou financière de l'individu, tout en assurant l'introduction de 10\% d'innovations selon le pipeline en dix étapes décrit au Sprint 4.

\section{Burndown Chart global du projet}

L'adoption de la méthode empirique Scrum implique la reddition d'un rapport de vélocité tout à fait singulier. Le composant d'évaluation incontournable permettant de visualiser la réduction effective de la complexité sur l'ensemble de la conception s'incarne par le tracé graphique de l'effort : le Burndown Chart. L'agencement chronologique retrace ici la dynamique de déclassement des items de l'arriéré produit du projet (Product Backlog) étalés lors de ces intenses cinq mois d'exécution.

L'étude détaillée de ce diagramme de vélocité renseigne logiquement sur la complexité croissante des jalons de l'implémentation. Si l'entame architecturale (Sprint 1) concédait une résolution franche, la pente s'est légèrement adoucie lors du développement de LangGraph (Sprint 2) réclamant des mises au point répétitives d'interfaçages ouverts d'application (API). Le Sprint 3, par son ancrage vectoriel sur la bibliothèque FastAPI, a exigé une phase d'investigation freinée de peu par un besoin lourd de traitement multifilaire (thread offloading). 

La résolution exponentielle apparente a de nouveau marqué le pas lors du quatrième Sprint devant traiter l'algébrisation stricte en mémoire pour la recommandation bandits, avant de plonger brusquement à l'approche du Sprint 5. Cette trajectoire asymptotique vers l'accomplissement des tickets d'exigence certifie que le périmètre de travail et les priorités dictés par le Product Owner lors de la planification s'adaptaient proportionnellement pour endiguer la dette technique en amont des déploiements finaux.

\section{Sprint Review finale \& Retrospective}

L'achèvement du code source donna inévitablement lieu à la présentation magistrale validant la complétude systémique lors de la Review ultime. Guidni fut mis à l'essai d'orchestrer, au travers de scénarios contigus simulant en temps réel une visite prolongée depuis une structure Next.js, son raisonneur conversationnel croisé à son affichage instantané sous le régime de l'algorithme LinUCB. L'encadreur sanctionna la réunion en reconnaissant la satisfaction intégrale des prérequis fonctionnels et qualitatifs du PFE initialisés depuis octobre.

L'observation rétrospective (Sprint Retrospective globale) consolida un retour d'expérience édifiant. Elle souleva l'importance capitale d'une rigoureuse organisation Scrum lorsque surviennent de vastes changements technologiques induits par le débogage de fonctions asynchrones de récupération ou l'optimisation par la gestion de caches mémoires. L'équipe entérina la démarche, la jugeant singulièrement adaptée aux systèmes d'intelligences artificielles évolutifs et imprédictibles.

\section*{Conclusion du chapitre}
\addcontentsline{toc}{section}{Conclusion du chapitre}

Ce cinquième chapitre referme l'exécution itérative encadrée par la norme Agile Scrum de la solution logicielle complète Guidni. Par le recours aux campagnes quantitatives via pytest (évaluations RAG sur vingt critères extrêmes) et par des simulations assises sur plusieurs centaines de sessions virtuelles LinUCB, nous avons consolidé publiquement l'efficacité de la structure en réseaux asynchrones Python mis en place. L'investigation mathématique des profils couplée au suivi par Burndown Chart certifie la gestion avisée de ce développement de nature imprévisible. Ayant satisfait pleinement sa Definition of Done conclusive, ce Sprint de tests confère son accréditation en mode final au produit avant que ne soit formulé son bilan d'ingénierie et ses recommandations de fin de programme académique.