#' @importFrom stats aggregate

resmerge.ij <- function(path, prefix = "\\.|-"){
  temp0 <- readtext.ij(path)
  temp <- sapply(temp0, sum)
  temp.data <- data.frame(file.name = names(temp), size = temp)
  #temp.data$file.name <- factor(sapply(strsplit(as.character(temp.data$file.name), prefix), "[", 1))

  tmp1 <- strsplit(as.character(temp.data$file.name), prefix)
  tmp1 <- sapply(tmp1, "[", 1)
  temp.data$file.name <- factor(tmp1)
  res <- aggregate(temp.data["size"], temp.data["file.name"], sum)
  names(res) <- c("sample", "total.leaf.area")
  return(res)
}
