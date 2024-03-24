#Change directory to the ${TMPDIR}
CurrentDir=`pwd`
cd ${TMPDIR}
pwd
#Debug
echo "Hello, world" > hello.txt
cp ${TMPDIR}/hello.txt ${CurrentDir}/
pwd

#Copy a repeat library
Library_path=${CurrentDir}
Library_name="GCA_947044365.1_odPetFici3.1_genomic-families.reheader.fa"
mkdir Libraries
cp ${Library_path}/${Library_name} Libraries/

#Declere assembly name
fasta_prefix="GCA_947044365.1_odPetFici3.1_genomic"
fasta_suffix="fna"

#Copy the assembly
cp ${CurrentDir}/${fasta_prefix}.${fasta_suffix} .

#Module load
module unload perl 
module load repeatmasker

#Operations
RepeatMasker -parallel 32 -gff -a -lib "Libraries/${Library_name}" -dir "${fasta_prefix}" -xsmall ${fasta_prefix}.${fasta_suffix}
/home/apps/repeatmasker/4.1.6-3.12.1-5.38.2/util/rmOutToGFF3.pl  ${fasta_prefix}/${fasta_prefix}.${fasta_suffix}.out >  ${fasta_prefix}/${fasta_prefix}.${fasta_suffix}.out.gff3

#List files
ls -lh

#change directory
cd ${fasta_prefix}
mkdir stats
cd stats
cp ../* .

#statistics
SIZE=(`bioawk -c fastx 'BEGIN{SUM=0}{SUM+=length($seq)}END{print SUM}' ${fasta_prefix}.${fasta_suffix}.masked | xargs`)
/home/apps/repeatmasker/4.1.6-3.12.1-5.38.2/util/calcDivergenceFromAlign.pl -a ${fasta_prefix}.${fasta_suffix}.* -s ${fasta_prefix}.${fasta_suffix}.divsum
/home/apps/repeatmasker/4.1.6-3.12.1-5.38.2/util/createRepeatLandscape.pl -div ${fasta_prefix}.${fasta_suffix}.divsum -g ${SIZE} > ${fasta_prefix}.${fasta_suffix}.divsum.html
/home/apps/repeatmasker/4.1.6-3.12.1-5.38.2/util/buildSummary.pl -useAbsoluteGenomeSize  -libdir ../../Libraries ${fasta_prefix}.${fasta_suffix}.out > ${fasta_prefix}.${fasta_suffix}.out.summary
