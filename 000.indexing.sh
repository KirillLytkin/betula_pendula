#!/bin/bash
#SBATCH --job-name=idexing
#SBATCH --cpus-per-task=10
#SBATCH --mem=36G
#SBATCH --time=04:00:00
#SBATCH -o ./out/000.indexing.out
#SBATCH -e ./err/000.indexing.err

## path
TOOLpath=/mnt/tank/scratch/klytkin/tools
REFERENCEpath=/mnt/tank/scratch/klytkin/bereza/000.ref

## data
GATK=${TOOLpath}/gatk-4.4.0.0/gatk
PICARD=${TOOLpath}/picard/build/libs/picard.jar
REFERENCE=${REFERENCEpath}/Betula_pendula_subsp._pendula.fasta

## indexing
bowtie2-build $REFERENCE $REFERENCE
samtools faidx $REFERENCE
java -jar $PICARD CreateSequenceDictionary -R $REFERENCE -O "${REFERENCE%%.*}".dict