\chapter{Sprint 2 : Agent Planificateur LangGraph}

\section{Sprint Planning}

Entamant le deuxième mois de développement (novembre 2024), le Sprint 2 se focalise exclusivement sur le cerveau fonctionnel de Guidni : l'Agent Planificateur. Lors de la session de Sprint Planning, le Product Backlog a été écrémé pour extraire les récits utilisateurs liés aux interactions en langage naturel. L'objectif premier décrété par le Product Owner était de substituer les enchaînements procéduraux rudimentaires par un graphe d'états récursif capable d'adapter son raisonnement dynamiquement.

Le Sprint Backlog s'est traduit par des jalons de développement stricts impliquant la construction de l'AgentState, l'élaboration de la topologie LangGraph, et le câblage indispensable des divers outils fonctionnels. Contrairement aux approches basiques où le grand modèle de langage tente de formuler une réponse d'une seule traite, la complexité organisationnelle d'un voyage à Djerba impose une planification fragmentée et itérative. 

La charte de complétion (Definition of Done) pour ce Sprint requérait explicitement la démonstration d'une conversation ininterrompue au cours de laquelle le modèle parviendrait de lui-même à questionner la base, extraire des lieux, et générer une structure sans dépasser le seuil de boucles infinies imposé par des garde-fous programmatiques.

\section{Architecture de la machine à états LangGraph}

Pour matérialiser ce processus cognitif, le développement s'est appuyé sur LangGraph, un orchestrateur asynchrone spécialisé dans la gestion de machines à états pour intelligences artificielles. Au cœur du système réside la structure \texttt{AgentState}, transmise et mutée à chaque transition nodale. Cet objet centralise l'historique des messages, les profils extraits, les données géolocalisées, ainsi que les compteurs de sécurité et les marqueurs décisionnels (tels que \texttt{needs\_more\_info} ou \texttt{is\_plan\_ready}).

Le graphe en lui-même articule quatre nœuds principaux dictant la séquence de résolution de la requête. Le flux démarre systématiquement par le nœud \texttt{THINK}, qui interroge le LLM sélectionné (qwen2.5:7b, llama-3.3-70b-versatile, ou gemini-2.5-flash). En fonction des variables internes générées par le modèle, un routeur conditionnel décide de la suite des opérations. Si une action est requise, le chemin bifurque vers \texttt{EXECUTE\_TOOL} ; si la construction du voyage semble achevée, il avance vers \texttt{VALIDATE} ; sinon, il passe directement à \texttt{RESPOND} pour questionner l'utilisateur ou formuler sa salutation. La Figure 2.1 représente schématiquement cette circulation nodale.

