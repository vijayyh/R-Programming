# 🚗✈️ Binary Image Classification in R using Keras

## Project Overview

This project demonstrates how a **deep learning model implemented in R** can be used to identify whether an input image belongs to the **car** or **plane** category.

The complete workflow is implemented in **Google Colab** and covers the major stages of an image-classification task, including loading images, preprocessing, feature extraction, neural-network construction, model training, prediction, and performance evaluation.

Since the dataset contains only **12 labeled images**, this experiment is primarily intended to demonstrate the classification workflow rather than create a production-ready image recognition system.

---

## 🎯 Aim

The main goal of this experiment is to develop a binary image classifier capable of distinguishing between:

- **Class 0 → Car**
- **Class 1 → Plane**

The images are converted into numerical feature vectors and supplied to a fully connected neural network built with **Keras 3 for R**.

---

## 📝 Problem Statement

A small collection of vehicle images is used to construct a binary image classification system. The dataset contains six car images and six airplane images.

Each image is:

1. Loaded into R.
2. Converted into a consistent image size.
3. Resized to **28 × 28 pixels**.
4. Represented using three RGB channels.
5. Flattened into a one-dimensional vector.
6. Used as input to a neural network.

The trained model is then tested using previously unseen car and plane images.

---

## 💻 Implementation Environment

The first version of this experiment was intended for **RStudio** using `EBImage` and the traditional `keras` package. However, installing and loading `EBImage` caused compatibility and installation issues in the local environment.

Therefore, the implementation was adapted for **Google Colab**.

The revised implementation uses:

- `jpeg` for image reading
- `keras3` for neural-network development
- A custom R function for image resizing

This approach avoids the dependency on `EBImage` and provides a simpler setup for running the experiment in Colab.

---

## 📂 Dataset Description

The dataset consists of **12 JPEG images**, divided equally between the two target classes.

| Category | Numerical Label | Files |
|---|---:|---|
| Cars | 0 | `c1.jpg` – `c6.jpg` |
| Planes | 1 | `p1.jpg` – `p6.jpg` |

### Cars

The car collection contains examples such as:

- Ferrari SF90
- Bentley Flying Spur
- Kia Seltos
- Toyota RAV4
- Mercedes GLC

### Planes

The airplane collection contains examples such as:

- Elysian E9X concept
- Cargo/military aircraft
- British Airways 787
- Qantas A380
- Boeing 777X
- Widebody passenger aircraft

---

## 🔀 Dataset Division

The images were manually separated into training and testing groups.

### Training Data

The training set contains **10 images**:

- `c2.jpg` – `c6.jpg`
- `p2.jpg` – `p6.jpg`

### Testing Data

The remaining **2 images** are reserved for evaluation:

- `c1.jpg`
- `p1.jpg`

Therefore:

**Training samples = 10**

**Testing samples = 2**

> Because the test set contains only two images, the calculated accuracy should be interpreted as an experimental result rather than a reliable estimate of real-world performance.

---

## 📦 Required R Libraries

The implementation requires the following packages:

| Library | Role |
|---|---|
| `jpeg` | Loads JPEG image files into R |
| `keras3` | Creates and trains the deep learning model |

The Keras backend must also be available for `keras3`.

---

## 🔄 Workflow

The complete classification process follows these stages:

```text
Image Dataset
      ↓
Load JPEG Images
      ↓
Inspect Image Data
      ↓
Resize Images to 28×28
      ↓
Convert RGB Values to Numeric Features
      ↓
Flatten Images into 2352 Features
      ↓
Create Training/Test Sets
      ↓
Encode Class Labels
      ↓
Build Neural Network
      ↓
Train Model
      ↓
Evaluate on Test Images
      ↓
Generate Predictions
      ↓
Create Confusion Matrix
```

---

## 1. Image Acquisition and Loading

Each JPEG image is read using the `readJPEG()` function provided by the `jpeg` package.

