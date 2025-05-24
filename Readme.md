#  Master Project: Artificial Intelligence in Measurement Technology

**Sources**: Bara, Siwar
**LaTeX of Resources**: Good structure
**Important Source**: *"Attention is All You Need"*
**Tool**: MATLAB (Deep Learning Toolbox)
**Code by**: Manuel
**Use Cases**: See below

**Processing by**:
- **Bara - Siwar**: Research-based sections, Literature(1 to 6) **21 Pages Minimun Mandatory**
- **Manuel**: Own MATLAB implementation, discussion and joint evaluation (7–10)
- **Together**: Conclusion, Use Cases, Appendix

*All deliverables must be in LaTeX(tables, index of Literature, Bibliography) for MATLAB code integration.*

**Important Tools & Sources**:
- MATLAB (Deep Learning Toolbox)
- Literature: Books + technical articles (IEEE, Springer, Elsevier)
- Example source: *"Attention is All You Need"*, Haykin, Bishop
- Format: LaTeX
- Result: Documentation + PowerPoint presentation (15–20 min.)

---
## Structure and Task Distribution

| Section | Section Content | Implementation & Output | Responsible | Deadline |
|-------------|-----------------------|------------------------|-------------------------|------------|
| **1. Introduction** | Objectives, motivation, importance of AI in measurement technology, state of the art. | Literature-based introduction. Sources from technical articles and books. <br>**→ Output**: Structured introduction with citations | **Bara** ✅ | **19.04.2025** |
| **2. Fundamentals** | Physical & mathematical foundations of measurement technology + AI and NN fundamentals. | Use of technical literature to describe measurement principles, signal processing, AI models, and neural networks. <br>**→ Output**: Integrated theory section with equations and references | **Siwar** ✅ (Measurement part done) | **24.04.2025** |
| **3. AI in Measurement Technology** | Applications of NN in measurement technology: position estimation using computer vision, pattern recognition, noise suppression, calibration, anomaly detection. | Literature-based description of real applications with focus on object localization via computer vision. <br>**→ Output**: Detailed section with diagrams and references | **Bara** | **30.04.2025** |
| **4. Network Strategies & Evaluation** | Architecture selection, activation functions, regularization, optimization methods, metrics. | Comparison and evaluation with scientific sources. <br>**→ Output**: Comparison table & explanations | Bara, Siwar | **26.04.2025** |
| **5. MATLAB Implementation** | Own implementation of NNs: regression, classification, computer vision with MATLAB. | Code for all NN types implemented and evaluated. <br>**→ Output**: Code samples, evaluation results | **Manuel** ✅ | **19.04.2025** |
| **6. Use Cases** | Table of concrete applications with NN types and MATLAB strategies. | Structured table, analysis of approaches. <br>**→ Output**: Tabular overview for presentation | **Manuel** ✅ | **26.04.2025** |
| **7. Discussion & Conclusion** | Synthesis, evaluation, limitations, and outlook. | Scientific discussion based on literature and own results. <br>**→ Output**: Summary and conclusion chapter | **Manuel, Bara, Siwar** | **15.05.2025** |

---

## 1. Introduction ✅
- Goal of the work
- Significance of Artificial Intelligence (AI) in Measurement Technology
- Motivation and current state of the art

## 2. Fundamentals
### A. Measurement Technology ✅
- Basic concepts, types of measurement systems
- Typical challenges
- Signal processing and sensor interfaces

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
<div style="background-color:#e6f7ff; padding: 12px; border-left: 6px solid #0050b3; font-weight:500;">

<span style="color:#003366">🔹 <strong style="color:#003366">Edge Detection Algorithms and AI Enhancements</strong></span><br><br>

<ul style="color:#003366">
  <li>Classical edge detection algorithms: Canny, Sobel, Laplacian of Gaussian (LoG)</li>
  <li>Industrial applications: quality inspection (e.g., crack detection), object segmentation, robotics</li>
  <li>Limitations of classical methods: sensitivity to noise, parameter tuning</li>
  <li><strong style="color:#003366">Enhancement with AI models:</strong> using CNNs to learn optimal edge representations (e.g., Holistically-Nested Edge Detection - HED)</li>
  <li>Hybrid approaches: combining classical filters with trainable layers for robust edge detection in dynamic environments</li>
</ul>

</div>


### C. Aditional mportant applications:
  - Signal noise suppression
  - Sensor calibration through neural networks
  - Pattern recognition from sensor data
  - Anomaly detection in measurements
  - Literature-backed examples from industry (e.g., predictive diagnostics)

## 4. Network Strategies and Their Evaluation
- Architecture selection and design criteria
- **Activation Functions**: ReLU, Sigmoid, Tanh
- **Optimization Methods**: SGD, Adam
- **Regularization**: Dropout, L2
- Model evaluation metrics: MSE, R², accuracy, precision, recall
- Techniques for cross-validation and overfitting control

