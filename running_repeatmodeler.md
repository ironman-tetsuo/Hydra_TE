# Running RepeatModeler
In order to generate a custom repeat library from a genome assembly, we performed [RepeatModeler v2.0.5](https://www.repeatmasker.org/RepeatModeler/) on it as follows:
```
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
```
After RepeatModeler run, you got GENOME-families.fa file.  
This file contains sequences of the resulting custom repeat library.
To search for homologous sequences in the Dfam 3.8 database, firstly you need to download the hmm file of the database as follows:
```
wget https://www.dfam.org/releases/Dfam_3.8/families/Dfam.hmm.gz
```
Subseqeuntly, homologous sequence of each sequence of the custom repeat library in Dfam 3.8 using [nhmmscan v3.4](https://www.mankier.com/1/nhmmscan).
```
#Variables
thread=4

nhmmscan \
--tblout tblout \
--cpu ${thread} \
Dfam.hmm \
GENOME-families.fa
```
