#!/bin/bash
#SBATCH --job-name=aligning
#SBATCH --cpus-per-task=1
#SBATCH --mem=36G
#SBATCH --time=24:00:00
#SBATCH --array=1-96
#SBATCH -o ./out/004.aligning.out/%a.array.out
#SBATCH -e ./err/004.aligning.err/%a.array.err

## array
ID=$SLURM_ARRAY_TASK_ID

## path
REFERENCEpath=/mnt/tank/scratch/klytkin/bereza/000.ref
ROOTpath=/mnt/tank/scratch/klytkin/bereza/001.lib
RELATEpath=${ROOTpath}/relate
INPUTpath=${ROOTpath}/003.merged.data
OUTPUTpath=${ROOTpath}/004.aligned.data

## data
REFERENCE=${REFERENCEpath}/Betula_pendula_subsp._pendula.faa
FILE=$(awk '{print $2}' $RELATEpath/barcodes.txt | sed "${ID}q;d")
INPUT1=${INPUTpath}/$FILE\.1.p.fq.gz
INPUT2=${INPUTpath}/$FILE\.2.p.fq.gz
OUTPUT=${OUTPUTpath}/$FILE\.bam

## bowtie2
bowtie2 --very-sensitive \
	-x $REFERENCE \
	-1 $INPUT1 \
	-2 $INPUT2 \
	| samtools view \
	-b -h -o $OUTPUT