## 5. MATLAB Implementation ✅
- Neural network creation with MATLAB Deep Learning Toolbox
- Data pipeline: import, preprocessing, normalization, splitting
- Training and hyperparameter tuning
- Implemented models:
  - Regression ✅
  - Classification ✅
  - Computer Vision ✅

## 6. Use Cases ✅
- Overview table of implemented use cases
- Associated NN models and configuration
- Context and motivation for each scenario (e.g., defect detection, predictive maintenance, object localization)

## 7. Discussion & Conclusion
### A. Discussion
- Key technical findings and evaluation of the implemented methods
- Comparative reflection vs. classical techniques
- Strengths and limitations of neural approaches
- Challenges in generalization, real-time usage, interpretability
- Relevance for industrial and scientific communities

### B. Conclusion
- Summary of overall outcomes
- Impact on measurement technology development
- Final position of neural networks in metrology
- Recommendations and open research questions

---





##  Possible Use Cases in Measurement Technology with Neural Networks

| Use Case | Description | NN-Type | MATLAB Approach |
|----------|--------------|--------|----------------|
| **Sensor Calibration** | Compensation of systematic measurement errors | Feedforward NN | `trainNetwork`, Regression |
| **Temperature & Pressure Sensor Analysis** | Prediction/interpolation of missing data | LSTM / RNN | `sequenceInputLayer`, Time series |
| **Classification of Material Defects** (e.g., ultrasound) | Classification of image data | CNN | `imageInputLayer`, Transfer Learning |
| **omaly Detection in Measurement Data Streams** | Detection of atypical measurement profiles | Autoencoder / RNN | `autoencoder`, Reconstruction Loss |
| **Prediction of Sensor Failures** | Prediction based on historical data | MLP / LSTM | Time series analysis |

---

# Guide Using BibTeX in Overleaf

This guide explains how to properly use **BibTeX** for managing references in a LaTeX project on [Overleaf](https://www.overleaf.com/).

---

## 1. Overview

**BibTeX** is a tool and file format used in conjunction with LaTeX to manage bibliographies. It allows you to store reference entries in a separate `.bib` file and cite them in your `.tex` documents.

---

## 2. File Structure in Overleaf

Your Overleaf project should contain at least:

- A main LaTeX file, e.g. `main.tex`
- A bibliography file, e.g. `references.bib`

---

## 3. Sample Entries in `references.bib`

Create a new file in Overleaf and name it `references.bib`. Then add your references in the following format:

### 3.1 Book

```bibtex
@book{haykin1999neural,
  author    = {Haykin, Simon},
  title     = {Neural Networks: A Comprehensive Foundation},
  publisher = {Prentice Hall},
  year      = {1999}
}
```

### 3.2 Journal Article

```bibtex
@article{bishop2006pattern,
  author  = {Bishop, Christopher M.},
  title   = {Pattern Recognition and Machine Learning},
  journal = {Springer},
  volume  = {4},
  number  = {4},
  pages   = {738--739},
  year    = {2006}
}
```

### 3.3 Website or Online Resource

```bibtex
@misc{openai2023chatgpt,
  author       = {{OpenAI}},
  title        = {ChatGPT Technical Report},
  year         = {2023},
  url          = {https://openai.com/blog/chatgpt},
  note         = {Accessed: 2025-03-30}
}
```

---

## 4. Referencing in `main.tex`

To include the bibliography in your LaTeX document:

### 4.1 In the Preamble (optional but recommended):

```latex
\usepackage[utf8]{inputenc}
\usepackage{cite} % or use natbib if preferred
```

### 4.2 Citing Within the Document:

```latex
As described by Haykin \cite{haykin1999neural}, neural networks are...
```

### 4.3 Adding the Bibliography Section:

At the end of your document, include the following:

```latex
\bibliographystyle{plain}        % or use ieee, apalike, alpha, etc.
\bibliography{references}        % no file extension needed
```

---

## 5. Compile Instructions on Overleaf

Overleaf automatically handles BibTeX when you compile your project. Just ensure:

- Your `.bib` file is correctly named and saved.
- The citation keys used in `\cite{}` match the entries in `references.bib`.

---

## 6. Recommended Bibliography Styles

| Style      | Description                            |
|------------|----------------------------------------|
| `plain`    | Alphabetical order, numeric citations  |
| `ieeetr`   | IEEE style                             |
| `apalike`  | APA style (author-year format)         |
| `alpha`    | Author abbreviation + year             |
| `unsrt`    | Ordered by citation in the document    |

To change the style, modify this line in your `.tex`:

```latex
\bibliographystyle{ieeetr}
```

---

## 7. Best Practices

- Always use consistent citation keys.
- Avoid spaces in keys or file names.
- Use the `Better BibTeX` plugin in Zotero for automatic BibTeX export.
- Regularly update your `.bib` file if using external tools.

---

## 8. References

- Overleaf: [https://www.overleaf.com](https://www.overleaf.com)
- BibTeX Entry Types: [https://www.overleaf.com/learn/latex/BibTeX_bibliography_styles](https://www.overleaf.com/learn/latex/BibTeX_bibliography_styles)
