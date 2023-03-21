#!/bin/bash
#SBATCH --job-name=uncontaminating
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --time=12:00:00
#SBATCH --array=1-96
#SBATCH -o ./out/003.uncontaminating.out/array.slurm.%A.%a.out
#SBATCH -e ./err/003.uncontaminating.err/array.slurm.%A.%a.err

## array
id=$SLURM_ARRAY_TASK_ID

## path
LIBSpath=/mnt/tank/scratch/klytkin/bereza/001.lib
RELApath=${LIBSpath}/relate
DATApath=${LIBSpath}/003.trimmed.sample

## data
REF=${RELApath}/GCF_000001405.40_GRCh38.p14_genomic.fna.gz
FQ=${RELApath}/files.txt
FS=$(sed "${id}q;d" $FQ)
FQbase=$(basename -s .fq.gz $FS)
DATA=${DATApath}/${FQbase}.trimmed.fq.gz
CLEA=${DATApath}/${FQbase}.clean.fq.gz
BADS=${DATApath}/${FQbase}.bad.fq.gz

## bbduk
bbduk in=$DATA outm=$BAD outu=$CLEA ref=$REF k=31
