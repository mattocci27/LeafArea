# LeafArea
The package LeafArea allows one to conveniently run ImageJ software within R. The package provides a user-friendly, automated tool for measuring leaf area from digital images. For more information on ImageJ, see the ImageJ User Guide, which is available [http://imagej.nih.gov/ij/](url).

Maintainer: Masatoshi Katabuchi

## 1 Prerequisites
From within R (>= 3.0.0), you can install:
* the latest version of LeafArea from CRAN within `install.packages(“LeafArea”)`
* the latest development version from github within
`devtools::install_gitub(mattocci27/LeafArea)`

The package LeafArea needs ImageJ software, which is available from http://imagej.nih.gov/ij/. Details on how to install ImageJ on Linux, Mac OS X and Windows are available at http://imagej.nih.gov/ij/docs/install/. For Mac, the default install directory of ImageJ is “/Applications/ImageJ”. For Windows, "C:/Program Files/ImageJ”. Otherwise, you need to specify the path to ImageJ to use LeafArea in R (see 3.1 Setting path to ImageJ). Note that in Linux system, ImageJ should be installed from the above URL instead of command lines. Java is also required, which is available at https://java.com/en/.

## 2 Image capture and file naming
Capture leaf images by using a scanner and save them as jpeg or tiff files. Image size and resolution should be consistent across all the image files because the `LeafArea` functions estimate leaf area based on leaf pixel counts and the image size. Therefore, the `LeafArea` package does not support images from digital cameras, where the resolution depends on the distance of the camera to the object.

The `LeafArea` combines the leaf area of all images that share the same filename “prefix”, defined as the part of the filename preceding the first hyphen (-) or period (.) that may occur. For example, the areas of leaf images named A123-1.jpeg, A123-2.jpeg, and A123-3.jpeg would be combined into a single total leaf area (A123). This feature allows the user to treat multiple images as belonging to a single sample, if desired. Note that the functions in the package do not count the number of leaves in each image. If the user requires the number of leaves per image, the user must record these values by themselves.

## 3 How to run LeafArea
### 3.1 Setting path to ImageJ
When ImageJ is not installed in the common install directory, you need to specify the path to ImageJ in run.ij. This depends on the operating system being used (Windows, Linux or Mac). For example, when ImageJ is installed in a directory named “ImageJ” on the desktop of a Mac or Linux system, you can specify the path by `typing run.ij (path.imagej = "~/Desktop/ImageJ")`. Typing `run.ij (path.imagej = ”C:/Users/<username>/Desktop/Imagej”)` works in Windows.

### 3.2 Setting path to leaf images
To analyze your leaf images, you need to specify the path to directory that contains leaf images. This depends on the operating system being used (Windows, Linux or Mac). For example, when the target directory named "leaf data" is on desktop of Mac or Linux, you can specify the path by typing `run.ij (set.directory = "~/Desktop/leaf data/")`. Typing `run.ij (set.directory = "C:/Users/<username>/Desktop/leaf data")` works in Windows.

## 3.3 Example
This is an example in the R help. First, I use `eximg` function to specify the path to example leaf images in the R temporary directory. Then, I run the `run.ij` function which will analyze leaf area automatically:

	ex.dir <- eximg()
	res <- run.ij(set.direcotry = ex.dir)