\begin{figure}[H]
    \centering
    \caption{Figure 2.1 — Machine à états cyclique de l'agent planificateur via LangGraph}
    \vspace{0.3cm}
    \includegraphics[width=0.75\textwidth]{diagrams/fig_02_langgraph.png}
\end{figure}

Postérieurement à l'excitation d'un outil, le système reconduit invariablement l'agent vers le nœud \texttt{THINK}. L'agent peut alors réévaluer son propre parcours cognitif fort des nouvelles données acquises. Une limite matérielle d'itérations, fixée à quinze passages consécutifs (\texttt{iteration\_count}), contraint formellement le graphe à s'achever de manière abrupte (\texttt{RESPOND}) afin de prévenir les blocages structurels ou le dépassement des quotas tarifaires d'inférence en réseau.

\section{Implémentation des 18 outils LLM}

L'omnipotence mathématique du LLM seul est chimérique sans les moyens d'explorer son environnement. Par conséquent, lors de ce Sprint, la majorité l'implémentation logicielle résidait dans l'exposition contrôlée de capacités tierces sous l'effigie d'outils. Un arsenal totalisant dix-huit ponts a été codé et consigné dans un registre global unifié mis à disposition exclusive du modèle. 

Parmi ces outils, une dimension purement contextuelle touristique est assumée. On distingue notamment \texttt{search\_activities}, \texttt{search\_stays}, et \texttt{search\_restaurants} servant la sélection géographique d'intérêts ; \texttt{get\_weather} recourant à l'interface Open-Meteo pour l'adaptabilité climatique du programme, ou encore \texttt{get\_distance} assurant le calcul matriciel des transitions spatiales locales. Les données générées par ces commandes externes modifient à la volée le champ d'informations de \texttt{AgentState}.

D'autres instruments relèvent directement de l'édition et de la préservation sémantique de l'organigramme de voyage. L'orchestrateur peut convoquer \texttt{create\_plan\_structure} pour ébaucher le squelette du séjour, \texttt{modify\_plan} pour l'amender itérativement, et enfin \texttt{save\_plan\_tool} pour figer son état dans la base PostgreSQL sous la vue du format relationnel. Une dernière sous-catégorie, les outils RAG (\texttt{rag\_search}, \texttt{rag\_search\_for\_plan}, \texttt{rag\_get\_similar}), a été intégrée abstraitement lors de ce deuxième cycle, bien que sa fondation technologique propre soit différée au Sprint suivant.

\section{Gestion de la mémoire conversationnelle}

Conduire des dialogues complexes exige de se remémorer pertinemment le fil des événements non seulement d'une conversation en cours, mais aussi des intentions sous-jacentes. En réponse, le gestionnaire conversationnel emploie une politique de mémoire à taille glissante combinée à un condensé structurel de données passées limitant ainsi l'encombrement du vecteur contextuel. Le module charge invariablement et exclusivement les huit derniers messages bruts (HumanMessage et AIMessage) du format en base de données.

Lorsque la profondeur de la discussion outrepasse quinze interactions, un goulot d'étranglement tarifaire et de distraction guette les LLMs non souverains ou alourdit la RAM du LLM local (Ollama). Dès l'apparition de ce seuil prédéterminé, un module asynchrone baptisé résumeur contextuel intervient furtivement et extrait les points capitaux du séjour souhaité. Cette synthèse se subtitue mathématiquement aux messages désuets, permettant à l'entité planificatrice de maintenir une conversation fluide sans perdre de vue la perspective originelle de l'internaute.

Outre cette condensation, le module d'extraction analyse en toile de fond les patterns manifestés. Des composantes liées aux attributs \texttt{user\_profile} enregistrent de manière progressive la catégorie du touriste et ses affinités explicites, consolidant virtuellement sa personnalité numérique pour d'éventuelles utilisations prospectives par le moteur de recommandation des itérations futures.

\section{Sprint Review \& Retrospective}

L'évaluation formelle clôturant de ce deuxième bloc s'est matérialisée par une Sprint Review consacrée à la manipulation de scénarios concrets. Devant le Scrum Master, l'agent a fait la démonstration de sa robustesse en orchestrant logiquement une dizaine d'appels d'outils successifs avant de solidifier une proposition structurée. La vérification visuelle des journaux détaillés (DEBUG level) a attesté le respect draconien de la séquence cyclique du graphe et des boucles de validation gérant l'intégrité JSON de la structure émise.

Durant la Sprint Retrospective associée, l'adoption de LangGraph fut jugée indubitablement fructueuse pour la transparence cognitivo-déductive. Toutefois, l'équipe a identifié une lacune manifeste dans la pertinence lexicale pure de la recherche classique pour un domaine spécialisé tel que le tourisme djerbien, soulignant l'importance vitale du Sprint 3 dédié à la génération augmentée par RAG afin d'améliorer incontestablement le ciblage géographique en remplaçant la majorité des recherches rudimentaires par projection vectorielle dense.

\section*{Conclusion du chapitre}
\addcontentsline{toc}{section}{Conclusion du chapitre}

Ce deuxième chapitre concrétise le Sprint 2, cœur de la dynamique intelligente du projet Guidni posant la structure de l'Agent. La mise au point de l'architecture par graphe d'états asynchrone permet d'endiguer efficacement l'imprévisibilité inhérente des modèles de langage de grande dimension en morcelant leur raisonnement. Associée à un arsenal extensif de dix-huit interfaces fonctionnelles connectées aux sources de données de Djerba et d'une allocation mémorielle optimisée refrénant une saturation contextuelle non viable, l'entité artificielle peut dès à présent manipuler la genèse d'un plan touristique. Une barrière qualitative majeure reste néanmoins circonscrite à ce stade ; l'affinement algorithmique de la recherche sémantique à destination des recommandations nécessitera le recours au pipeline RAG explicité dans l'itération à venir.