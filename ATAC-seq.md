# Analysis of open chromatin regions from ATAC-seq reads
In order to extract the Hi-C contact signal from .hic format file, conduct the following script:
- [run_MACS3.sh](scripts/run_MACS3.sh)
```
#!/bin/bash
#SBATCH --job-name=macs3
#SBATCH --cpus-per-task=1
#SBATCH --mem=20GB
#SBATCH --time=25-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --output=%x-%j.out
#SBATCH --error=%x-%j.err


SampleNames=(`awk '{print $1}' metafiles/SRP364758_v1.txt | xargs`)

bam_path="bam_path"

for i in `seq 0 $((${#SampleNames[@]}-1))`; do
/scratch/molevo/kon/tool_path/miniconda3/bin/macs3 callpeak \
-f BAMPE \
-t ${bam_path}/${SampleNames[${i}]}.sort.bam \
-g 900935055 \
--shift -150 --extsize 300 \
-n ${SampleNames[${i}]}.sort.bam \
-B \
-q 0.05
done
```
