#' Automated leaf area analysis
#'
#' Analyzes leaf area in the target directory automatically, and returns a 
#' data frame that contains sample names in the first column and total leaf 
#' area (cm2) of the sample (e.g., one individual plant or one ramet) in the 
#' second column. Note that `run.ij` does not count the number of leaves in 
#' each image; therefore if the user requires the number of leaves per image, 
#' the user must record these values.
#'
#' @param path.imagej Path to ImageJ. Default uses C:/Program Files/ImageJ 
#' for Windows, and /Applications/ImageJ for Mac. Linux always needs to 
#' specify the path to ImageJ
#' @param set.memory Set memory (GB) for image analysis (default = 4).
#' @param set.directory Set directory that contains leaf images. For example, 
#' when the directory named 'leaf_data' is on desktop of Mac, the path can be 
#' specified as: set.directory = '~/Desktop/leaf_data'. For Windows: 
#' set.directory = 'C:/Users/<users name>/Desktop/leaf_data'. No default. The 
#' path to the target directory that contains leaf images should always be 
#' specified. Note that spaces in file or directory names are not allowed.
#' @param distance.pixel Number of pixels for the known distance. When leaf 
#' images were captured in A4 image size with 100 ppi, the pixel density is 
#' roughly equal to 826 pixels per 21 cm. In this case, the calibration scale 
#' can be specified as distance.pixel = 826, known.distance = 21.
#' @param known.distance Known distance (cm). See distance.pixel.
#' @param trim.pixel Number of pixels removed from edges in the analysis. The 
#' edges of images are often shaded, which can affect image analysis (i.e., 
#' ImageJ may recognize the shaded area as leaf area). The edges of images can 
#' be removed by specifying the number of pixels (default = 20).
#' @param low.circ Lower limit for circularity for the image analysis. When 
#' the user wants to remove angular objects (e.g., cut petioles, square papers 
#' for scale) from the images, the analyzed lower limit of circularity can be 
#' increased (default = 0).
#' @param upper.circ Upper limit for circularity for the image analysis 
#' (default = 1). See low.circ.
#' @param low.size Lower limit for size for the image analysis. Leaf images 
#' often contain dirt and dust. To prevent dust from affecting the image analysis, 
#' the lower limit of analyzed size can be increased (default = 0.7).
#' @param upper.size Upper limit for size for the image analysis (default = 
#' Infinity').
#' @param prefix Regular expression to manage file names. The `run.ij` combines 
#' the leaf area of all images that share the same filename 'prefix', defined 
#' as the part of the filename preceding the first hyphen (-) or period (.) 
#' that may occur (no hyphen or period is required). For example, the areas of 
#' leaf images named A123-1.jpeg, A123-2.jpeg, and A123-3.jpeg would be 
#' combined into a single total leaf area (A123). This feature allows the user 
#' to treat multiple images as belonging to a single sample, if desired 
#' (default = '\\\\.|-').
#' @param log Should mean leaf areas of each single image kept? 
#' (default = FALSE)
#' @param check.image Whether to display analyzed images by using ImageJ 
#' software (default = FALSE). When you choose check.image = TRUE, press any 
#' keys to close ImageJ. Note that when check.image = TRUE, the analysis would 
#' take considerable time. Note this option may only work on R console.
#' @param save.image Whether to save analyzed images (default = FALSE).
#' @return A data frame of total leaf area for each sample.
#' @return \item{sample}{Name of sample}
#' @return \item{total.leaf.area}{Total leaf area of the sample (cm2)}
#' @return If you choose log= T, the `run.ij` function also returns a list of 
#' data frames of leaf area for each image.
#' @return \item{area}{Area of the sample (cm2)}
#' @author Masatoshi Katabuchi \email{mattocci27@gmail.com}
#' @seealso \code{\link{resmerge.ij}}, \code{\link{readtext.ij}}, \code{\link{eximg}}
#' @examples
#' # As long as ImageJ application, including `ij.jar` and java, is installed 
#' # in the following directory,
#' # you do not have to specify the path to ImageJ
#' # /Applications/ImageJ <Mac>
#' # C:/Program Files/ImageJ <Windows>
#' # Linux always needs to specify the path to the directory that contains `ij.jar`.
#' # For example, path = "~/ImageJ"
#' 
#' # prepare the target directory that contains example image files
#' ex.dir <- eximg()
#' list.files(ex.dir)
#' 
#' #run automated images analysis
#' run.ij(set.directory = ex.dir, save.image = TRUE)
#' 
#' # note: in this example, analyzed images are exported to a temporary
#' # directory, which will be eventually deleted.
#' # If you choose your home directory as the target directory,
#' # analyzed images will be exported to it.

