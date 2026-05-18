\chapter{Sprint 3 : Pipeline RAG Multilingue}

\section{Sprint Planning}

Le troisième Sprint, qui s'est déroulé en décembre 2024, trouve sa genèse dans les observations de la Sprint Retrospective précédente. L'agent LangGraph, bien qu'opérationnel, se heurtait formellement aux limites inflexibles de la recherche textuelle pure lorsqu'il interrogeait le catalogue touristique. Au cours du Sprint Planning, le Product Owner a érigé la compréhension sémantique de l'offre au rang de priorité absolue. Le Sprint Backlog a été alimenté par des tâches se focalisant la vectorisation des données et la restitution intelligente d'informations textuelles.

L'objectif cardinal décidé avec le Scrum Master consistait à déployer une architecture RAG (Retrieval-Augmented Generation) multilingue sans pour autant sacrifier la latence du backend FastAPI. Cette exigence réclamait l'implémentation de modèles d'embeddings denses et de stratégies de reclassement (reranking), tout en s'assurant que la base documentaire demeure synchronisée avec les modifications du frontend.

La Definition of Done adoptée pour cette itération spécifiait qu'une requête utilisateur complexe et multilingue (par exemple, en arabe ou en français pour une requête typée \enquote{endroit romantique et calme}) devait restituer un hébergement approprié indépendamment de la traduction exacte dans la base de données. En outre, la performance devait être objectivée par l'absence totale de blocage du thread principal (Event Loop) de l'application.

\section{Architecture du pipeline RAG}

La lecture et l'analyse de l'architecture logicielle démontrent que la résolution de ces problématiques repose sur une approche de récupération de l'information vectorielle scindée en deux étapes distinctes (two-stage retrieval). Lorsque l'un des outils de l'agent requiert une recherche, la chaîne ne fait plus appel uniquement à des clauses SQL littérales. L'entrée textuelle brute est immédiatement captée par le moteur de projection.

La première étape déclenche le calcul d'un vecteur dense représentant la requête, qui est mis en opposition mathématique avec l'index mémorisé. L'objectif est de récupérer très rapidement un large sous-ensemble de candidats (généralement une cinquantaine) présentant une similarité cosinus préliminaire. 

Toutefois, la simple similarité vectorielle manque parfois de précision sémantique fine concernant les interactions subtiles des mots au sein de la question. De fait, la seconde étape confronte formellement le texte de la requête au texte complet de la description du candidat via un composant agissant comme pair-évaluateur (Cross-Encoder). Ce filtre rigoureux modifie le score originel et ordonne drastiquement la liste pour n'en conserver que le nombre de résultats finaux stricts (\textit{Top K}) réclamés par les outils de l'agent. La Figure 3.1 schématise ce pipeline.

\begin{figure}[H]
    \centering
    \caption{Figure 3.1 — Pipeline de récupération documentaire à deux étapes (RAG)}
    \vspace{0.3cm}
    \includegraphics[width=0.85\textwidth]{diagrams/fig_03_rag.png}
\end{figure}

\section{Embeddings BAAI/bge-m3 et reranking}

