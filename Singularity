#######################################################################################
## DO NOT EDIT THIS FILE! This file was automatically generated from the dockerfile. ##
## Run babelwhale::convert_dockerfile_to_singularityrecipe() to update this file.    ##
#######################################################################################

Bootstrap: shub

From: dynverse/dynwrap:r

%labels
    version 0.1.4

%files
    . /code

%post
    chmod -R 755 '/code'
    wget http://www.cell.com/cms/attachment/2038326541/2052521637/mmc9.zip && unzip mmc9.zip
    apt-get install -y libcgal-dev libglu1-mesa-dev libglu1-mesa-dev
    R -e 'devtools::install_cran(c("matrixStats", "rgl", "pheatmap", "limma", "MASS", "ape", "RColorBrewer"))'
    R -e 'devtools::install_github("rcannood/RHmm")'

%runscript
    exec Rscript /code/run.R

