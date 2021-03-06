#################################################################################
### Read, Clean txt files of a given file directory and Sort by letter length ###
#################################################################################

### Authors: Hongru Liu
### Project 4 Group 6

### Read a single txt file from the given file path
### input: a single txt file path
### output: one string
get_text <- function(file_path) {
  text_lines <- readLines(file_path, warn=FALSE)
  text_oneline <- paste0(text_lines, collapse = " ")
  #text_words <- unlist(strsplit(text_oneline," "))
  return(text_oneline)
  #return(text_words)
}  

### Remove all numbers, punctuations, special symbols for a given string
### input: one string
### output: cleaned string
clean_text <- function(oneline) {
  cleaned_oneline <- clean(oneline)
  matches <- gregexpr("[^A-Za-z[:space:]]",cleaned_oneline)
  regmatches(cleaned_oneline,matches) <- ''
  corpus <- VCorpus(VectorSource(cleaned_oneline))%>%
    tm_map(content_transformer(tolower))%>%
    #tm_map(removePunctuation)%>%
    #tm_map(removeNumbers)%>%
    tm_map(removeWords, character(0))%>%
    tm_map(stripWhitespace)
  cleaned_oneline <- corpus[[1]][[1]]
  if (substr(cleaned_oneline,1,1)==" ") {
    cleaned_oneline <- substring(cleaned_oneline, 2)
  }
  text_word <- unlist(strsplit(cleaned_oneline," "))
  return(text_word)
}

### Sort the given string by letter length
### input: one string
### output: a list with each element containing words with same length and having proper name 
sort_by_length <- function(words) {
  text_word_length <- sapply(words, nchar)
  k <- 0
  text_by_length <- list()
  len <- c()
  for (i in levels(factor(text_word_length))) {
    k <- k+1
    len[k] <- i
    text_by_length[[k]] <- words[text_word_length==i]
  }
  names(text_by_length) <- paste0("l_",len)
  return(text_by_length)
}