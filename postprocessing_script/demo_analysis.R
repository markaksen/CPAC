#!/usr/bin/env Rscript
source("apply_parcellation.R")
source("estimate_graph.R")
source("graph_difference.R")
source("median_graph.R")

###### STEP 0: read in data ########
args <- commandArgs(trailingOnly=TRUE)
list.files(args[1]);
#case_subj <- c("025-0040046", "025-0040002", "025-0040017")
#control_subj <- c("025-0040061", "025-0040090", "025-0040113")

read_subj <- function(vec){
  list <- lapply(vec, function(x){
    dat <- oro.nifti::readNIfTI(paste0("/tigress/HANLIU/mridata/CPAC_finished/INDI/Retrospective/COBRE/",
      x, "/func.nii.gz"), reorient = F)
    dat@.Data
  })
  names(list) <- vec

  list
}

case_dat <- read_subj(case_subj)
control_dat <- read_subj(control_subj)

###### STEP 1: apply the parcellation #######

data(AAL_3mm)

convert_data <- function(mat_list){
  lapply(mat_list, function(x){
    cat("\n")
    apply_parcellation(x, AAL_3mm)
  })
}

case_dat <- convert_data(case_dat)
control_dat <- convert_data(control_dat)

###### STEP 2: estimate the graph #########

case_graph_list <- lapply(case_dat, estimate_graph)
control_graph_list <- lapply(control_dat, estimate_graph)

###### STEP 3: compute median graph ##########

case_median <- median_graph(case_graph_list)
control_median <- median_graph(control_graph_list)

###### STEP 4: compute the difference #########

graph_difference(control_median, case_median)