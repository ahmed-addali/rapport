\chapter{Sprint 1 : Analyse \& Architecture}

\section{Sprint Planning — objectifs et Sprint Backlog}

Le premier Sprint, s'étalant sur les quatre premières semaines du projet (octobre 2024), marque l'initialisation formelle du processus de développement de Guidni. Au cours de la cérémonie de Sprint Planning, le Product Owner et le Scrum Master ont convergé vers un objectif cardinal : asseoir les fondations conceptuelles et architecturales du système. La complexité inhérente à l'hybridation d'un agent cognitif et d'un algorithme d'apprentissage par renforcement imposait une définition rigoureuse des flux de données avant toute implémentation. 

Le Sprint Backlog dérivé pour cette itération initiale comprenait ainsi plusieurs tâches analytiques et de conception. Il englobait la traduction des besoins bruts en User Stories détaillées, l'établissement d'une cartographie macroscopique des sous-systèmes, la formulation justifiée des choix technologiques, et la préparation de l'environnement de développement. C'est durant cette phase que les abstractions fondamentales des bases de données et des communications asynchrones ont été validées.

À l'instar des Sprints impliquant de la production de code, cette itération obéit à la même Definition of Done, exception faite que les livrables étaient ici des artefacts documentaires et des diagrammes de spécification technique. L'exhaustivité de ces documents devait néanmoins être confirmée par l'encadrant pour autoriser le passage effectif au développement actif de l'agent.

\section{Analyse des besoins}

La conception du système a pris pour origine une dissection fine des requêtes anticipées des utilisateurs finaux — à savoir les touristes projetant de se rendre à Djerba — ainsi que des exigences opérationnelles d'une plateforme en ligne. Le recensement de ces besoins s'est concrétisé sous forme de User Stories (récits utilisateurs) ordonnées au sein du Product Backlog.

Sur le versant fonctionnel affecté à l'organisation du séjour, il a été souligné qu'un touriste doit impérativement pouvoir formuler des requêtes multilingues (français, anglais, arabe) et obtenir un itinéraire couvrant plusieurs journées. Le récit associé précisait : \enquote{\textit{En tant que touriste, je veux recevoir un itinéraire multi-jours personnalisé selon mon budget et mes préférences linguistiques, afin d'optimiser l'organisation de mon séjour}}. L'implication technique induite réclame une compréhension contextuelle prolongée, ce qui certifie le recours à un orchestrateur de type agent LLM pourvu de mémoire.

