#!/bin/bash
#Generate an index for the genome assembly
hisat2-build genome.fa genome

#Declare variable
SampleNames=(sample1 sample2...)

#Path to genome 
Genome_path="/path/to/genome"

#Number of thread
thread=5
#Parent path to fastq
fastq_path=/parent/path/to/fastq

#Mapping
for i in `seq 0 $((${#SampleNames[@]}-1))`; do
hisat2 -p ${thread} -q  -x ${Genome_path}  -U ${fastq_path}/${SampleNames[${i}]}.fastq.gz -S ${SampleNames[${i}]}.sam 2> ${SampleNames[${i}]}.stderr.txt
done
COMMENTOUT
for i in `seq 0 $((${#SampleNames[@]}-1))`; do
hisat2 \
-p ${thread} \
-q  -x ${Genome_path}  \
-1 ${fastq_path}/${SampleNames[${i}]}_1.paired.fastq.gz \
-2 ${fastq_path}/${SampleNames[${i}]}_2.paired.fastq.gz \
-S ${SampleNames[${i}]}.sam 2> ${SampleNames[${i}]}.stderr.txt
done

#Convert sam into bam files, sort them, and generate index
for i in `seq 0 $((${#SampleNames[@]}-1))`; do
samtools view -@ ${thread} -Sb ${SampleNames[${i}]}.sam | \
samtools sort -@ ${thread} -o ${SampleNames[${i}]}.sort.bam
samtools index ${SampleNames[${i}]}.sort.bam
rm ${SampleNames[${i}]}.sam
done

