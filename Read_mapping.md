# Read mapping
To perform the nanopore reads to the genome assembly, [minimap2 v2.26-r1175](https://github.com/lh3/minimap2) is used.
```
thread=48
reference_path="/scratch/molevo/kon/Projects/Project_hydra_genome_analysis/220708_public_AEP_RepeatModeler_RepeatMasker/RepeatModeler/HVAEP.genome.fa"

fastq_path=(`tail -n +2 metafiles/Hydra_SV_Sequencing_Samples_Table_v4.txt | awk '{print $4}' | xargs`)
FileNames=(`tail -n +2 metafiles/Hydra_SV_Sequencing_Samples_Table_v4.txt | awk '{print $5}' | xargs`)
SampleNames=(`tail -n +2 metafiles/Hydra_SV_Sequencing_Samples_Table_v4.txt | awk '{print $2}' | xargs`)

for i in `seq 0 $((${#SampleNames[@]}-1))`; do
minimap2 \
-ax  map-ont \
--secondary=no \
${reference_path} \
${fastq_path[${i}]}/${FileNames[${i}]} \
-t ${thread} \
| \
samtools view -h -bS  | samtools sort -@ ${thread} > ${SampleNames[${i}]}.sort.bam
samtools index ${SampleNames[${i}]}.sort.bam
samtools flagstat -@ ${thread} ${SampleNames[${i}]}.sort.bam > ${SampleNames[${i}]}.sort.bam.flagstat
samtools depth -a ${SampleNames[${i}]}.sort.bam > ${SampleNames[${i}]}.sort.bam.depth
samtools stats -@ ${thread} ${SampleNames[${i}]}.sort.bam > ${SampleNames[${i}]}.sort.bam.stats
samtools view -h -bS -q 60 ${SampleNames[${i}]}.sort.bam > ${SampleNames[${i}]}.q60.sort.bam
samtools index ${SampleNames[${i}]}.q60.sort.bam
samtools flagstat -@ ${thread} ${SampleNames[${i}]}.q60.sort.bam > ${SampleNames[${i}]}.q60.sort.bam.flagstat
samtools depth -a ${SampleNames[${i}]}.q60.sort.bam > ${SampleNames[${i}]}.q60.sort.bam.depth
done
```
