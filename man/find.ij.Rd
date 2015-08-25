\name{find.ij}
\alias{find.ij}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Checking a path to ImageJ}
\description{
Check if ImageJ is installed in the correct directory.
}
\usage{
find.ij(ostype = .Platform$OS.type)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ostype}{
The Operating system types.
}
}

\value{
A path for ImageJ application. On unix this will always be "/Applications/ImageJ/". On Windows this will always be "C:\\Program Files\\ImageJ\\". 
}

\details{
When ImageJ, including ij.jar and Java, is not installed in the common location, users need to specify the path to ImageJ in \code{\link{run.ij}}.	
}

\author{
Masatoshi Katabuchi <mattocci27@gmail.com>}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line

