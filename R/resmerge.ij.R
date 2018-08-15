#' @importFrom stats aggregate

resmerge.ij <- function(path, prefix = "\\.|-"){
  temp0 <- readtext.ij(path)
  temp_area <- sapply(sapply(temp0, "[", 1), sum)
  #temp_perim <- sapply(sapply(temp0, "[", 2), sum)

  temp.data <- data.frame(file.name = names(temp_area),
            size = temp_area)
            #perim = temp_perim)
  temp.data$file.name <- factor(sapply(strsplit(as.character(temp.data$file.name), prefix), "[",1))
  # return(temp.data)
  #res <- aggregate(list(temp.data["size"], temp.data["perim"]),
  #  temp.data["file.name"], sum)
  res <- aggregate(temp.data["size"],temp.data["file.name"],sum)
  #names(res) <- c("sample", "total.leaf.area", "perimeter")
  names(res) <- c("sample", "total.leaf.area")
  return(res)
}
