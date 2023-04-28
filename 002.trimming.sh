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

## data
ADAPTER=${RELATEpath}/adapters.fa
FILE=$(awk '{print $2}' $RELATEpath/barcodes.txt | sed "${ID}q;d")

## cycle
for I in {1..2}
do
	## data LANE
	LANE=$(sed "${I}q;d" ${RELATEpath}/raw.files.txt)
	BASENAME=$(basename -s .fastq.gz $LANE)
	INPUT1LANE1=${INPUTpath}/$BASENAME/$FILE\.1.fq.gz
	INPUT2LANE1=${INPUTpath}/$BASENAME/$FILE\.2.fq.gz
	OUTPUT1pLANE1=${OUTPUTpath}/$BASENAME/$FILE\.1.p.fq.gz
	OUTPUT2pLANE1=${OUTPUTpath}/$BASENAME/$FILE\.2.p.fq.gz
	OUTPUT1uLANE1=${OUTPUTpath}/$BASENAME/$FILE\.1.u.fq.gz
	OUTPUT2uLANE1=${OUTPUTpath}/$BASENAME/$FILE\.2.u.fq.gz

	## trimmomatic
	trimmomatic PE \
		$INPUT1LANE1 \
		$INPUT2LANE1 \
		$OUTPUT1pLANE1 \
		$OUTPUT1uLANE1 \
		$OUTPUT2pLANE1 \
		$OUTPUT2uLANE1 \
		ILLUMINACLIP:$ADAPTER:2:30:10 \
		HEADCROP:15 SLIDINGWINDOW:4:18 MINLEN:45
done
