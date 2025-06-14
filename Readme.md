# KI in der Messtechnik – MATLAB-Implementierungen

Dieses Repository begleitet die wissenschaftliche Ausarbeitung im Rahmen des Moduls **Präzisionsmesstechnik** an der Hochschule Furtwangen. Ziel ist es, den Einsatz neuronaler Netze in messtechnischen Kontexten zu demonstrieren, insbesondere für Regressions-, Klassifikations- und Bildverarbeitungsaufgaben.

## Überblick der enthaltenen MATLAB-Skripte

### 1. `1_Regresion_neural_network_caipo.m`
Trainiert ein einfaches neuronales Netzwerk zur **Regression** synthetisch erzeugter Daten. Enthält:
- Daten-Generierung und Normalisierung
- Netzwerkarchitektur mit ReLU-Aktivierung
- Trainingsprozess (Forward- und Backward-Pass)
- Test und Visualisierung der Vorhersage

### 2. `2_Classification_neural_network_caipo.m`
Implementiert ein **Klassifikationsnetzwerk** zur Trennung dreier Klassen auf Basis von synthetischen 3D-Daten.
- One-Hot-Encoding der Zielwerte
- Softmax-Ausgabe und Kreuzentropie-Verlust
- Genauigkeitsberechnung

### 3. `3_Regresion_networkwith_image_analysis_caipo.m`
Verbindet **Regressionsanalyse mit Bildverarbeitung**:
- Extraktion von Bildmerkmalen
- Vorverarbeitung mit Sobel-Filter
- Anwendung eines neuronalen Regressionsmodells zur Koordinatenbestimmung

### 4. `4_Digit_recognition_neural_network_caipo.m`
Netzwerk zur **Erkennung handschriftlicher Ziffern** (digit recognition), basierend auf dem MNIST-Datensatz:
- Laden und Vorverarbeitung der Daten
- MLP mit ReLU-Aktivierung
- Ausgabe per Softmax
- Vorhersage und Visualisierung der Ergebnisse

### 5. `5_Kantanerkennung_caipo.m`
Demonstriert **Kantendetektion mit neuronaler Unterstützung**:
- Vergleich klassischer Sobel-Kantenerkennung mit KI-gestützten Verfahren
- Anwendung zur automatisierten Durchmessermessung
- Bewertung der Robustheit und Genauigkeit

---

## Bezug zur PDF-Dokumentation

Die Theorie und Beschreibung zu jedem dieser MATLAB-Skripte findet sich im Kapitel 5 der Arbeit _KI in der Messtechnik_. Der Code wird dort Schritt für Schritt erklärt, mit mathematischer Herleitung und grafischer Darstellung der Ergebnisse.

## Voraussetzungen

- MATLAB (empfohlen: R2023 oder neuer)
- Image Processing Toolbox für Bildanalysen
- Optional: Zugang zum MNIST-Datensatz (lokal gespeichert)

## Autor:

- Manuel Caipo (286577)

---

## Lizenz

Dieses Repository dient ausschließlich akademischen und demonstrativen Zwecken im Rahmen des Masterstudiengangs **Advanced Precision Engineering**.