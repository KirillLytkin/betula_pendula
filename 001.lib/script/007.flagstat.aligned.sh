#!/bin/bash
#SBATCH --job-name=flagstat
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH --array=1-96
#SBATCH -o ./out/007.flagstat.aligned.out/array.slurm.%A.%a.out
#SBATCH -e ./err/007.flagstat.aligned.err/array.slurm.%A.%a.err

## array
id=$SLURM_ARRAY_TASK_ID

## path
LIBSpath=/mnt/tank/scratch/klytkin/bereza/001.lib
RELApath=${LIBSpath}/relate
DATApath=${LIBSpath}/005.aligned.sample
FLAGpath=${LIBSpath}/007.flagstat.aligned

## data
FQ=${RELApath}/files.txt
FS=$(sed "${id}q;d" $FQ)
FQbase=$(basename -s .fq.gz $FS)
DATA=${DATApath}/${FQbase}.trimmed.fq.gz
FLAG=${FLAGpath}/${FQbase}.flagstat.txt

## flagstat
samtools flagstat $DATA > $FLAG