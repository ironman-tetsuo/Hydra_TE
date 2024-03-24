```
#Copy a repeat library
Library_name="GENOME-families.reheader.fa"
mkdir Libraries
cp ${Library_path}/${Library_name} Libraries/

#Declere assembly name
fasta_prefix="GENOME"
fasta_suffix="fna"

#Copy the assembly
cp ${CurrentDir}/${fasta_prefix}.${fasta_suffix} .

#Run RepeatMasker 
RepeatMasker -parallel 32 -gff -a -lib "Libraries/${Library_name}" -dir "${fasta_prefix}" -xsmall ${fasta_prefix}.${fasta_suffix}
/path/to/repeatmasker/4.1.6-3.12.1-5.38.2/util/rmOutToGFF3.pl  ${fasta_prefix}/${fasta_prefix}.${fasta_suffix}.out >  ${fasta_prefix}/${fasta_prefix}.${fasta_suffix}.out.gff3

#change directory
cd ${fasta_prefix}
mkdir stats
cd stats
cp ../* .

#statistics
SIZE=(`bioawk -c fastx 'BEGIN{SUM=0}{SUM+=length($seq)}END{print SUM}' ${fasta_prefix}.${fasta_suffix}.masked | xargs`)
/path/to/repeatmasker/4.1.6-3.12.1-5.38.2/util/calcDivergenceFromAlign.pl -a ${fasta_prefix}.${fasta_suffix}.* -s ${fasta_prefix}.${fasta_suffix}.divsum
/path/to/repeatmasker/4.1.6-3.12.1-5.38.2/util/createRepeatLandscape.pl -div ${fasta_prefix}.${fasta_suffix}.divsum -g ${SIZE} > ${fasta_prefix}.${fasta_suffix}.divsum.html
/path/to/repeatmasker/4.1.6-3.12.1-5.38.2/util/buildSummary.pl -useAbsoluteGenomeSize  -libdir ../../Libraries ${fasta_prefix}.${fasta_suffix}.out > ${fasta_prefix}.${fasta_suffix}.out.summary
```
