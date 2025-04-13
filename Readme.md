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
##  Structure and Task Distribution

| Section | Section Content | Implementation & Output | Responsible | Deadline |
|-------------|-----------------------|------------------------|-----------------|------------|
| **1. Introduction** | Objectives, motivation, importance of AI in measurement technology, state of the art. | Literature-based introduction. Sources from technical articles and books. <br>**→ Output**: Structured introduction with citations | Bara | **19.04.2025** |
| **2. Fundamentals** | Physical & mathematical foundations of measurement technology. | Use of technical literature to describe measurement principles, signal processing, models. <br>**→ Output**: Theory section with equations and references | Bara,siwar | **24.04.2025** |
| **3. AI & Neural Networks** | Definitions, methods of ML, types of neural networks, learning methods. | Theory section with sketches/illustrations. Technical literature (e.g., Haykin, Bishop). <br>**→ Output**: Description of network types with examples | Bara, Siwar | **30.04.2025** |
| **4. AI in Measurement Technology** | Applications of NN in measurement technology: pattern recognition, noise suppression, calibration, anomaly detection. | Presentation of real Use Cases based on technical articles. <br>**→ Output**: Description of examples from the literature | Bara,Siwar | **30.04.2025** |
| **5. Network Strategies & Evaluation** | Architecture selection, activation functions, regularization, optimization methods, metrics. | Comparison and evaluation with scientific sources. <br>**→ Output**: Comparison table & explanations | Bara, Siwar | **26.04.2025** |
| **6. State of the Art & Manufacturer Comparison** | Market analysis, state of development, relevant companies. | Comparison of real products/technologies with references. <br>**→ Output**: Table + discussion of current solutions | Bara, Siwar | **30.04.2025** |
| **7. MATLAB Implementation** | Own implementation of a neural network with MATLAB (Deep Learning Toolbox). | Data import, preprocessing, network architecture, training, evaluation. <br>**→ Output**: Results analysis with code examples | Manuel | **19.04.2025** |
| **8. Use Cases (Table)** | Presentation of concrete applications with NN types and MATLAB strategies. | Building model in Matlab <br>**→ Output**: Overview table for the presentation | Manuel | **26.04.2025** |
| **9. Discussion** | Comparison with classical methods, evaluation of own implementation, limitations. | Own analysis based on implementation and online sources. <br>**→ Output**: Critical text section with graphics | Manuel & Bara | **10.05.2025** |
| **10. Conclusion & Outlook** | Summary, evaluation of the project, future research approaches. | Joint reflection of findings. <br>**→ Output**: Final section with research outlook | Manuel & Bara | **15.05.2025** |
| **11. Bibliography** | All cited sources in a uniform style. | Building with Citavi / Zotero or manually in LaTeX. <br>**→ Output**: Bibliography in the appendix | Bara, Siwar | **10.05.2025** |
| **12. Appendix** | Code, network details, illustrations, possibly datasets (linked). | Collection of technical additions. <br>**→ Output**: Appendix with links and screenshots | Everyone | **15.05.2025** |

---

##  1. Structure of the Documentation

### 1. Introduction
- Goal of the work
- Significance of Artificial Intelligence (AI) in Measurement Technology
- Motivation and current state of the art

### 2. Fundamentals
#### Measurement Technology
- Basic concepts, types of measurement systems
- Typical challenges

#### Artificial Intelligence
- Overview of AI methods
- Focus: Machine Learning

#### Neural Networks (NN)
- Biological inspiration
- **Architecture**: Perceptron, MLP, CNN, RNN
- **Learning Methods**: Supervised, unsupervised, reinforcement learning

### 3. Methods in Measurement Technology with AI
- Signal noise suppression
- Calibration through neural networks
- Pattern recognition (e.g., classification of sensor data)
- Anomaly detection

### 4. Literature Research
- Selection and description of relevant works (IEEE, Springer, Elsevier)
- Comparison of different methods
- Evaluation of applicability in industrial scenarios

**Example Sources**:
- Haykin: *Neural Networks and Learning Machines*
- Bishop: *Pattern Recognition and Machine Learning*
- Current Articles: *AI in Measurement Technology*

### 5. Network Strategies and Their Evaluation
- Choice of the right network architecture depending on the measurement problem
- **Activation Functions**: ReLU, Sigmoid, Tanh
- **Optimization Methods**: SGD, Adam
- **Regularization**: Dropout, L2
- Criteria for model evaluation: MSE, R², accuracy, precision/recall
- Cross-Validation & Overfitting prevention

### 6. MATLAB Implementation
- Structure of the neural network with `Deep Learning Toolbox`
- Dataset processing (import, normalization, division)
- Training process and hyperparameters
- Evaluation of the model

##  8. Results and Discussion
- Presentation of results (tables, plots)
- Comparison with classical methods
- Discussion of limitations & challenges

---

##  9. Conclusion and Outlook
- Summary of findings
- Potential for future applications
- Suggestions for further developments



---

##  Possible Use Cases in Measurement Technology with Neural Networks

| Use Case | Description | NN-Type | MATLAB Approach |
|----------|--------------|--------|----------------|
| **Sensor Calibration** | Compensation of systematic measurement errors | Feedforward NN | `trainNetwork`, Regression |
| **Temperature & Pressure Sensor Analysis** | Prediction/interpolation of missing data | LSTM / RNN | `sequenceInputLayer`, Time series |
| **Classification of Material Defects** (e.g., ultrasound) | Classification of image data | CNN | `imageInputLayer`, Transfer Learning |
| **Anomaly Detection in Measurement Data Streams** | Detection of atypical measurement profiles | Autoencoder / RNN | `autoencoder`, Reconstruction Loss |
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
