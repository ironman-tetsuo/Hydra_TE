# Running RepeatModeler
In order to generate a custom repeat library from a genome assembly, we performed [RepeatModeler v2.0.5](https://www.repeatmasker.org/RepeatModeler/) on it as follows:
`RepeatModeler \`
-database ${INPUT}  \`
-threads 8 \`
-LTRStruct  \`
-srand 123  \`
-trf_dir /apps/tandemrepeatsfinder/4.09.1/bin/`
