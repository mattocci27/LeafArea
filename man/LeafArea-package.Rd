\name{LeafArea-package}
\alias{LeafArea-package}
\alias{LeafArea}
\docType{package}
\title{
LeafArea: Rapid digital image analysis of leaf area
}
\description{
The package LeafArea allows one to conveniently run ImageJ software within R. The package provides a user-friendly, automated tool for measuring leaf area from digital images. For more information on ImageJ, see the ImageJ User Guide, which is available \url{http://imagej.nih.gov/ij/}.
}

\details{
 The key function in this package is \code{\link{run.ij}}, which analyzes multiple leaf images in the target directory and generates multiple data frame objects that include leaf area from each leaf image, and then processes and combines these data frame objects into a single data frame object that is convenient for subsequent analyses.

 If ImageJ fails to recognize leaf images, users can manually guide the image analysis for particular images through ImageJ GUI (See the ImageJ user guide 30.1 Measure...[m], \url{http://imagej.nih.gov/ij/docs/guide/user-guide.pdf}). The results for these manually-analyzed images will still be handled by the file management function \code{\link{resmerge.ij}}.

\tabular{ll}{
Package: \tab LeafArea\cr
Type: \tab Package\cr
Version: \tab 0.1.1\cr
Date: \tab 2015-07-05\cr
License: \tab GPL-2\cr
}

}
\author{
Masatoshi Katabuchi <mattocci27@gmail.com>
}
\references{
Rasband, W.S., ImageJ, U. S. National Institutes of Health, Bethesda, Maryland, USA,  \url{http://imagej.nih.gov/ij/}, 1997-2014.\cr

Schneider, C.A., Rasband, W.S., Eliceiri, K.W. "NIH Image to ImageJ: 25 years of image analysis". Nature Methods 9, 671-675, 2012.\cr

Abramoff, M.D., Magalhaes, P.J., Ram, S.J. "Image Processing with ImageJ". Biophotonics International, volume 11, issue 7, pp. 36-42, 2004. (This article is available \url{http://dspace.library.uu.nl/handle/1874/204900}.)\cr
}
\keyword{ package }
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