Face au public touristique de Djerba, l'hybridation des langages — incluant le français, l'anglais, et l'arabe — s'imposait comme contrainte technique impérative. Les fichiers de configuration de l'application signalent l'utilisation de \texttt{BAAI/bge-m3} par l'intermédiaire de la bibliothèque \texttt{HuggingFaceEmbedding}. Ce modèle à l'état de l'art a été instancié globalement lors de l'initialisation asynchrone des composants (via les directives d'environnement), en désactivant le sous-jacent de génération propre à LlamaIndex pour confier exclusivement l'abstraction sémantique au graphe LangGraph. Afin de limiter la perte d'informations lors du hachage du corpus textuel persistant, les paramètres d'enrobage (chunking) ont été fixés à 512 tokens en dimension par bloc, avec un chevauchement conservateur de 50 tokens garantissant le maintient du contexte limite.

Concernant le module de reclassement post-récupération, le système instancie le modèle compagnon \texttt{BAAI/bge-reranker-v2-m3}. L'inspection rigoureuse du module gérant les requêtes (\texttt{query\_engine.py}) indique par ailleurs une gestion habile des ressources serveurs. Le modèle Cross-Encoder nécessitant en prédiction un effort de calcul matriciel intense et exclusivement dépendant du processeur, risquait fatalement de bloquer la boucle d'événements asynchrone de FastAPI. Le code contraint cette lourdeur en encapsulant formellement la fonction \texttt{rerank\_results} via le paradigme \texttt{asyncio.to\_thread}, déportant les prédictions matricielles sur un fil d'exécution séparé (\textit{worker thread}) et garantissant ainsi à l'orchestrateur de maintenir sa fluidité aux requêtes frontales.

\section{Réindexation incrémentale via SQLAlchemy}

La robustesse temporelle de tout système d'assistance repose sur la justesse immédiate de son catalogue. Interroger un index vectoriel périmé ruinerait l'effort d'inférence en recommandant au visiteur de la plateforme des activités désuètes. Face à cette contrainte, le développement du module d'indexation a recours aux fonctionnalités natives de SQLAlchemy.

Plutôt que d'opérer des mises à jour massives fragmentaires nécessitant l'arrêt de l'index interne, la logique repose sur de la réindexation incrémentale axée sur les événements (event listeners). Le fichier \texttt{db\_events.py} s'accroche mécaniquement sur les directives bas-niveau de la base de données telles que \texttt{after\_insert}, \texttt{after\_update}, et \texttt{after\_delete} interceptant de ce fait les entités spécifiques ciblées (Activity, Stay, Restaurant).

À chaque altération des caractéristiques d'une de ces fiches par l'administrateur, l'écouteur déclenche silencieusement une tâche asynchrone isolée qui re-calcule distinctement l'expression vectorielle correspondante et la transmet à l'espace de stockage approprié. Ce paradigme autorise un maintien quasi immédiat de l'index complet sans accaparer les ressources requises par les communications des utilisateurs naviguant sur l'application.

\section{Sprint Review \& Retrospective}

Lors de la Sprint Review concluant les événements de décembre, la plateforme Guidni, renforcée de ce nouveau système préhenseur à forte sémantique, fut assujettie à une série de questions pièges non explicites. En particulier, la requête de \enquote{logements calmes avec une vue en hauteur pour jeunes mariés} formulée en trois langues distinctes, a effectivement remonté des offres de séjours qualifiés d'idylliques dans leur description, prouvant le bilinguisme cognitif du modèle bge-m3. L'encadrant validant l'itération a approuvé l'intégration fluide du système RAG à la machine à états préexistante.

Cependant, la Sprint Retrospective mit en relief une carence stratégique finale. Si l'intelligence artificielle est maintenant très performante pour satisfaire une demande écrite claire et complexe, comment doit réagir l'interface face à un utilisateur passif ou à dominante visuelle effectuant un simple balayage ou un défilement ? Le besoin systémique d'exposer un contenu prédictif induit indépendamment du texte justifie de ce fait le basculement intégral vers la quatrième itération du projet, à vocation purement mathématique.

\section*{Conclusion du chapitre}
\addcontentsline{toc}{section}{Conclusion du chapitre}

Le Sprint 3 parachève la brique cognitive de l'agent en remplaçant des recherches basiques par une implémentation rigoureuse du concept de génération augmentée par RAG. L'exploitation symétrique de BAAI/bge-m3 pour l'inscription vectorielle universelle et du reranker cross-encoder délesté astucieusement sur les cœurs logiques en fil secondaire, maintient une prestation sémantique indéniable évitant judicieusement des dysfonctionnements asynchrones. De surcroît, le relais d'indexation incrémentale confère à l'application une assurance sur l'actualisation stricte du panel touristique au jour près. Résolu concernant les limites textuelles, l'effort mathématique de Guidni peut désormais s'attaquer à son jalon mathématique terminal : le moteur contextuel d'interactions utilisateur, faisant l'objet du chapitre ultérieur.