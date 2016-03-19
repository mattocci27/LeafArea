# LeafArea
The package LeafArea allows one to conveniently run ImageJ software within R. The package provides a user-friendly, automated tool for measuring leaf area from digital images. For more information on ImageJ, see the ImageJ User Guide, which is available [http://imagej.nih.gov/ij/](url).

Maintainer: Masatoshi Katabuchi

1 Prerequisites 
From within R (>= 3.0.0), you can install the latest version of LeafArea by typing install.packages(“LeafArea”).

The package LeafArea needs ImageJ software, which is available from http://imagej.nih.gov/ij/. Details on how to install ImageJ on Linux, Mac OS X and Windows are available at http://imagej.nih.gov/ij/docs/install/. For Mac, the default install directory of ImageJ is “/Applications/ImageJ”. For Windows, "C:/Program Files/ImageJ”. Otherwise, you need to specify the path to ImageJ to use LeafArea in R (see 3.1 Setting path to ImageJ). Note that in Linux system, ImageJ should be installed from the above URL instead of command lines. Java is also required, which is available at https://java.com/en/.