The loaded image is represented as an array containing its pixel information and RGB channels.

Basic R functions such as:

```r
print()
summary()
str()
hist()
```

are used to examine the loaded data.

A sample image is also displayed using R's raster plotting functionality.

---

## 2. Image Preprocessing

Images can have different dimensions, so they must first be converted to a common size before being passed to the neural network.

A custom `resize_image()` function is used to resize every image to:

```text
28 × 28 × 3
```

where:

- `28` = image height
- `28` = image width
- `3` = RGB color channels

Nearest-neighbor resampling is used for this resizing operation.

---

## 3. Feature Representation

After resizing, each image contains:

```text
28 × 28 × 3 = 2352
```

individual pixel values.

The three-dimensional image array is converted into a single vector containing **2352 numerical features**.

Therefore, every image becomes one row in the input matrix.

The resulting structure is approximately:

```text
Number of images × 2352 features
```

---

## 4. Label Encoding

The two categories are represented numerically:

```text
Car   → 0
Plane → 1
```

For neural-network training, the labels are converted into a two-column one-hot representation.

For example:

```text
Car   → [1, 0]
Plane → [0, 1]
```

This allows the final softmax layer to produce a probability for each class.

---

## 🧠 Neural Network Architecture

A fully connected feed-forward neural network is used for classification.

The model consists of three dense layers:

```text
Input: 2352 features
        ↓
Dense Layer: 256 neurons
        ↓
Dense Layer: 128 neurons
        ↓
Output Layer: 2 neurons
        ↓
Softmax Prediction
```

### Architecture Details

| Layer | Units | Activation |
|---|---:|---|
| Input/Dense | 256 | ReLU |
| Dense | 128 | ReLU |
| Output | 2 | Softmax |

The network contains a total of:

```text
635,522 trainable parameters
```

---

## ⚙️ Model Compilation

The model is configured using:

- **Loss:** Categorical Cross-Entropy
- **Optimizer:** Adam
- **Evaluation Metric:** Accuracy

Categorical cross-entropy is suitable because the problem has two mutually exclusive output classes represented using one-hot encoded labels.

The Adam optimizer is used to update the network weights during training.

---

## 🏋️ Model Training

The network is trained using:

```text
Epochs       = 30
Batch Size   = 2
Validation   = 20%
```

The small batch size is suitable for demonstrating training with this extremely small dataset.

A validation split is also taken from the training data to monitor model performance during training.

---

## 📊 Model Evaluation

After training, the model is evaluated using the two images that were kept completely separate from the training process.

The obtained results were:

| Evaluation Measure | Result |
|---|---:|
| Test Accuracy | 50% |
| Test Loss | 36.41 |

The model successfully recognized the car image but failed to identify the airplane image correctly.

---

## 🔮 Prediction Results

The model generated the following probabilities for the test samples:

| Image | Car Probability | Plane Probability | Model Output | True Class |
|---|---:|---:|---|---|
| `c1.jpg` | 1.000 | 5.43 × 10⁻²⁸ | Car | Car |
| `p1.jpg` | 1.000 | 2.38 × 10⁻³² | Car | Plane |

For `c1.jpg`, the predicted class matches the actual class.

However, for `p1.jpg`, the network incorrectly assigns almost all probability to the car class.

---

## 📈 Confusion Matrix

The resulting confusion matrix is:

| Prediction / Actual | Car | Plane |
|---|---:|---:|
| **Car** | 1 | 1 |
| **Plane** | 0 | 0 |

This means:

- **1 car** was classified correctly.
- **1 plane** was incorrectly classified as a car.
- No plane was correctly predicted.
- No car was incorrectly classified as a plane.

Consequently, the test accuracy is:

```text
Correct predictions / Total predictions

= 1 / 2

= 50%
```

---

## ⚠️ Interpretation of the Results

The 50% accuracy should not be interpreted as evidence that the neural network is generally poor at distinguishing cars and planes.

