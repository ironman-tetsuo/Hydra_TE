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
   
Affter the SV calling by individual, SV data are merged with the following script:
```
#Generate array describing file names for variant calling
SnfFileNames=("${SampleNames[@]}")
#Add suffix
SnfFileNames=( "${SnfFileNames[@]/%/.q60.sort.bam.snf}" )
#Add prefix of file paths
SnfFileNames=( "${SnfFileNames[@]/#/${snf_path}/${MyOutDir[${i}]}/}" )

#merge Snf files 
sniffles \
--threads ${thread} \
--combine-low-confidence 0.01 --combine-low-confidence-abs 1 --combine-null-min-coverage 3 \
--input ${SnfFileNames[@]} \
--vcf multisample.vcf

#Compress vcf file
gzip -c multisample.vcf > multisample.vcf.gz
```