Concernant le versant de la présentation algorithmique des recommandations, les contraintes se voulaient davantage palliatives des limitations standards du e-commerce. Un visiteur ne doit pas seulement se voir présenter des éléments figés, mais un agencement sensible à ses comportements contextuels (clics, temps d'arrêt, mise en favoris) en direct. Transposé techniquement pour l'infrastructure, la User Story critique exigeait : \enquote{\textit{En tant que système, je veux scorer une liste de recommandations en moins de 100 ms grâce au cache matriciel LinUCB}}, garantissant ainsi une réactivité indispensable à l'expérience de navigation.

\section{Architecture globale du système}

Face à ces besoins complexes, l'architecture retenue repose sur l'articulation coordonnée de deux sous-systèmes logiciels majeurs s'appuyant sur une base de données PostgreSQL unifiée. Le premier sous-système constitue l'Agent Planificateur Intelligence Artificielle. Ce dernier opère en backend derrière une API REST et orchestre un graphe d'états cognitifs formalisant les quatre phases de raisonnement d'un agent : la réflexion (THINK), l'exécution d'interface (EXECUTE\_TOOL), la validation logique (VALIDATE) et la réponse (RESPOND). Ce sous-système est enrichi par un pipeline de RAG (Retrieval-Augmented Generation) multilingue s'adossant sur des capacités d'embedding et de re-ranking (BAAI/bge-m3 et bge-reranker-v2-m3).

Parallèlement, le second sous-système encapsule le Moteur de Recommandation Hybride à base de bandits manchots (LinUCB). Ce moteur, pensé pour s'exécuter de concert avec l'API ou comme service de ranking frontal, projette le contexte de l'utilisateur et les caractéristiques des lieux dans un espace vectoriel de dimension 306. Son flux de raisonnement passe par un pipeline strict de dix étapes successives de classement et de filtrage, garantissant conjointement la diversité de l'offre et l'exploration de nouvelles propositions (10\% de hasard guidé). Le diagramme PlantUML suivant (Figure 1.1) synthétise ces interactions.

\begin{figure}[H]
    \centering
    \caption{Figure 1.1 — Architecture en double sous-systèmes du projet Guidni}
    \vspace{0.3cm}
    \includegraphics[width=0.95\textwidth]{diagrams/fig_01_architecture.png}
\end{figure}

Conjointement, ces deux pans logiciels reposent sur le patron de données partagé. L'agent, via un arsenal de dix-huit outils, vient interroger l'inventaire touristique que le moteur de recommandation se charge de pondérer, créant une boucle de rétroaction fluide. Un orchestrateur temporel nocturne garantit quant à lui la maintenance des profils utilisateurs prédictifs et les rafraîchissements sémantiques nécessaires.

\section{Choix technologiques et justifications}

La sélection des outils structurants du backend (le développement frontend via Next.js étant un miroir fonctionnel) s'est avérée critique lors de ce premier Sprint. Compte tenu de la forte asynchronie exigée par l'appel aux LLM et du calcul matriciel du moteur de recommandation, le projet a convergé vers l'écosystème Python 3.12, manipulé au travers du framework FastAPI. FastAPI garantit la robustesse asynchrone des appels REST (9 endpoints majeurs dédiés) par sa parfaite symbiosis avec \texttt{asyncpg} et l'ORM asynchrone SQLAlchemy. L'ensemble interagit avec une base de données relationnelle PostgreSQL 15, adéquate pour stocker tant les relations entités fixes que les interactions vectorielles générées.

Afin de gouverner la construction abstraite de l'agent, le choix s'est porté sur LangGraph associé à LangChain. Contrairement aux approches agentiques séquentiels simples, la maîtrise topologique de LangGraph rend possible l'établissement d'une machine à états finie stricte limitant notoirement les boucles infinies ou les hallucinations divergentes de l'intelligence artificielle. Les modèles fondateurs alimentant ce flux impliquent un routage adaptatif s'appuyant sur des offres locales et mutualisées dans le cloud, incluant Ollama pour l'inférence \texttt{qwen2.5:7b}, ou encore Google Gemini et Groq selon la tâche.

Ces technologies sont couplées à une supervision de l'instrumentation. Bien que l'outil de monitoring principal (tel que Phoenix/LangChainInstrumentor observé en base de code) ne fige pas l'architecture, il complète l'édifice afin de tracer la genèse des appels. La fondation mathématique de recommandation recourt à de simples bibliothèques agnostiques supportant la manipulation algorithmique de vecteurs en Python, optimisées par la gestion d'un cache en mémoire vive par verrouillage (threading.Lock).

\section{Sprint Review \& Retrospective}

À la clôture de ce Sprint inaugural, la phase de Sprint Review s'est orchestrée par un passage en revue détaillé de l'ensemble de ces propositions architecturales. L'encadrant et Scrum Master, M. Nizar Tenzekhti, a formellement contresigné l'ambition technologique et la justesse du modèle mental binaire (Agent / Bandit Contextuel). Le Product Backlog a été qualifié d'opérationnel pour initier l'itération de développement active. 

La Sprint Retrospective consécutive a permis d'acter une anticipation du risque non négligeable : la gestion hétérogène des flux asynchrones entre les appels base de données et l'imprévisibilité de certaines latences inhérentes aux API des grands modèles de langage. Cette réflexion a mené à renforcer l'intention d'instrumenter le code de façon omniprésente par le truchement de fichiers journaux rigoureux dès l'entame du Sprint 2.

\section*{Conclusion du chapitre}
\addcontentsline{toc}{section}{Conclusion du chapitre}

L'accomplissement de ce premier Sprint a posé les assises théoriques incontournables au projet Guidni. En cristallisant explicitement les besoins à travers des récits utilisateurs prioritaires et en cartographiant la symbiose attendue d'un agent cognitif LangGraph et d'un moteur LinUCB, l'équipe a érigé une ligne directrice probante. Les choix de conception actés, se reposant massivement sur la flexibilité asynchrone de Python et de FastAPI, dissipent ainsi les incertitudes algorithmiques fondamentales. Forte de ces directives et de ces outils de traçage, la seconde itération se consacrera inévitablement à l'implémentation logique et sémantique directe de la machine à états de l'agent planificateur, fondation pivotale de l'expérience utilisateur.