The primary issue is the extremely limited amount of training data.

Only **10 images** were available for training, while just **2 images** were used for testing. A neural network containing more than **635,000 parameters** can easily memorize such a small training set instead of learning general visual patterns.

Therefore, overfitting is highly likely.

A much larger dataset containing hundreds or thousands of images would be required to properly assess the effectiveness of the classifier.

---

## 🚧 Limitations

Several limitations are present in this experiment:

### 1. Very Small Dataset

Only 12 images are available, which is insufficient for training a robust image classifier.

### 2. Extremely Small Test Set

Only two images are used for testing. A single incorrect prediction changes the accuracy by 50 percentage points.

### 3. Possible Overfitting

The neural network has hundreds of thousands of parameters compared with only ten training images.

### 4. Basic Image Features

The model receives raw pixel values rather than high-level visual features extracted by a pretrained convolutional neural network.

### 5. Simple Resizing

Nearest-neighbor resizing may remove or distort some visual information.

### 6. Limited Generalization

The model cannot be expected to recognize arbitrary cars and airplanes reliably from such a small collection of examples.

---

## 🚀 Possible Improvements

The experiment could be significantly improved by:

- Increasing the number of training images.
- Using a larger and more diverse dataset.
- Applying data augmentation.
- Normalizing pixel values.
- Using a Convolutional Neural Network (CNN).
- Applying transfer learning with pretrained models.
- Increasing the size of the test set.
- Using stratified train/test splitting.
- Measuring precision, recall, and F1-score.
- Performing cross-validation where appropriate.

A CNN or pretrained architecture would generally be much more suitable for image classification because it can learn spatial patterns such as edges, shapes, textures, and object structures.

---

## ▶️ How to Run the Project

### Step 1 — Clone the Repository

```bash
git clone <your-repo-url>
cd <repo-folder>
```

### Step 2 — Open the Notebook

Open:

```text
EXP_4.ipynb
```

in Google Colab.

The notebook contains the tested implementation of the experiment.

### Step 3 — Upload the Dataset

Upload the `images/` directory containing:

```text
c1.jpg
c2.jpg
c3.jpg
c4.jpg
c5.jpg
c6.jpg

p1.jpg
p2.jpg
p3.jpg
p4.jpg
p5.jpg
p6.jpg
```

### Step 4 — Install Required Packages

The notebook installs the required R packages if they are not already available:

```r
install.packages(c("jpeg", "keras3"))
```

If required, the Keras backend can be configured using:

```r
keras3::install_keras()
```

### Step 5 — Execute the Notebook

Run the cells sequentially.

The notebook will:

1. Load the images.
2. Inspect the image data.
3. Resize the images.
4. Convert images into feature vectors.
5. Prepare labels.
6. Create the neural network.
7. Train the model.
8. Evaluate its performance.
9. Generate predictions.
10. Display the confusion matrix.

---

## 📁 Repository Organization

```text
project-folder/
│
├── EXP_4.ipynb
├── README.md
│
└── images/
    ├── c1.jpg
    ├── c2.jpg
    ├── c3.jpg
    ├── c4.jpg
    ├── c5.jpg
    ├── c6.jpg
    ├── p1.jpg
    ├── p2.jpg
    ├── p3.jpg
    ├── p4.jpg
    ├── p5.jpg
    └── p6.jpg
```

---

## 🏁 Conclusion

This experiment demonstrates an end-to-end **binary image classification workflow in R** using Keras.

The project covers image loading, exploratory inspection, resizing, feature extraction, label encoding, neural-network training, prediction, and evaluation.

Although the final test accuracy is only **50%**, the result is mainly a consequence of the extremely small dataset and limited test samples. The experiment successfully demonstrates how an image dataset can be transformed into numerical input and processed by a deep neural network.

For a practical image-classification application, the next step would be to use a substantially larger dataset together with **CNNs, data augmentation, or transfer learning** to improve feature learning and generalization.