#!/usr/local/bin/Rscript

task <- dyncli::main()

library(dplyr, warn.conflicts = FALSE)
library(purrr, warn.conflicts = FALSE)

source("/SupplementaryMethods/Waterfall.R")

#   ____________________________________________________________________________
#   Load data                                                               ####

expression <- as.matrix(task$expression)
parameters <- task$parameters

#   ____________________________________________________________________________
#   Infer trajectory                                                        ####

# TIMING: done with preproc
checkpoints <- list(method_afterpreproc = as.numeric(Sys.time()))

# run waterfall
ps <- pseudotimeprog.foo(t(expression), k = parameters$num_clusters, color = rep("black", nrow(expression)))

dimred <- as.matrix(ps[,colnames(ps) != "pseudotime", drop = FALSE])

# TIMING: done with method
checkpoints$method_aftermethod <- as.numeric(Sys.time())

#   ____________________________________________________________________________
#   Save output                                                             ####

dynwrap::wrap_data(cell_ids = rownames(ps)) %>%
  dynwrap::add_linear_trajectory(pseudotime = set_names(ps$pseudotime, rownames(expression))) %>%
  dynwrap::add_dimred(dimred = dimred) %>%
  dynwrap::add_timings(timings = checkpoints) %>%
  dyncli::write_output(task$output)
