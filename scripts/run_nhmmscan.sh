#!/bin/bash

#Variables
thread=4

nhmmscan \
--tblout tblout \
--cpu ${thread} \
Dfam.hmm \
GENOME-families.fa \
> /dev/null
