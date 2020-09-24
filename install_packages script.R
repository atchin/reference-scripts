# packages to install

 update.packages(checkBuilt=TRUE, ask=FALSE)

install.packages(c("abind","askpass","assertthat","backports","base64enc","bayesplot","BH","brew","cairoDevice","callr","checkmate","cli","clipr","coda","colorspace","commonmark","covr","crayon","crosstalk","curl","data.table","desc","devtools","digest","dplyr","DT","ellipsis","evaluate","fansi","farver","fs","generics","GGally","ggmcmc","ggplot2","ggridges","gh","gitr2","githubinstall","glue","gtable","gWidgets","gWidgetsRGtk2","highr","hms","htmltools","htmlwidgets","httr","ini","isoband","jsonlite","knitr","labeling","later","lazyeval","lifecycle","loo","magrittr","markdown","MatrixModels","matrixStats","mcmc","MCMCpack","memoise","mime","MixSIAR","mockery","munsell","openssl","pillar","pkgbuild","pkgconfig","pkgload","plogr","plyr","praise","prettyunits","processx","progress","promises","ps","purrr","quantreg","R2jags","R2WinBUGS","R6","rcmdcheck","RColorBrewer","Rcpp","rematch2","remotes","reshape","reshape2","rex","RGtk2","rjags","rlang","rmarkdown","roxygen2","rprojroot","rstudioapi","rversions","scales","sessioninfo","sp","sparseM","splancs","stringi","stringr","sys","testthat","tibble","tidyr","tidyselect","tinytex","usethis","utf8","vctrs","viridisLite","whisker","withr","xfun","xml2","xopen","yaml","zoo"))

install.packages("rlang")
install.packages("Rtools")

install.packages(c("tidyverse","tidyr","dplyr","ggplot2"))
# devtools::install_github("tidyverse/tidyr", dependencies = T)
# devtools::install_github("tidyverse/dplyr", dependencies = T)
# devtools::install_github("tidyverse/ggplot2", dependencies = T)
devtools::install_github("brianstock/MixSIAR",
dependencies = TRUE,
build_vignettes = TRUE)
devtools::install_github("nschiett/fishualize")
