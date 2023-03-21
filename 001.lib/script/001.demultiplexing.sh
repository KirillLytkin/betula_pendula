#!/bin/bash
#SBATCH --job-name=demultiplexing
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --time=24:00:00
#SBATCH -o ./out/001.demultiplexing.out
#SBATCH -e ./err/001.demultiplexing.err

## path/data
LIBSpath=/mnt/tank/scratch/klytkin/bereza/001.lib
BARC=${LIBSpath}/relate/barcode.txt
DATA=${LIBSpath}/000.raw.data
DEMU=${LIBSpath}/001.demultiplexed.sample

## process_radtags
process_radtags \
	-p $DATA \
	-o $DEMU \
	-b $BARC \
	-i 'gzfastq' \
	--renz_1 hindIII \
	--renz_2 nlaIII \
	-r -c -q

## information
# -r,--rescue — rescue barcodes and RAD-Tag cut sites
# -c,--clean — clean data, remove any read with an uncalled base
# -q,--quality — discard reads with low quality scores
