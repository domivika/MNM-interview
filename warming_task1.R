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
