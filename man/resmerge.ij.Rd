\name{resmerge.ij}
\alias{resmerge.ij}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
File management
}
\description{
File management function. The output file contains sample names in the first column and total leaf area (cm2) of the sample (e.g., one individual plant or one ramet) in the second column.
}
\usage{
resmerge.ij(path, prefix = "\\\\.|-")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{path}{
Path to the target directory
}
  \item{prefix}{
Regular expression to manage file names}
}

\value{
A data frame of total leaf area for each sample
    \item{sample}{
    Name of sample
    }
    \item{total.leaf.area}{
    Total leaf area of the sample (cm2)
    }
}

\details{
The resmerge.ij combines multiple tab-delimited text files with a leaf area value (one text file for each original JPEG image file) that share the same filename 'prefix', defined as the part of the filename preceding the first hyphen (-) or period (.) that may occur (no hyphen or period is required). For example, the areas of leaf images named A123-1.jpeg.txt, A123-2.jpeg.txt, and A123-3.jpeg.txt would be combined into a single total leaf area (A123). This feature allows the user to treat multiple images as belonging to a single sample, if desired. Note that the resmerge.ij does not count the number of leaves in each image; therefore if the user requires the number of leaves per image, the user must record these values.
}

\author{
Masatoshi Katabuchi <mattocci27@gmail.com>}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{run.ij}}
\code{\link{readtext.ij}}
}
\examples{
#prepare example files
data(leafdata)
tf <- paste(tempdir(),"/",sep="")
for (i in 1:7){
	write.table(leafdata[[i]],paste(tf,names(leafdata)[i],sep=""),sep="\t")
}

#list of files
list.files(tf)

#combine multiple tab-delimited text files with a leaf area value 
#(one text file for each original JPEG image file) that share the same
#filename 'prefix', defined as the part of the filename preceding the first 
#hyphen (-) or period (.).
resmerge.ij(tf)

##combine multiple tab-delimited text files with a leaf area value 
#(one text file for each original JPEG image file) that share the same
#filename 'prefix', defined as the part of the filename preceding the first 
#'.txt'.
resmerge.ij(tf,prefix=".txt")

unlink(list.files(tf))
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

