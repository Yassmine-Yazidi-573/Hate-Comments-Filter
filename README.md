## 🧠 Hate Comments Detection using Naive Bayes (R Project)

Welcome! This is a machine learning project built in **R** that detects hate speech in user comments using **text mining** and the **Naive Bayes** algorithm. It's a great intro to NLP (natural language processing), classification, and data preprocessing — all in R!

### 📁 What’s Inside

- **HateSpeechDataset_4000.csv**: The dataset (sample of 4000 comments)
- **hate comment filter.Rmd**: The main R Markdown report — runs the whole process and generates visual output + predictions
- **RSCRIPT.R**: The full R script I initially made

### 🛠️ What the Code Does

1. **Loads and explores** the hate speech dataset  
2. **Cleans and preprocesses** the comments (removes punctuation, stopwords, stems words, etc.)
3. **Visualizes** frequent words using word clouds
4. Builds a **Document-Term Matrix (DTM)**  
5. Splits data into **training and test sets**
6. Trains a **Naive Bayes model** to detect hate comment
7. **Evaluates** the model’s accuracy with confusion matrix and cross table
8. Includes a handy function to **test any custom text input**!

### 🔍 Sample Use Case

Want to test your own sentence? Here's how:

```r
text <- "try to look for a different picture to share on insta you ugly sl**t hhhhhh"
predict_hate(text, comments_classifer, comment_dtm)
# Output: "Hate comment"
```
### 🚀 How to Run This

#### 1. Clone this repo or download the files

#### 2. Open `RSCRIPT.R` in **RStudio**

#### 3. Make sure you have these packages installed:

```r
install.packages(c("tm", "SnowballC", "wordcloud", "quanteda", "e1071", "gmodels", "caret"))  
```
### 📊 Sample Output

- Accuracy: ~60%
- Word clouds showing most frequent terms
- Confusion matrix of predictions

### ❤️ Author Notes

- This is a simplified academic project and **not** ready for production.
- It's designed for learning purposes — NLP basics, classification models, and data preprocessing in R.
- You can extend this with deep learning or more robust NLP models like BERT later.

## 👩‍💻 Author

**Yassmine Yazidi**  
Business Student & Data Enthusiast  
Tunisia 🇹🇳

