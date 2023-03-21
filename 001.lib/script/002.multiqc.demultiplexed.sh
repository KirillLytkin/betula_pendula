#!/bin/bash
#SBATCH --job-name=multiqc
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH -o ./out/002.multiqc.demultiplexed.out
#SBATCH -e ./err/002.multiqc.demultiplexed.err

## path
LIBSpath=/mnt/tank/scratch/klytkin/bereza/001.lib
FASTpath=${LIBSpath}/002.fastqc.demultiplexed

## multiqc
multiqc $FASTpath -o $FASTpath