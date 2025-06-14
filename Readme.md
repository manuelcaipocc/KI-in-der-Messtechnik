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

<<<<<<< HEAD
## Voraussetzungen

- MATLAB (empfohlen: R2023 oder neuer)
- Image Processing Toolbox für Bildanalysen
- Optional: Zugang zum MNIST-Datensatz (lokal gespeichert)

## Autor:
=======
### B. Fundamentals of Image Preprocessing 

<div style="background-color:#e6f7ff; padding: 12px; border-left: 6px solid #0050b3; font-weight:500;">

<span style="color:#003366">🔹 <strong style="color:#003366">Fundamentals of Image Preprocessing and Edge Detection</strong></span><br><br>

<ul style="color:#003366">
  <li>Basics of image representation: pixels, channels, color spaces (RGB, HSV, grayscale)</li>
  <li>Preprocessing techniques: normalization, filtering (Gaussian, median), histogram equalization</li>
  <li><strong style="color:#003366">Mathematics behind edge detection</strong>: convolution, gradient operators (Sobel, Prewitt), Laplacian</li>
  <li>Role of edge detection in feature extraction and its importance for CNN performance</li>
</ul>

</div>

### C. Artificial Intelligence (in progress)
- Overview of Artificial Intelligence (AI) and Machine Learning (ML)
- Classification of models: supervised, unsupervised, reinforcement learning
- Key statistical models: regression, PCA, SVM, clustering (e.g. k-means)
- Transition to neural networks: motivation and historical development
- Neural network architectures:
  - **Perceptron**: input layer, weights, bias, activation function (step/sign), binary output, linearly separable data, no hidden layers, gradient descent
  - **MLP (Multilayer Perceptron)**: multiple hidden layers, non-linear activation, universal approximation, deep backpropagation
  - **CNN (Convolutional Neural Network)**: convolutional layers, kernel size, stride, padding, pooling layers, flattening, fully connected layers, activation functions (ReLU, Softmax), local receptive fields, parameter sharing, data augmentation
  - **RNN (Recurrent Neural Network)**: recurrent connections, hidden state, sequence processing, vanishing gradient problem, time steps, shared weights across time, applications in time-series and text data
  - **LSTM / GRU**: memory cells, gating mechanisms, long-term dependency handling, fewer vanishing gradients, improved performance in temporal tasks
  - **Autoencoder (AE)**: encoder, latent space, decoder, reconstruction loss, dimensionality reduction, anomaly detection
  - **GAN (Generative Adversarial Network)**: generator-discriminator setup, adversarial loss, synthetic data generation, training instability
  - **Transformer**: attention mechanism, encoder-decoder structure, positional encoding, parallelizable, leading model in NLP and beyond
  - **GNN (Graph Neural Network)**: node/edge processing, message passing, graph convolutions, relational and structured data applications

- Learning configuration (applies to most architectures): learning rate, epochs, batch size, optimizer (SGD, Adam), loss function (MSE, cross-entropy), backpropagation (incl. BPTT for RNNs), regularization (L1, L2, dropout), evaluation metrics (accuracy, precision, recall, F1)
- Summary of applications in measurement contexts



## 3. AI in Measurement Technology

### A. **Focus: Object Localization using Computer Vision**
  - Application of CNNs for position estimation
  - Preprocessing steps: dataset creation, image labeling, augmentation
  - Models for coordinate regression (e.g., keypoint detection)
  - Robustness considerations: lighting, occlusion, real-time feedback
  - Example architectures: YOLO, ResNet with regression head

### B. Edge Detection Algorithms and AI Enhancements
<div style="background-color:#e6f7ff; padding: 12px; border-left: 6px solid #0050b3; font-weight:500; color:#003366">

🔹 <strong style="color:#003366">Edge Detection in High-Precision Measurement Technology – Research Outline</strong><br><br>

<ul style="color:#003366">
  <li><strong style="color:#003366">Summarize classical edge detection algorithms</strong> such as Canny, Sobel and Laplacian of Gaussian (LoG). Explain their mathematical basis (e.g., gradients, convolution), and describe how they are applied to achieve sub-pixel accuracy in high-resolution imaging.</li>

  <li><strong style="color:#003366">Describe specific applications in measurement technology (Messtechnik)</strong>: Include examples such as contactless dimensional inspection, micro- and nanostructure detection on surfaces, and geometry validation in industrial quality control.</li>

  <li><strong style="color:#003366">Discuss the limitations of classical methods</strong>: Investigate typical problems like noise sensitivity, influence of lighting, edge localization errors, and calibration challenges. Support with technical papers or metrology standards.</li>

  <li><strong style="color:#003366">Research AI-based improvements</strong>: Describe how Convolutional Neural Networks (CNNs) or other architectures can be trained for edge detection. Focus on how they improve robustness, precision, and adaptability (e.g., Holistically-Nested Edge Detection, DeepEdge).</li>

  <li><strong style="color:#003366">Explain hybrid approaches</strong>: Present examples of systems that combine classical edge filters with deep learning (e.g., CNN refinement after Canny filtering). Focus on their benefit for achieving nanometer-scale accuracy in challenging measurement environments.</li>
</ul>

</div>



### C. Aditional mportant applications:
  - Signal noise suppression
  - Sensor calibration through neural networks
  - Pattern recognition from sensor data
  - Anomaly detection in measurements
  - Literature-backed examples from industry (e.g., predictive diagnostics)
>>>>>>> 279c2ae4ee99d1632d24869987086c54130d6872

- Manuel Caipo (286577)

---

## Lizenz

Dieses Repository dient ausschließlich akademischen und demonstrativen Zwecken im Rahmen des Masterstudiengangs **Advanced Precision Engineering**.