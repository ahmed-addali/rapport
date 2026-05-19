#!/bin/bash
# Script de génération des diagrammes PlantUML vers PNG
# Nécessite: java et plantuml.jar installés

PLANTUML_JAR="/opt/plantuml/plantuml.jar"
INPUT_DIR="/workspace/diagrams/plantuml"
OUTPUT_DIR="/workspace/diagrams"

echo "=== Génération des diagrammes PlantUML ==="

# Vérifier si plantuml.jar existe
if [ ! -f "$PLANTUML_JAR" ]; then
    echo "Erreur: plantuml.jar non trouvé à $PLANTUML_JAR"
    echo "Installation: wget https://github.com/plantuml/plantuml/releases/download/v1.2024.7/plantuml-1.2024.7.jar"
    exit 1
fi

# Générer tous les fichiers .puml
cd "$INPUT_DIR"

echo "Génération des use case diagrams..."
java -jar "$PLANTUML_JAR" -tpng -o"$OUTPUT_DIR" usecase_*.puml

echo "Génération des sequence diagrams..."
java -jar "$PLANTUML_JAR" -tpng -o"$OUTPUT_DIR" sequence_*.puml

echo "Génération des class diagrams..."
java -jar "$PLANTUML_JAR" -tpng -o"$OUTPUT_DIR" class_*.puml

echo "Génération des autres diagrammes..."
java -jar "$PLANTUML_JAR" -tpng -o"$OUTPUT_DIR" *.puml

# Renommer les fichiers générés avec des noms explicites
mv "$OUTPUT_DIR/usecase_global.png" "$OUTPUT_DIR/fig_03_usecase_global.png" 2>/dev/null || true
mv "$OUTPUT_DIR/usecase_sprint1.png" "$OUTPUT_DIR/fig_04_usecase_sprint1.png" 2>/dev/null || true
mv "$OUTPUT_DIR/usecase_sprint2.png" "$OUTPUT_DIR/fig_05_usecase_sprint2.png" 2>/dev/null || true
mv "$OUTPUT_DIR/usecase_sprint3.png" "$OUTPUT_DIR/fig_06_usecase_sprint3.png" 2>/dev/null || true
mv "$OUTPUT_DIR/usecase_sprint4.png" "$OUTPUT_DIR/fig_07_usecase_sprint4.png" 2>/dev/null || true

mv "$OUTPUT_DIR/sequence_sprint1_primary.png" "$OUTPUT_DIR/fig_04_sequence_sprint1_primary.png" 2>/dev/null || true
mv "$OUTPUT_DIR/sequence_sprint1_secondary.png" "$OUTPUT_DIR/fig_04_sequence_sprint1_secondary.png" 2>/dev/null || true
mv "$OUTPUT_DIR/sequence_sprint2_primary.png" "$OUTPUT_DIR/fig_05_sequence_sprint2_primary.png" 2>/dev/null || true
mv "$OUTPUT_DIR/sequence_sprint2_secondary.png" "$OUTPUT_DIR/fig_05_sequence_sprint2_secondary.png" 2>/dev/null || true
mv "$OUTPUT_DIR/sequence_sprint3_primary.png" "$OUTPUT_DIR/fig_06_sequence_sprint3_primary.png" 2>/dev/null || true
mv "$OUTPUT_DIR/sequence_sprint3_secondary.png" "$OUTPUT_DIR/fig_06_sequence_sprint3_secondary.png" 2>/dev/null || true
mv "$OUTPUT_DIR/sequence_sprint4_primary.png" "$OUTPUT_DIR/fig_07_sequence_sprint4_primary.png" 2>/dev/null || true
mv "$OUTPUT_DIR/sequence_sprint4_secondary.png" "$OUTPUT_DIR/fig_07_sequence_sprint4_secondary.png" 2>/dev/null || true

mv "$OUTPUT_DIR/class_architecture.png" "$OUTPUT_DIR/fig_03_architecture_globale.png" 2>/dev/null || true
mv "$OUTPUT_DIR/class_sprint1_agent.png" "$OUTPUT_DIR/fig_04_classes_agent.png" 2>/dev/null || true
mv "$OUTPUT_DIR/class_sprint2_linucb.png" "$OUTPUT_DIR/fig_05_classes_linucb.png" 2>/dev/null || true

echo "=== Génération terminée ==="
echo "Fichiers PNG générés dans: $OUTPUT_DIR"
ls -la "$OUTPUT_DIR"/*.png 2>/dev/null || echo "Aucun fichier PNG généré"
