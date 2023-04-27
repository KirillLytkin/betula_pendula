#!/bin/bash
#SBATCH --job-name=demultiplexing
#SBATCH --cpus-per-task=1
#SBATCH --mem=36G
#SBATCH --time=24:00:00
#SBATCH --array=1-2
#SBATCH -o ./out/001.demultiplexing.out/%a.array.out
#SBATCH -e ./err/001.demultiplexing.err/%a.array.err

## array
ID=$SLURM_ARRAY_TASK_ID

## path
ROOTpath=/mnt/tank/scratch/klytkin/bereza/001.lib
RELATEpath=${ROOTpath}/relate
INPUTpath=${ROOTpath}/000.raw.data
OUTPUTpath=${ROOTpath}/001.demultiplexed.data

## data
BARCODE=${RELATEpath}/barcodes.txt
LANE=$(sed "${ID}q;d" ${RELATEpath}/raw.files.txt)
BASENAME=$(basename -s .fastq.gz $LANE)
INPUT1=${INPUTpath}/${BASENAME}_1.fastq.gz
INPUT2=${INPUTpath}/${BASENAME}_2.fastq.gz
OUTPUT=${OUTPUTpath}/${BASENAME}

## process radtags
process_radtags \
	-1 $INPUT1 -2 $INPUT2 \
	-o $OUTPUT -b $BARCODE \
	-i 'gzfastq' \
	--renz_1 hindIII \
	--renz_2 nlaIII \
	-r -c -q
