#!/bin/bash
#SBATCH --job-name=multiqc
#SBATCH --cpus-per-task=10
#SBATCH --mem=20G
#SBATCH --time=04:00:00
#SBATCH -o ./out/004.multiqc.trimmed.out
#SBATCH -e ./err/004.multiqc.trimmed.err

## path
LIBSpath=/mnt/tank/scratch/klytkin/bereza/001.lib
FASTpath=${LIBSpath}/004.fastqc.trimmed

## multiqc
multiqc $FASTpath -o $FASTpath