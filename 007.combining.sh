#!/bin/bash
#SBATCH --job-name=combining
#SBATCH --cpus-per-task=10
#SBATCH --mem=36G
#SBATCH --time=24:00:00
#SBATCH -o ./out/007.combining.out
#SBATCH -e ./err/007.combining.err

## path
TOOLpath=/mnt/tank/scratch/klytkin/tools
REFERENCEpath=/mnt/tank/scratch/klytkin/bereza/000.ref
ROOTpath=/mnt/tank/scratch/klytkin/bereza/003.com
RELATEpath=${ROOTpath}/relate
INPUTpath=${ROOTpath}/006.called.data
OUTPUTpath=${ROOTpath}/007.combined.data

## data
GATK=${TOOLpath}/gatk-4.4.0.0/gatk
REFERENCE=${REFERENCEpath}/Betula_pendula_subsp._pendula.fasta
INPUT=${INPUTpath}/gvcfs.list
OUTPUT=${OUTPUTpath}/birch.samples.vcf

## GATK
## CombineGVCFs
$GATK --java-options "-Xmx36G" CombineGVCFs \
	-V $INPUT \
	-O $OUTPUT \
	-R $REFERENCE
