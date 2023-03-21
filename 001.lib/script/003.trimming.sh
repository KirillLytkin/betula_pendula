#!/bin/bash
#SBATCH --job-name=trimming
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --time=12:00:00
#SBATCH --array=1-96
#SBATCH -o ./out/003.trimming.out/array.slurm.%A.%a.out
#SBATCH -e ./err/003.trimming.err/array.slurm.%A.%a.err

## array
id=$SLURM_ARRAY_TASK_ID

## path
LIBSpath=/mnt/tank/scratch/klytkin/bereza/001.lib
RELApath=${LIBSpath}/relate
DATApath=${LIBSpath}/001.demultiplexed.sample
TRIMpath=${LIBSpath}/003.trimmed.sample

## data
TS=${RELApath}/TruSeq3-PE.fa
FQ=${RELApath}/files.txt
FS=$(sed "${id}q;d" $FQ)
FQbase=$(basename -s .fq.gz $FS)
DATA=${DATApath}/${FQbase}.fq.gz
TRIM=${TRIMpath}/${FQbase}.trimmed.fq.gz

## trimmomatic
trimmomatic SE \
        $DATA \
        $TRIM \
        ILLUMINACLIP:$TS:2:30:10 \
        SLIDINGWINDOW:4:15

## information
# ILLUMINACLIP: Cut adapter and other illumina-specific sequences from the read
# SLIDINGWINDOW: Perform a sliding window trimming, cutting once the average quality within the window falls below a threshold