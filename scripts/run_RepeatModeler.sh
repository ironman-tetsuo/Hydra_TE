#!/bin/bash

#Variables
INPUT="GENOME"
Extension="fna"
trf_path="path_to_trf_bin_dir"

#Build database for RepeatModeler
BuildDatabase -name ${INPUT} ${INPUT}.${Extension}

#Perform RepeatModeler
RepeatModeler \
-database ${INPUT}  \
-threads 8 \
-LTRStruct  \
-srand 123  \
-trf_dir ${trf_path}
