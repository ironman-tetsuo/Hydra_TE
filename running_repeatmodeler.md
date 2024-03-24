# Running RepeatModeler
In order to generate a custom repeat library from a genome assembly, we performed [RepeatModeler v2.0.5](https://www.repeatmasker.org/RepeatModeler/) on it as follows:
```
INPUT=GENOME.fa
trf_path=path_to_trf_bin_dir
RepeatModeler \
-database ${INPUT}  \
-threads 8 \
-LTRStruct  \
-srand 123  \
-trf_dir ${trf_path}`
```
