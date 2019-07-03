#' Checking a path to ImageJ
#'
#' Check if ImageJ is installed in the correct directory.
#'
#' When ImageJ, including ij.jar and Java, is not installed in the common location, users need to specify the path to ImageJ in \code{\link{run.ij}}.
#'
#' @param ostype the Operating system types.
#' @return A path for ImageJ application. On unix this will always be 
#' "/Applications/ImageJ/". On Windows this will always be "C:\\Program Files\\ImageJ\\".
#' @author Masatoshi Katabuchi \email{mattocci27@gmail.com}
#' @export


##works in Mac
find.ij <- function(ostype = .Platform$OS.type){
  if (ostype == "windows"){
    if (file.exists("\\Program Files\\ImageJ\\ij.jar") != T || file.exists("\\Program Files\\ImageJ\\jre\\bin\\java.exe") != T) {
      warning("ij.jar or java were not found in the common install location on your system; When you run run.ij, specify the path to ImageJ directory or try installing ImageJ bundled with Java to C:\\Program Files\\ ")
      return("ImageJ not found")} else return("C:\\Program Files\\ImageJ\\")
    } else {
      unix.check <- Sys.info()["sysname"]
    if (unix.check == "Linux") {
      warning("Specify the path to the directory that contains ImageJ.app and ij.jar")
    return("ImageJ not found")
    } else {
      imagej <- system("mdfind -name ImageJ | grep 'ImageJ.app'", intern = TRUE)
      if(length(imagej) != 0) return(imagej) else {
        warning("ImageJ.app was not found in the common install location on your system; When you run run.ij, specify the path to ImageJ.app")
        return("ImageJ not found")
            }
      }
    }
}
