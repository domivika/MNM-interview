str2change <- function(string){
  x <- list(paste0(unlist(lapply(1:nchar(string),function(x){
    let <- substr(string,x,x)
    ifelse(x %% 2,let,toupper(let))
  })),collapse = ""),
  paste0(unlist(lapply(1:nchar(string),function(x){
    let <- substr(string,x,x)
    ifelse(x %% 2,toupper(let),let)
  })),collapse = ""))
  x <- unlist(x)
  x
}

str2change("abcdef")


countLetters <- function(string){
  letters_table <- table(unlist(lapply(1:nchar(string),function(x){
    tolower(substr(string,x,x))
  })))
  length(letters_table[letters_table>=2])
}

countLetters("AaAbBCcD") # should give only 3 duplicates <- D is single
