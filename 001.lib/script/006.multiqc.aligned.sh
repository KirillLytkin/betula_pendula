#!/bin/bash
#SBATCH --job-name=multiqc
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH -o ./out/006.multiqc.aligned.out
#SBATCH -e ./err/006.multiqc.aligned.err

## path
LIBSpath=/mnt/tank/scratch/klytkin/bereza/001.lib
FASTpath=${LIBSpath}/006.fastqc.aligned

## multiqc
multiqc $FASTpath -o $FASTpath