#!/bin/bash

#FeatureCount from mapped reads
thread=48
bam_path="/path/to/bam"
#sapple names
SampleNames=(sample1 sample2...)
#Add suffix of ".sort.bam"
SampleNames=( "${SampleNames[@]/%/Aligned.sortedByCoord.out.bam}" )
#Add prefix of file paths
SampleNames=( "${SampleNames[@]/#/${bam_path}/}" )

annotation="repeat.gff3"
featureCounts \
-f \
-O \
-M \
--fraction \
-p \
-s 0 \
--donotsort \
-T ${thread} \
-t dispersed_repeat -g ID \
-a ${annotation} \
-o count_matrix.${annotation}.txt \
${SampleNames[@]}
