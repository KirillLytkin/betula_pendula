#!/bin/bash
#SBATCH --job-name=sorting
#SBATCH --cpus-per-task=1
#SBATCH --mem=36G
#SBATCH --time=24:00:00
#SBATCH --array=1-96
#SBATCH -o ./out/005.sorting.out/%a.array.out
#SBATCH -e ./err/005.sorting.err/%a.array.out

## array
ID=$SLURM_ARRAY_TASK_ID

## path
TOOLpath=/mnt/tank/scratch/klytkin/tools
ROOTpath=/mnt/tank/scratch/klytkin/bereza/001.lib
RELATEpath=${ROOTpath}/relate
INPUTpath=${ROOTpath}/004.aligned.data
OUTPUTpath=${ROOTpath}/005.sorted.data

## data
PICARD=${TOOLpath}/picard/build/libs/picard.jar
UNIT=$(awk '{print $1}' $RELATEpath/barcodes.txt | sed "${ID}q;d")
FILE=$(awk '{print $2}' $RELATEpath/barcodes.txt | sed "${ID}q;d")
INPUT=${INPUTpath}/$FILE\.bam
OUTPUT1=${INPUTpath}/$FILE\.rn.bam
OUTPUT2=${OUTPUTpath}/$FILE\.rn.sorted.bam
OUTPUT3=${OUTPUTpath}/$FILE\.rn.sorted.bai

## picard
## AddOrReplaceReadGroups
java -jar $PICARD AddOrReplaceReadGroups \
	-I $INPUT \
	-O $OUTPUT1 \
	--RGLB lib1 \
	--RGPL illumina \
	--RGPU $UNIT \
	--RGSM $FILE

## SortSam
java -jar $PICARD SortSam \
	-I $OUTPUT1 \
	-O $OUTPUT2 \
	--SORT_ORDER coordinate

## BuildBamIndex
java -jar $PICARD BuildBamIndex \
	-I $OUTPUT2 \
	-O $OUTPUT3

## remove
rm $INPUTpath/$FILE\.rn.bam
