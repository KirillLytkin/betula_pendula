#!/bin/bash
#SBATCH --job-name=merging
#SBATCH --cpus-per-task=1
#SBATCH --mem=36G
#SBATCH --time=24:00:00
#SBATCH --array=1-96
#SBATCH -o ./out/003.merging.out/%a.array.out
#SBATCH -e ./err/003.merging.err/%a.array.err

## array
ID=$SLURM_ARRAY_TASK_ID

## path
ROOTpath=/mnt/tank/scratch/klytkin/bereza/001.lib
RELATEpath=${ROOTpath}/relate
INPUTpath=${ROOTpath}/002.trimmed.data
OUTPUTpath=${ROOTpath}/003.merged.data
LANE1path=${INPUTpath}/S_1_EKDL230000003-1A_HKN3NDSX5_L2
LANE2path=${INPUTpath}/S_1_EKDL230000003-1A_HKN3NDSX5_L4

## data
FILE=$(awk '{print $2}' $RELATEpath/barcodes.txt | sed "${ID}q;d")
INPUT1LANE1=${LANE1path}/$FILE\.1.p.fq.gz
INPUT2LANE1=${LANE1path}/$FILE\.2.p.fq.gz
INPUT1LANE2=${LANE2path}/$FILE\.1.p.fq.gz
INPUT2LANE2=${LANE2path}/$FILE\.2.p.fq.gz
OUTPUT1=${OUTPUTpath}/$FILE\.1.p.fq.gz
OUTPUT2=${OUTPUTpath}/$FILE\.2.p.fq.gz

## zcat | gzip
zcat $INPUT1LANE1 $INPUT1LANE2 | gzip -c > $OUTPUT1
zcat $INPUT2LANE1 $INPUT2LANE2 | gzip -c > $OUTPUT2
