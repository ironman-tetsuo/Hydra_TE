# Running RepeatModeler
In order to generate a custom repeat library from a genome assembly, we performed [RepeatModeler v2.0.5](https://www.repeatmasker.org/RepeatModeler/) on it as follows:
- [run_nhmmscan.sh](scripts/run_nhmmscan.sh)
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
To search for homologous sequences in the Dfam 3.8 database, firstly you need to download the hmm file of the database and generate an index file as follows:
```
wget https://www.dfam.org/releases/Dfam_3.8/families/Dfam.hmm.gz
gunzip Dfam.hmm.gz
hmmpress Dfam.hmm
```
Subseqeuntly, homologous sequence of each sequence of the custom repeat library in Dfam 3.8 using [nhmmscan v3.4](https://www.mankier.com/1/nhmmscan).
- [run_RepeatModeler.sh](scripts/run_RepeatModeler.sh)
```
#Variables
thread=4

nhmmscan \
--tblout tblout \
--cpu ${thread} \
Dfam.hmm \
GENOME-families.fa \
> /dev/null
```
"tblout" file is the output file of hmmscan containing homologous sequences in the Dfam data base.  
The initial "Unknown" sequences are replaced with these new annotations.  
Note that the nhmmscan step is computationally intensive, so dividing query sequences into several batches are recommended.  
The option of "--cpu" should be around 4 in order to avoid memory overload to your computing server.  