run.ij <- function(path.imagej = NULL, set.memory = 4, set.directory,
                   distance.pixel = 826, known.distance = 21, trim.pixel = 20,
                   low.circ = 0, upper.circ = 1, low.size = 0.7,
                   upper.size = "Infinity", prefix = "\\.|-", log = F,
                   check.image = F, save.image = F){

  file.list <- list.files(set.directory)
  file.list <- file.list[grep(".jpeg$|.jpg$|.JPEG$|.JPG$|.tif$|.tiff$|.Tif$|.Tiff$", file.list)]

  if (length(file.list) == 0) return("No images in the directory")

  temp.slash <- substr(set.directory, nchar(set.directory),
                       nchar(set.directory))
  if (temp.slash != "/" & temp.slash != "\\"){
    set.directory <- paste(set.directory, "/", sep = "")
  }

  circ.arg <- paste(low.circ, upper.circ, sep = "-")
  size.arg <- paste(low.size, upper.size, sep = "-")


  os <- .Platform$OS.type
  if (is.null(path.imagej) == T){
    imagej <- find.ij(ostype = .Platform$OS.type)
    if (imagej == "ImageJ not found"){
      return("ImageJ not found")
    }  else path.imagej <- imagej
  }

  ##additional check
  if (os == "windows"){
    #slash is replaced by backslash because they don't work in batch
    path.imagej <- gsub("/", "\\\\", path.imagej)

    if (file.exists(paste(path.imagej, "ij.jar", sep = "")) != T &
       file.exists(paste(path.imagej, "ij.jar", sep = "/")) != T) {
      warning("ij.jar was not found. Specify the correct path to
              ImageJ directory or reinstall ImageJ bundled with Java")
              return("ImageJ not found")
    } else if (file.exists(paste(path.imagej, "jre/bin/java.exe", sep = "")) != T &
               file.exists(paste(path.imagej, "jre/bin/java.exe", sep = "/")) != T) {
      warning("java was not found. Specify the correct path to
              ImageJ directory or reinstall ImageJ bundled with Java")
              return("ImageJ not found")
    }
  } else {
    unix.check <- Sys.info()["sysname"]
    if (unix.check == "Linux") {
      if (file.exists(paste(path.imagej, "ij.jar", sep = "")) != T &
         file.exists(paste(path.imagej, "ij.jar", sep = "/")) != T) {
        warning("Specify the correct path to ImageJ")
        return("ImageJ not found")
         }
    } else if (unix.check == "Darwin"){
      if (file.exists(paste(path.imagej,
         "Contents/Java/ij.jar", sep = "")) != T &
         file.exists(paste(path.imagej,
         "Contents/Java/ij.jar", sep = "/")) != T) {
        warning("Specify the correct path to ImageJ.app")
      return("ImageJ not found")
      }
    }
  }

  if (os == "windows"){
    temp <- paste(tempdir(), "\\", sep = "")
    temp <- gsub("\\\\", "\\\\\\\\", temp)
   } else {
    temp <- paste(tempdir(), "/", sep = "")
  }

  if (save.image == T) {
    macro <- paste(
     'dir = getArgument;\n
     dir2 = "', temp, '";\n
     list = getFileList(dir);\n
     open(dir + list[0]);\n
     run("Set Scale...", "distance=',distance.pixel, ' known=', known.distance,
         ' pixel=1 unit=cm global");\n
     for (i=0;\n i<list.length;\n i++) { open(dir + list[i]);\n
     width = getWidth() - ',trim.pixel, ';\n
     height = getHeight() -',trim.pixel, ' ;\n
     run("Canvas Size...", "width=" + width +
         " height=" + height + " position=Bottom-Center");\n
     run("8-bit");\n
     run("Threshold...");\n
     setAutoThreshold("Minimum");\n
     run("Analyze Particles...", "size=', size.arg,
         ' circularity=', circ.arg,' show=Masks display clear record");\n
     saveAs("Measurements", dir2+list[i]+".txt");\n saveAs("tiff", dir+list[i]+ "_mask.tif");\n
     }', sep = "")
  } else {
    macro <- paste(
     'dir = getArgument;\n
     dir2 = "', temp, '";\n
     list = getFileList(dir);\n
     open(dir + list[0]);\n
     run("Set Scale...", "distance=',distance.pixel, ' known=', known.distance,
         ' pixel=1 unit=cm global");\n
     for (i=0;\n i<list.length;\n i++) { open(dir + list[i]);\n
     width = getWidth() - ',trim.pixel, ';\n
     height = getHeight() -',trim.pixel, ' ;\n
     run("Canvas Size...", "width=" + width +
         " height=" + height + " position=Bottom-Center");\n
     run("8-bit");\n
     run("Threshold...");\n
     setAutoThreshold("Minimum");\n
     run("Analyze Particles...", "size=', size.arg,
         ' circularity=', circ.arg,' show=Masks display clear record");\n
         saveAs("Measurements", dir2+list[i]+".txt");\n
     }', sep = "")
  }


  #prepare macro***.txt as tempfile
  tempmacro <- paste(tempfile('macro'), ".txt", sep = "")

  write(macro, file = tempmacro)
  # write(macro, file="~/Desktop/moge.txt")
  # pathimagej <- system.file("java",package="LeafArea")

  if (check.image == T) {
    exe <- "-macro "
    wait <- FALSE
  } else {
    exe <- "-batch "
    wait <- TRUE
  }

  #use it in imageJ
  if (os == "windows"){

    if (length(strsplit(set.directory, " ")[[1]]) > 1) {
      bat <- paste(
        "pushd ", path.imagej, "\n jre\\bin\\java -jar -Xmx",
        set.memory, "g ij.jar ",
        exe , tempmacro, ' "', set.directory, '"\n pause\n exit', sep = "")
    } else {
      bat <- paste(
        "pushd ", path.imagej, "\n jre\\bin\\java -jar -Xmx",
        set.memory, "g ij.jar ",
        exe , tempmacro," ",set.directory,"\n pause\n exit", sep = "")
    }
    tempbat <- paste(tempfile('bat'), ".bat", sep = "")

    write(bat, file = tempbat)

    shell(tempbat, wait = wait)

  } else {
    temp.slash2 <- substr(path.imagej, nchar(path.imagej), nchar(path.imagej))
    if(temp.slash2!="/" ){
      path.imagej <- paste(path.imagej, "/", sep = "")
    }

    # this allows space in path
    set.directory <- gsub(" ", "\\ ", set.directory, fixed = TRUE)

    unix.check <- Sys.info()["sysname"]
    if (unix.check == "Linux") {
      system(paste("java -Xmx", set.memory, "g -jar ", path.imagej,
        "ij.jar -ijpath ", path.imagej," ", exe,tempmacro," ", set.directory,
        sep = ""), wait = wait)
      } else {
      #system(paste("java -Xmx", set.memory, "g -jar ", path.imagej,
      # "Contents/Resources/Java/ij.jar -ijpath ", path.imagej, " ", exe,
      # tempmacro, " ", set.directory, sep = ""), wait = wait)
      system(paste("java -Xmx", set.memory, "g -jar ", path.imagej,
       "Contents/Java/ij.jar -ijpath ", path.imagej, " ", exe,
       tempmacro, " ", set.directory, sep = ""), wait = wait)
    }
  }

  #kill imageJ
  if (check.image == T){
    ans <- readline("Do you want to close ImageJ?
                    Press any keys when you finish cheking analyzed images.")
    if (os == "windows") suppressWarnings(shell('taskkill /f /im "java.exe"'))
    else {
      system("killall java")
    }
  }

  # file managemanet
  res <- resmerge.ij(path = temp, prefix = prefix)

  if (log == T) res2 <- readtext.ij(path = temp)

  # unlink
  cd <- getwd()
  setwd(temp)
  unlink(list.files(temp))
  setwd(cd)

  if (log == T) return(list(summary = res, each.image = res2)) else return(res)

}


# moge <- "~/Desktop/LeafAreaDemo/" # Mac

# # moge <- "..\\Desktop\\LeafAreaDemo\\" # Mac

# res <- auto.run(set.directory=moge,log=T)


# system(paste("java -Xmx",set.memory,"g -jar /Applications/ImageJ/ImageJ64.app/Contents/Resources/Java/ij.jar -ijpath /Applications/ImageJ"," -macro ~/Desktop/moge.txt ",set.directory,sep=""))
