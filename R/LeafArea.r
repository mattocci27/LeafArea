#' LeafArea: Rapid digital image analysis of leaf area
#'
#' The package LeafArea allows one to conveniently run ImageJ software within R. The package provides a user-friendly, automated tool for measuring leaf area from digital images. For more information on ImageJ, see the ImageJ User Guide, which is available \url{http://imagej.nih.gov/ij/}.
#'
#' The key function in this package is \code{\link{run.ij}}, which analyzes multiple leaf images in the target directory and generates multiple data frame objects that include leaf area from each leaf image, and then processes and combines these data frame objects into a single data frame object that is convenient for subsequent analyses.
#'
#' If ImageJ fails to recognize leaf images, users can manually guide the image analysis for particular images through ImageJ GUI (See the ImageJ user guide 30.1 Measure...[m], \url{http://imagej.nih.gov/ij/docs/guide/user-guide.pdf}). The results for these manually-analyzed images will still be handled by the file management function \code{\link{resmerge.ij}}.
#'
#' @author \strong{Maintainer}: Masatoshi Katabuchi \email{mattocci27@gmail.com}
#' @references Rasband, W.S., ImageJ, U. S. National Institutes of Health, Bethesda, Maryland, USA,  \url{http://imagej.nih.gov/ij/}, 1997-2014.
#' @references Schneider, C.A., Rasband, W.S., Eliceiri, K.W. "NIH Image to ImageJ: 25 years of image analysis". Nature Methods 9, 671-675, 2012.
#' @references Abramoff, M.D., Magalhaes, P.J., Ram, S.J. "Image Processing with ImageJ".
#' Biophotonics International, volume 11, issue 7, pp. 36-42, 2004. (This article is available \url{https://www.researchgate.net/publication/228334776_Image_Processing_with_Image}.)
#' #'
#' @keywords internal
"_PACKAGE"

#' @importFrom stats aggregate
#' @importFrom utils read.delim
NULL
