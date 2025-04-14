install.packages("quanteda")
install.packages("tm")
install.packages("SnowballC")
install.packages("wordcloud")
install.packages("e1071")
install.packages("gmodels")
install.packages("caret")
# Read the dataset
comments_raw=read.csv("HateSpeechDataset_4000.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE)
comments_raw$Label=factor(comments_raw$Label)
str(comments_raw)#4000 comments  and 2 variables
table(comments_raw$Label)# 3271 non hateful comments and 729 hateful comments
#mining the comments
library(tm)
comment_corpus=VCorpus(VectorSource(comments_raw$Content))
print(comment_corpus)
# RESULT; <<VCorpus>>
#Metadata:  corpus specific: 0, document level (indexed): 0
#Content:  documents: 4000
inspect(comment_corpus[1:4])
#RESULT: FOR eg:
#[[4]]
#<<PlainTextDocument>>
#Metadata:  7
#Content:  chars: 49
as.character(comment_corpus[[3]]) #display the content of comment number 3
#cleaning comments
#1)transform all comments to lowercase
comments_corpus_cleaned=tm_map(comment_corpus, FUN=content_transformer(tolower))
comments_corpus_cleaned=tm_map(comments_corpus_cleaned, removeNumbers)
comments_corpus_cleaned=tm_map(comments_corpus_cleaned, removeWords, stopwords())
comments_corpus_cleaned=tm_map(comments_corpus_cleaned, removePunctuation)
#perform stemming on comments
library(SnowballC)
comments_corpus_cleaned=tm_map(comments_corpus_cleaned, stemDocument)
comments_corpus_cleaned=tm_map(comments_corpus_cleaned, stripWhitespace)#delete extra white spaces
as.character(comments_corpus_cleaned[[3]])
#building the document term matrix
comment_dtm=DocumentTermMatrix(comments_corpus_cleaned)
#Data divison btw training and testing: 70% vs 30%
comment_dtm_train=comment_dtm[1:2800, ]
comment_dtm_test=comment_dtm[2801:4000 ,]
comment_train_labels=comments_raw[1:2800, ]$Label
comment_test_labels=comments_raw[2801:4000, ]$Label
# comparing the % of hate comments in train and test sets!
prop.table(table(comment_train_labels))#0.81 (hate) vs 0.18 (no hate)
prop.table(table(comment_test_labels))#0.81 (hate) vs0.18 (no hate)
#approximately the same: % 
#Visualization
library(wordcloud)
wordcloud(comments_raw$Content, max.words = 50, random.order=FALSE)# visualize wordFrequency in all data(4000)

#visualize common words in HATE comments
hate_comments=comments_raw$Content[comments_raw$Label == 1]
Hcorpus <- Corpus(VectorSource(hate_comments))
Hcorpus <- tm_map(Hcorpus, content_transformer(tolower))
Hcorpus <- tm_map(Hcorpus, removePunctuation)
Hcorpus <- tm_map(Hcorpus, removeWords, stopwords())
Hcorpus <- tm_map(Hcorpus, stripWhitespace)
wordcloud(Hcorpus, max.words = 30, colors = brewer.pal(8, "Reds"))
#visualize common words in NOT hate comments
nhate_comments=comments_raw$Content[comments_raw$Label == 0]
nHcorpus <- Corpus(VectorSource(nhate_comments))
nHcorpus <- tm_map(nHcorpus, content_transformer(tolower))
nHcorpus <- tm_map(nHcorpus, removePunctuation)
nHcorpus <- tm_map(nHcorpus, removeWords, stopwords())
nHcorpus <- tm_map(nHcorpus, stripWhitespace)
wordcloud(Hcorpus, max.words = 30, colors = brewer.pal(8, "Blues"))
#prep for NAIVE BAYES
library(quanteda)
#we will try to remove from dtm words that appear less than 5 times
comment_freq_words=findFreqTerms(comment_dtm_train,5)
str(comment_freq_words)#displays words that appear less than 5 times
comments_dtm_freq_train=comment_dtm_train[ ,comment_freq_words]
comments_dtm_freq_test=comment_dtm_test[ ,comment_freq_words]
convert_counts=function(x){x=ifelse(x>0,"yes","No")}
comments_train=apply(comments_dtm_freq_train, MARGIN = 2, convert_counts)
comments_test=apply(comments_dtm_freq_test, MARGIN = 2, convert_counts)
#TRAINING THE MODEL
library(e1071)
comments_classifer=naiveBayes(comments_train, comment_train_labels)
#Evaluating the model
library(gmodels)
comments_test_pred=predict(comments_classifer, comments_test, laplace=T)
CrossTable(comments_test_pred, comment_test_labels, prop.chisq = FALSE, prop.t = FALSE, dnn=c('predicted','actual'))
library(caret)
confusionMatrix(comments_test_pred, comment_test_labels)# accuracy of the model=0.6075=60.75%

#building a predector function:
predict_hate <- function(input_text, model, dtm_template) {
  # Create corpus
  input_corpus= Corpus(VectorSource(input_text))
  input_corpus= tm_map(input_corpus, content_transformer(tolower))
  input_corpus= tm_map(input_corpus, removePunctuation)
  input_corpus= tm_map(input_corpus, removeNumbers)
  input_corpus= tm_map(input_corpus, removeWords, stopwords("english"))
  input_corpus= tm_map(input_corpus, stripWhitespace)
  input_dtm=DocumentTermMatrix(input_corpus, control = list(dictionary = Terms(dtm_template)))
  input_matrix=as.data.frame(as.matrix(input_dtm))
  # Predict
  prediction=predict(model, input_matrix)
  return(ifelse(prediction == 1, "Hate comment", "Not Hate"))
}
#for example
text="try to look for a different picture to share on insta you ugly slut hhhhhh"
predict_hate(text, comments_classifer,comment_dtm)
#RESult=
#[1] "Hate Speech"

           