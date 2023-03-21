#!/bin/bash
#SBATCH --job-name=fastqc
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH --array=1-96
#SBATCH -o ./out/006.fastqc.aligned.out/array.slurm.%A.%a.out
#SBATCH -e ./err/006.fastqc.aligned.err/array.slurm.%A.%a.err

## array
id=$SLURM_ARRAY_TASK_ID

## path
LIBSpath=/mnt/tank/scratch/klytkin/bereza/001.lib
RELApath=${LIBSpath}/relate
DATApath=${LIBSpath}/005.aligned.sample
FASTpath=${LIBSpath}/006.fastqc.aligned

## data
FQ=${RELApath}/files.txt
FS=$(sed "${id}q;d" $FQ)
FQbase=$(basename -s .fq.gz $FS)
DATA=${DATApath}/${FQbase}.trimmed.bam

## fastqc
fastqc $DATA -o $FASTpath