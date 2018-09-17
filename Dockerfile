FROM dynverse/dynwrap:r

LABEL version 0.1.2

RUN wget http://www.cell.com/cms/attachment/2038326541/2052521637/mmc9.zip && unzip mmc9.zip

RUN apt-get install -y libcgal-dev libglu1-mesa-dev libglu1-mesa-dev

RUN R -e 'devtools::install_cran(c("matrixStats", "rgl", "pheatmap", "limma", "MASS", "ape", "RColorBrewer"))'

RUN R -e 'devtools::install_github("rcannood/RHmm")'

ADD . /code

ENTRYPOINT Rscript /code/run.R
