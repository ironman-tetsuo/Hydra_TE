Installation of [NanoPlot v1.40.2](https://github.com/wdecoster/NanoPlot)
#Install nanoplot
```
conda install -c bioconda nanoplot
```
To run nanoplot, run the following script.
```
#Declare variables
thread=1
fastq_path=(path1 path2...)
FileNames=(file1 file2...)
SampleNames=(name1 name2)

#<<COMMENT
for i in `seq 0 $((${#SampleNames[@]}-1))`; do
NanoPlot \
--fastq ${fastq_path[${i}]}/${FileNames[${i}]}  \
--loglength  \
-t ${thread}  \
-o ${SampleNames[${i}]}
done
```
