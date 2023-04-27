#!/bin/bash
#SBATCH --job-name=filtrating
#SBATCH --cpus-per-task=10
#SBATCH --mem=36G
#SBATCH --time=24:00:00
#SBATCH -o ./out/009.filtrating.out
#SBATCH -e ./err/009.filtrating.err

## path
TOOLpath=/mnt/tank/scratch/klytkin/tools
REFERENCEpath=/mnt/tank/scratch/klytkin/bereza/000.ref
ROOTpath=/mnt/tank/scratch/klytkin/bereza/003.com
RELATEpath=${ROOTpath}/relate
INPUTpath=${ROOTpath}/008.genotyped.data
OUTPUTpath=${ROOTpath}/009.filtered.data

## data
GATK=${TOOLpath}/gatk-4.4.0.0/gatk
REFERENCE=${REFERENCEpath}/Betula_pendula_subsp._pendula.fasta
INPUT=${INPUTpath}/birch.samples.genotype.vcf
OUTPUT1=${OUTPUTpath}/birch.cohort.genotype.maf0.05.filtered.vcf
OUTPUT2=${OUTPUTpath}/birch.cohort.genotype.filtered.maf0.05.nocall0.5.SNP.biallelic.vcf
OUTPUT3=${OUTPUTpath}/birch.cohort.genotype.filtered.maf0.05.nocall0.5.SNP.biallelic.selected.vcf
OUTPUT4=${OUTPUTpath}/birch.cohort.genotype.filtered.maf0.05.nocall0.5.SNP.biallelic.table

## GATK
## VariantFiltration
$GATK --java-options "-Xmx36G" VariantFiltration \
	-R $REFERENCE \
	-V $INPUT \
	--output $OUTPUT1 \
	--filter-expression "MQ < 40.0" --filter-name "MQ40" \
	--filter-expression "QD < 24.0" --filter-name "QD24" \
	--filter-expression "MQRankSum < -2.0" --filter-name "MQRankSum2L" \
	--filter-expression "MQRankSum > 2.0" --filter-name "MQRankSum2R" \
	--filter-expression "FS > 60.0" --filter-name "FILE60" \
	--filter-expression "SOR > 3.0" --filter-name "SOR3" \
	--filter-expression "DP < 20.0" --filter-name "DP20" \
	--filter-expression "AF < 0.05" --filter-name "LowAF" \
	--filter-expression "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
	--filter-expression "AF > 0.99" --filter-name "HighAF"

## SelectVariants
$GATK SelectVariants \
	--variant $OUTPUT1 \
	-O $OUTPUT2 \
	-select-type SNP \
	--restrict-alleles-to BIALLELIC \
	--max-nocall-fraction 0.5 \
	--exclude-non-variants \
	--set-filtered-gt-to-nocall

## SelectVariants
$GATK SelectVariants \
	--variant $OUTPUT2 \
	-O $OUTPUT3 \
	--select "vc.isNotFiltered()"

## VariantsToTable
$GATK --java-options "-Xmx36G" VariantsToTable \
	-R $REFERENCE \
	-V $OUTPUT2 \
	--output $OUTPUT4 \
	-F CHROM -F POS -F ID -F REF -F ALT -F QUAL -F FILTER -F MQ -F QD \
	-F MQRankSum -F FS -F SOR -F DP -F AF -F ReadPosRankSum -F InbreedingCoeff \
	--show-filtered true
