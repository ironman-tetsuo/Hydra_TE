#!/bin/bash
#SBATCH --job-name=bwa_mem
#SBATCH --cpus-per-task=48
#SBATCH --mem=400GB
#SBATCH --time=25-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err

module load bwa
module load samtools

SampleNames=(`awk '{print $1}' metafiles/SRP364758_v1.txt | xargs`)

fastq_path="my_fastq_path"
thread=48
GenomeFile="GENOME.fa"

for i in `seq 0 $((${#SampleNames[@]}-1))`; do
bwa mem ${GenomeFile} \
${fastq_path}/${SampleNames[${i}]}_1.fastq.gz \
${fastq_path}/${SampleNames[${i}]}_2.fastq.gz \
-t ${thread} \
| samtools view -@ ${thread} -h -bS | samtools sort -@ ${thread} > ${SampleNames[${i}]}.sort.bam
samtools index ${SampleNames[${i}]}.sort.bam
done
