#!/bin/bash
#SBATCH --job-name=genotyping
#SBATCH --cpus-per-task=10
#SBATCH --mem=36G
#SBATCH --time=24:00:00
#SBATCH -o ./out/008.genotyping.out
#SBATCH -e ./err/008.genotyping.err

## path
TOOLpath=/mnt/tank/scratch/klytkin/tools
REFERENCEpath=/mnt/tank/scratch/klytkin/bereza/000.ref
ROOTpath=/mnt/tank/scratch/klytkin/bereza/003.all.lib
RELATEpath=${ROOTpath}/relate
INPUTpath=${ROOTpath}/007.combined.data
OUTPUTpath=${ROOTpath}/008.genotyped.data

## data
GATK=${TOOLpath}/gatk-4.4.0.0/gatk
REFERENCE=${REFERENCEpath}/Betula_pendula_subsp._pendula.fasta
INPUT=${INPUTpath}/birch.samples.vcf
OUTPUT=${OUTPUTpath}/birch.samples.genotype.vcf

## GATK
## GenotypeGVCFs
$GATK --java-options "-Xmx36G" GenotypeGVCFs \
	-R $REFERENCE \
	-V $INPUT \
	-O $OUTPUT \
	--max-alternate-alleles 2
