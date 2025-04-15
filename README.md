## 🧠 Hate Comments Detection using Naive Bayes (R Project)

Welcome! This is a machine learning project built in **R** that detects hate speech in user comments using **text mining** and the **Naive Bayes** algorithm. It's a great intro to NLP (natural language processing), classification, and data preprocessing — all in R!

### 📁 What’s Inside

- **HateSpeechDataset_4000.csv**: The dataset (sample of 4000 comments)
- **hate_speech_detection_report.Rmd**: The main R Markdown report — runs the whole process and generates visual output + predictions
- **README.md**: What you're reading now

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
text <- "You are so stupid, no one likes you!"
predict_hate(text, comments_classifer, comment_dtm)
# Output: "Hate Speech"
```
### 🚀 How to Run This

#### 1. Clone this repo or download the files

#### 2. Open `hate_speech_detection_report.Rmd` in **RStudio**

#### 3. Make sure you have these packages installed:

```r
install.packages(c("tm", "SnowballC", "wordcloud", "quanteda", "e1071", "gmodels", "caret"))
install.packages("tinytex")
tinytex::install_tinytex()  
```

#### 4. Click **Knit > Knit to PDF**  
RStudio will run all the code, generate visualizations, and export everything as a PDF report.

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

