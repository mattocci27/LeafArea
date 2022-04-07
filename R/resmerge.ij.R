#' File management
#'
#' File management function. The output file contains sample names in the first column and total leaf area (cm2) of the sample (e.g., one individual plant or one ramet) in the second column.
#'
#' @importFrom stats aggregate
#' @author Masatoshi Katabuchi \email{mattocci27@gmail.com}
#' @export
#' @param path Path to the target directory
#' @param prefix Regular expression to manage file names
#' @return A data frame of total leaf area for each sample
#' @return \item{sample}{Name of sample}
#' @return \item{total.leaf.area}{Total leaf area of the sample (cm2)}
#' @examples
#' # prepare example files
#' data(leafdata)
#' tf <- paste(tempdir(), "/", sep = "")
#' for (i in 1:7) {
#'   write.table(leafdata[[i]], paste(tf, names(leafdata)[i], sep = ""), sep = "\t")
#' }
#'
#' # list of files
#' list.files(tf)
#'
#' # combine multiple tab-delimited text files with a leaf area value
#' # (one text file for each original JPEG image file) that share the same
#' # filename 'prefix', defined as the part of the filename preceding the first
#' # hyphen (-) or period (.).
#' resmerge.ij(tf)
#'
#' # combine multiple tab-delimited text files with a leaf area value
#' # (one text file for each original JPEG image file) that share the same
#' # filename 'prefix', defined as the part of the filename preceding the first
#' #' .txt'.
#' resmerge.ij(tf, prefix = ".txt")
#'
#' unlink(list.files(tf))
resmerge.ij <- function(path, prefix = "\\.|-") {
  temp0 <- readtext.ij(path)
  temp_area <- sapply(sapply(temp0, "[", 1), sum)
  temp_perim <- sapply(sapply(temp0, "[", 2), sum)

  temp.data <- data.frame(
    file.name = names(temp_area),
    size = temp_area,
    perim = temp_perim
  )
  temp.data$file.name <- factor(sapply(strsplit(as.character(temp.data$file.name), prefix), "[", 1))
  # return(temp.data)
  res <- aggregate(
    list(temp.data["size"], temp.data["perim"]),
    temp.data["file.name"], sum
  )
  names(res) <- c("sample", "total.leaf.area", "perimeter")
  return(res)
}
