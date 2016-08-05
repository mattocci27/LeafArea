ori
"/Applications/ImageJ.app"
"/Applications/ImageJ/ImageJ.app"
"/Applications/ImageJ/ImageJ.app"
"/Applications/ImageJ.app"


dest:
path.imagej, "ImageJ.app/Contents/Resources/Java/ij.jar"



paths <- c("/Applications/ImageJ.app", "/Applications/ImageJ/ImageJ.app")

i <- 2
system(paste('which ', paths[i], ' 2>&1', sep = ""), intern = TRUE)


imagej <- system("mdfind ImageJ.app", intern = TRUE)[1]


ImageJ2 = FALSE

Windows
"ImageJ/jre/bin/java.exe"


Mac
new ImageJ
"/Applications/ImageJ.app/update/jars/ij-1.51d.jar"

old ImageJ
"/Applications/ImageJ.app/Contents/Resources/Java/ij.jar -ijpath"


Linux?
