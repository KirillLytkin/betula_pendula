#!/bin/bash
#SBATCH --job-name=recomoressing
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --time=36:00:00
#SBATCH --array=1-4
#SBATCH -o ./out/000.recompressing.out/array.job.slurm.%A.%a.out
#SBATCH -e ./err/000.recompressing.err/array.job.slurm.%A.%a.err

## array
id=$SLURM_ARRAY_TASK_ID

## path
LIBSpath=/mnt/tank/scratch/klytkin/bereza/001.lib
RELApath=${LIBSpath}/relate
DATApath=${LIBSpath}/000.raw.data

## data
FQ=${RELApath}/raw.files.txt
FS=$(sed "${id}q;d" $FQ)
FQbase=$(basename -s .fastq.bz2 $FS)
DATA=${DATApath}/${FQbase}.fastq.bz2
GZIP=${DATApath}/${FQbase}.fastq.gz

## bzcat | gzip
bzcat $DATA | gzip - c > $GZIP
