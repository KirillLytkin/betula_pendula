#!/bin/bash
#SBATCH --job-name=aligning
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --time=96:00:00
#SBATCH --array=1-96
#SBATCH -o ./out/005.aligning.out/array.slurm.%A.%a.out
#SBATCH -e ./err/005.aligning.err/array.slurm.%A.%a.err

## array
id=$SLURM_ARRAY_TASK_ID

## path
LIBSpath=/mnt/tank/scratch/klytkin/bereza/001.lib
REFEpath=/mnt/tank/scratch/klytkin/bereza/000.ref
RELApath=${LIBSpath}/relate
DATApath=${LIBSpath}/003.trimmed.sample
ALIGpath=${LIBSpath}/005.aligned.sample

## data
REF=${REFEpath}/Betula_pendula_subsp._pendula.faa
FQ=${RELApath}/files.txt
FS=$(sed "${id}q;d" $FQ)
FQbase=$(basename -s .fq.gz $FS)
DATA=${DATApath}/${FQbase}.trimmed.fq.gz
BAM=${ALIGpath}/${FQbase}.trimmed.bam

## bowtie2
bowtie2 --very-sensitive-local \
        -x $REF $DATA | samtools view \
        -b -h -o $BAM