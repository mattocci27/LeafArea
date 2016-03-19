[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/LeafArea)](http://cran.r-project.org/package=LeafArea)
# LeafArea
The package LeafArea allows one to conveniently run ImageJ software within R. The package provides a user-friendly, automated tool for measuring leaf area from digital images. For more information on ImageJ, see the ImageJ User Guide, which is available [http://imagej.nih.gov/ij/](url).


The ImageJ function `run.ij` computes the total area of all leaves (or leaf sections) in each image file in the target directory. Original leaf images are converted to black and white from threshold intensity levels, then leaf area is calculated by using leaf pixel counts and the calibration scale. The user can determine if the analyzed images will be saved for error checking: `run.ij (save.image = TRUE)` or `run.ij (save.image = FALSE)`.

<img src="https://github.com/mattocci27/LeafArea/blob/master/vignettes/Fig1_final.tif", width="320px">


## 1 Prerequisites
From within R (>= 3.0.0), you can install:
* the latest version of LeafArea from CRAN with
    ````r
    install.packages(“LeafArea”)
    ````

* the latest development version from github with
    ````r
    # install.packages("devtools")
    devtools::install_gitub(mattocci27/LeafArea)
    ````
The package LeafArea requires ImageJ software, which is available from http://imagej.nih.gov/ij/. Details on how to install ImageJ on Linux, Mac OS X and Windows are available at http://imagej.nih.gov/ij/docs/install/. For Mac, the default install directory of ImageJ is “/Applications/ImageJ”. For Windows, "C:/Program Files/ImageJ”. Otherwise, you need to specify the path to ImageJ to use LeafArea in R (see 3.1 Setting path to ImageJ). Note that in Linux system, ImageJ should be installed from the above URL instead of via the command lines. Java is also required, which is available at https://java.com/en/.

## 2 Image capture and file naming
Capture leaf images by using a scanner and save them as jpeg or tiff files. Image size and resolution should be consistent across all the image files because the `LeafArea` functions estimate leaf area based on leaf pixel counts and the image size. Therefore, the `LeafArea` package does not support images from digital cameras, where the resolution depends on the distance of the camera to the object.

The `LeafArea` combines the leaf area of all images that share the same filename “prefix”, defined as the part of the filename preceding the first hyphen (-) or period (.) that may occur. For example, the areas of leaf images named A123-1.jpeg, A123-2.jpeg, and A123-3.jpeg would be combined into a single total leaf area (A123). This feature allows the user to treat multiple images as belonging to a single sample, if desired. Note that the functions in the package do not count the number of leaves in each image. If the user requires the number of leaves per image, the user must record these values by themselves.

![moge](https://github.com/mattocci27/LeafArea/blob/master/vignettes/Fig2_final.png)

## 3 How to run LeafArea
### 3.1 Setting path to ImageJ
When ImageJ is not installed in the common install directory, you need to specify the path to ImageJ in run.ij. This depends on the operating system being used (Windows, Linux or Mac). For example, when ImageJ is installed in a directory named “ImageJ” on the desktop of a Mac or Linux system, you can specify the path by `typing run.ij (path.imagej = "~/Desktop/ImageJ")`. Typing `run.ij (path.imagej = ”C:/Users/<username>/Desktop/Imagej”)` works in Windows.

### 3.2 Setting path to leaf images
To analyze your leaf images, you need to specify the path to directory that contains leaf images. This depends on the operating system being used (Windows, Linux or Mac). For example, when the target directory named "leaf data" is on desktop of Mac or Linux, you can specify the path by typing `run.ij (set.directory = "~/Desktop/leaf data/")`. Typing `run.ij (set.directory = "C:/Users/<username>/Desktop/leaf data")` works in Windows.

## 3.3 Example
This is an example in the R help. First, I use `eximg` function to specify the path to example leaf images in the R temporary directory. Then, I run the `run.ij` function which will analyze leaf area automatically:
```` r
ex.dir <- eximg()
res <- run.ij(set.direcotry = ex.dir)
````

The object `ex.dir` is the path to the R temporary directory that contains example leaf images. This temporary directory will be eventually deleted after the analysis. The object `res`, returned from `LeafArea` is a data frame object, which contains name of samples in the first column and total leaf area of sample (cm<sup>2</sup>) in the second column.

```` r
res
#>   sample  total.leaf.area
#> 1     A1         350.340
#> 2   A123         418.473
#> 3     A2         177.188
#> 4   A300         384.919
````
## 4 Automated leaf area analysis
You can change the following setting according to your images.

### 4.1 Spatial calibration
You need to tell `LeafArea` what a pixel represents in real-world terms of distance. When leaf images are captured in A4 image size with 100 ppi, the pixel density is roughly equal to 826 pixels per 21 cm. In this case, the calibration scale can be specified as `run.ij (distance.pixel = 826, known.distance =21)``.

### 4.2 Memory setting
The amount of memory available can be increased. By default, `LeafArea` uses 4 GB of memory. Typing `run.ij (set.memory = 8)` will allocate 8 GB of memory to `LeafArea`.

### 4.3 Trimming images
The edges of images may have shadowing, which can affect image analysis (i.e., ImageJ may recognize the shaded area as leaf area). The edges of images can be removed by specifying the number of pixels (default = 20). For example, `run.ij (trim.pixel = 20)` will remove 20 pixels from the edges of each image.

<img src="https://github.com/mattocci27/LeafArea/blob/master/vignettes/trim.png" width="320">

### 4.4 Size and circularity
Leaf images often contain dirt and dust. To prevent dust from affecting the image analysis, the lower limit of analyzed size can be specified. For example, typing `run.ij (low.size = 0.7)` will remove objects smaller than 0.7 cm<sup>2</sup> in the analysis.

<img src="https://github.com/mattocci27/LeafArea/blob/master/vignettes/size.png" width="320">


When you want to remove angular objects (e.g., cut petioles, square papers for scale) from the images, the analyzed lower limit of circularity can be increased (default = 0). For example, `run.ij (low.circ = 0.3)` will skip cut petioles from the analysis.

<img src="https://github.com/mattocci27/LeafArea/blob/master/vignettes/circ.png" width=320">


### 4.5 File naming
By default, the `LeafArea` combines the leaf area of all images that share the same filename “prefix”, defined as the part of the filename preceding the first hyphen (-) or period (.) that may occur. You can change this setting by using regular expressions. For example, typing `run.ij (prefix = ‘\\.|-|_’)` will combine the area of leaf images named A123-1.jpeg, A123-2_1.jpeg, A123-2_1.jpeg into a single total leaf area (A123).

### 4.6 Result log
A list object of data frames of area (cm<sup>2</sup>) of each object in each image can be returned by typing `run.ij (log = T)`:

```` r
ex.dir <- eximg()
run.ij(set.directory = ex.dir, log = T)

#> $summary
#>   sample total.leaf.area
#> 1     A1         350.340
#> 2   A123         418.473
#> 3     A2         177.188
#> 4   A300         384.919
#>
#> $each.image
#> $each.image$`A1-01.jpeg.txt`
#>      Area
#> 1 116.799
#> 2 124.069
#>
#> $each.image$`A1-02.jpeg.txt`
#>      Area
#> 1 109.472
#>
#> $each.image$`A123-01.jpeg.txt`
#>      Area
#> 1 184.773
#>
#> $each.image$`A123-02.jpeg.txt`
#>      Area
#> 1 123.151
#> 2 110.549
#>
#> $each.image$A2.jpeg.txt
#>     Area
#> 1 43.328
#> 2 47.558
#> 3 41.427
#> 4 44.875
#>
#> $each.image$`A300-1.jpeg.txt`
#>      Area
#> 1 158.065
#>
#> $each.image$`A300-2.jpeg.txt`
#>      Area
#> 1 124.784
#> 2 102.070
````
By default, `run.ij` returns a single data frame object, which contains name of samples in the first column and total leaf area of sample (cm<sup>2</sup>) in the second column (see 3.0).


### 4.7 Saving analyzed images
Analyzed images can be exported in the same directory as `set.directory` for error checking. Typing `run.ij (save.image = TRUE)` will export analyzed images. If you use the eximg function to set the target directory, analyzed images will be exported to a temporary directory, which will be eventually deleted. If you choose your home directory as the target directory, analyzed images will be exported to it.

### 4.7 Displaying analyzed images
Analyzed image can be displayed by using ImageJ software `(defalt = FALSE)`. When you choose `run.ij (check.image = TRUE)`, press any keys to close ImageJ. Note that when `check.image = TRUE`, the analysis would take considerable time. This option may only work on R console.

## 5 Manual leaf area analysis
You can skip this step if ImageJ succeeds in analyzing the leaf images. If ImageJ fails to recognize leaf images, you can manually guide the image analysis for particular images through ImageJ GUI (See the ImageJ user guide 30.1 Measure...[m], http://imagej.nih.gov/ij/docs/guide/user-guide.pdf). The results for these manually-analyzed images will still be handled by the file management function resmerge.ij in run.ij. Multiple tab-delimited text files with a leaf area value (one text file for each original JPEG image file) generated by ImageJ can be merged into a single data frame. The names of text files should be the same as the image files (e.g., A123-1.txt, A123-2.txt, A123-3.txt). For example, when the text files are on the desktop of a Mac, files can be merged using `resmerge.ij(“~/Desktop”)`:

```` r
resmerge.ij(“~/Desktop”)
#>   sample  total.leaf.area
#> 1   A123         418.473
````
The output and the option “prefix” are same as `run.ij`. See `?resmerge.ij` in R for a more detailed description.
