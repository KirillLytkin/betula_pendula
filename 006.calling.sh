#!/bin/bash
#SBATCH --job-name=calling
#SBATCH --cpus-per-task=1
#SBATCH --mem=36G
#SBATCH --time=24:00:00
#SBATCH --array=1-96
#SBATCH -o ./out/006.calling.out/%a.array.out
#SBATCH -e ./err/006.calling.err/%a.array.err

## array
ID=$SLURM_ARRAY_TASK_ID

## path
TOOLpath=/mnt/tank/scratch/klytkin/tools
REFERENCEpath=/mnt/tank/scratch/klytkin/bereza/000.ref
ROOTpath=/mnt/tank/scratch/klytkin/bereza/001.lib
RELATEpath=${ROOTpath}/relate
INPUTpath=${ROOTpath}/005.sorted.data
OUTPUTpath=${ROOTpath}/006.called.data

## data
GATK=${TOOLpath}/gatk-4.4.0.0/gatk
REFERENCE=${REFERENCEpath}/Betula_pendula_subsp._pendula.fasta
FILE=$(awk '{print $2}' $RELATEpath/barcodes.txt | sed "${ID}q;d")
INPUT=${INPUTpath}/$FILE\.rn.sorted.bam
OUTPUT=${OUTPUTpath}/$FILE\.g.vcf

## GATK
## HaplotypeCaller
$GATK --java-options "-Xmx36G" HaplotypeCaller \
	--emit-ref-confidence GVCF \
	-R $REFERENCE \
	-I $INPUT \
	-O $OUTPUT
