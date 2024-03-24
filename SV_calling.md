# SV calling
Fistly, SV calling by individual is performed as follows:
```
#Variables
bam_path=(path1 path2...)
SampleNames=(sample1 sample2...)

#Perform SV calling for each sample
for i in `seq 0 $((${#SampleNames[@]}-1))`; do
sniffles \
--input ${bam_path}/${SampleNames[${i}]}.q60.sort.bam \
--snf ${SampleNames[${i}]}.q60.sort.bam.snf \
--reference ${reference_path} \
--threads ${thread} \
--output-rnames \
--minsupport 2
done
```
