# Quantification of Iso-seq data
To identify TE transcripts in the Iso-seq reads, blastn search can be used.
```
#Database generation from a repeat library
blastdb="Repeat_library.fasta"
makeblastdb \
-in Repeat_library.fasta \
-dbtype nucl \
-out ${blastdb}

#Variance
thread=10
query="Iso-seq.fasta"

#blastn search against the database
blastn \
-db ${blastdb} \
-query ${query} \
-out Iso-seq_Repeat.txt \
-outfmt "6 qseqid qlen sseqid slen pident length mismatch gapopen qstart qend sstart send evalue bitscore" \
-max_target_seqs 1  \
-num_threads ${thread}
```
