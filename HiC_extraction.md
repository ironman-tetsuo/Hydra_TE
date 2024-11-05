#Extraction Hi-C contact siganal for quantitative analyses

```
import numpy as np
import hicstraw
import os

# Import the file which defines chroosome length
region_file = '../chromosome_length.txt_v3'
regions = []

with open(region_file, 'r') as f:
    for line in f:
        line = line.strip()
        if line:
            regions.append(line.split(':'))

# Path to HiC file
hic_file = '../HydraT2T_v1.0.fasta.masked_30.hic'

# Out put directory
output_dir = 'output_regions'
os.makedirs(output_dir, exist_ok=True)

# For each region, ouput data
for idx, region in enumerate(regions):
    chrom, start, end = region
    start, end = int(start), int(end)
    result = hicstraw.straw("observed", 'NONE', hic_file, f'{chrom}:{start}:{end}', f'{chrom}:{start}:{end}', 'BP', 100000)    
    output_file = os.path.join(output_dir, f'region_{idx + 1}.txt')
    with open(output_file, 'w') as f_out:
        for entry in result:
            f_out.write("{0}\t{1}\t{2}\n".format(entry.binX, entry.binY, entry.counts))

```
