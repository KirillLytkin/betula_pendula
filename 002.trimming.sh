#!/bin/bash
#SBATCH --job-name=trimming
#SBATCH --cpus-per-task=1
#SBATCH --mem=36G
#SBATCH --time=24:00:00
#SBATCH --array=1-96
#SBATCH -o ./out/002.trimming.out/%a.array.out
#SBATCH -e ./err/002.trimming.err/%a.array.err

## array
ID=$SLURM_ARRAY_TASK_ID

## path
ROOTpath=/mnt/tank/scratch/klytkin/bereza/001.lib
RELATEpath=${ROOTpath}/relate
INPUTpath=${ROOTpath}/001.demultiplexed.data
OUTPUTpath=${ROOTpath}/002.trimmed.data
LANE1path=${INPUTpath}/S_1_EKDL230000003-1A_HKN3NDSX5_L2
LANE2path=${INPUTpath}/S_1_EKDL230000003-1A_HKN3NDSX5_L4

## data
ADAPTER=${RELATEpath}/adapters.fa
FILE=$(awk '{print $2}' $RELATEpath/barcodes.txt | sed "${ID}q;d")

## data LANE1
INPUT1LANE1=${LANE1path}/$FILE\.1.fq.gz
INPUT2LANE1=${LANE1path}/$FILE\.2.fq.gz
OUTPUT1pLANE1=${LANE1path}/$FILE\.1.p.fq.gz
OUTPUT2pLANE1=${LANE1path}/$FILE\.2.p.fq.gz
OUTPUT1uLANE1=${LANE1path}/$FILE\.1.u.fq.gz
OUTPUT2uLANE1=${LANE1path}/$FILE\.2.u.fq.gz

## trimmomatic LANE1
trimmomatic PE \
	$INPUT1LANE1 \
	$INPUT2LANE1 \
	$OUTPUT1pLANE1 \
	$OUTPUT1uLANE1 \
	$OUTPUT2pLANE1 \
	$OUTPUT2uLANE1 \
	ILLUMINACLIP:$ADAPTER:2:30:10 \
	HEADCROP:15 SLIDINGWINDOW:4:18 MINLEN:45

## data LANE2
INPUT1LANE2=${LANE2path}/$FILE\.1.fq.gz
INPUT2LANE2=${LANE2path}/$FILE\.2.fq.gz
OUTPUT1pLANE2=${LANE2path}/$FILE\.1.p.fq.gz
OUTPUT2pLANE2=${LANE2path}/$FILE\.2.p.fq.gz
OUTPUT1uLANE2=${LANE2path}/$FILE\.1.u.fq.gz
OUTPUT2uLANE2=${LANE2path}/$FILE\.2.u.fq.gz

## trimmomatic LANE2
trimmomatic PE \
	$INPUT1LANE2 \
	$INPUT2LANE2 \
	$OUTPUT1pLANE2 \
	$OUTPUT1uLANE2 \
	$OUTPUT2pLANE2 \
	$OUTPUT2uLANE2 \
	ILLUMINACLIP:$ADAPTER:2:30:10 \
	HEADCROP:15 SLIDINGWINDOW:4:18 MINLEN:45
