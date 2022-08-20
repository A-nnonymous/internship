#! /bin/bash

export cpuCNT=8
export ORGANISM=covid
# Temporary hard coded
export readID=SRR21120977
export outputPATH=~/projects/output/${readID}
mkdir -p ~/projects/output/${readID}
# Mocked up readgroup because SRA don't give that
export readGroup="@RG\tID:<SRR21120977>\tLB:<SRR21120977>\tSM:<SRR21120977\tPL:ILLUMINA"

export refPATH=~/projects/data/references
export readPATH=~/projects/data/specimens

export refFILE=${refPATH}/${ORGANISM}/${ORGANISM}.fasta
export readFILE=${readPATH}/${ORGANISM}/${readID}.fastq

################## Initial alignment with bwa-mem##################
bwa mem \
    -t ${cpuCNT} \
    -Y \
    -R ${readGroup} \
    ${refFILE} ${readFILE} \
    > ${outputPATH}/aligned.sam

export aligned_reads=${outputPATH}/aligned.sam
################## Initial alignment with bwa-mem##################


################## Mark Duplicate and sort with gatk##################
#In concerning of brevity, no temp file used in this script
gatk \
    MarkDuplicatesSpark \
    -I ${aligned_reads} \
    -M ${outputPATH}/dedup_metrics.txt \
    -O ${outputPATH}/sorted_dedup.bam 

export sorted_dedup_reads=${outputPATH}/sorted_dedup.bam
################## Mark Duplicate and sort with gatk##################

################## Get metrics from picard##################
export PICARD_JAR=/apps/picard/2.17.11/picard.jar

java -jar ${PICARD_JAR} CollectAlignmentSummaryMetrics R=${refFILE} I=${sorted_dedup_reads} O=${outputPATH}/alignment_metrics.txt

java -jar \
${PICARD_JAR} \
CollectInsertSizeMetrics \
-I ${sorted_dedup_reads} \
-O ${outputPATH}/insert_metrics.txt \
-H ${outputPATH}/insert_size_histogram.pdf 

samtools depth -a ${sorted_dedup_reads} > ${outputPATH}/depth_out.txt
################## Get metrics from picard##################
################## Create dict with picard##################
java -jar ${PICARD_JAR} CreateSequenceDictionary \
R=${refFILE} \
O=${refPATH}/${ORGANISM}/${ORGANISM}.dict
################## Create dict with picard##################

################## Variant Calling using GATK hCaller##################
export input_bam=${sorted_dedup_reads}
gatk HaplotypeCaller \
    -R $refFILE \
    -I $input_bam \
    -O ${outputPATH}/raw_variants.vcf 

################## Variant calling using GATK hCaller##################
################## Variant selecting using GATK########################
export raw_variants=${outputPATH}/raw_variants.vcf
gatk SelectVariants \
	-R $refFILE \
	-V $raw_variants \
	-select-type SNP \
	-O ${outputPATH}/raw_snps.vcf
gatk SelectVariants \
        -R $refFILE \
        -V $raw_variants \
        -select-type INDEL \
        -O ${outputPATH}/raw_indels.vcf
################## Variant selecting using GATK########################

################## SNP filtering##################
export raw_snps=${outputPATH}/raw_snps.vcf 
gatk VariantFiltration \
    -R $refFILE \
    -V $raw_snps \
    -O ${outputPATH}/filtered_snps.vcf \
    -filter-name "QD_filter" -filter "QD < 2.0" \
    -filter-name "FS_filter" -filter "FS > 60.0" \
    -filter-name "MQ_filter" -filter "MQ < 40.0" \
    -filter-name "SOR_filter" -filter "SOR > 4.0" \
    -filter-name "MQRankSum_filter" -filter "MQRankSum < -12.5" \
    -filter-name "ReadPosRankSum_filter" -filter "ReadPosRankSum < -8.0"
################## SNP filtering##################
################## Indel filtering##################
export raw_indels=${outputPATH}/raw_indels.vcf 
gatk VariantFiltration \
    -R $refFILE \
    -V $raw_indels \
    -O ${outputPATH}/filtered_indels.vcf \
	-filter-name "QD_filter" -filter "QD < 2.0" \
	-filter-name "FS_filter" -filter "FS > 200.0" \
	-filter-name "SOR_filter" -filter "SOR > 10.0"
################## Indel filtering##################

################## BQSR##################
export filtered_snps=${outputPATH}/filtered_snps.vcf
export filtered_indels=${outputPATH}/filtered_indels.vcf

gatk SelectVariants \
	--exclude-filtered \
	-V $filtered_snps \
	-O ${outputPATH}/bqsr_snps.vcf
gatk SelectVariants \
    --exclude-filtered \
    -V $filtered_indels \
    -O ${outputPATH}/bqsr_indels.vcf
gatk BaseRecalibrator \
	-R $refFILE \
	-I $input_bam \
	--known-sites ${outputPATH}/bqsr_snps.vcf \
	--known-sites ${outputPATH}/bqsr_indels.vcf \
	-O ${outputPATH}/recal_data.table
gatk ApplyBQSR \
    -R $refFILE \
    -I $input_bam \
    -bqsr ${outputPATH}/recal_data.table \
    -O ${outputPATH}/recal.bam
gatk BaseRecalibrator \
    -R $refFILE \
	-I ${outputPATH}/recal.bam \
    --known-sites ${outputPATH}/bqsr_snps.vcf \
	--known-sites ${outputPATH}/bqsr_indels.vcf \
	-O ${outputPATH}/post_recal_data.table
################## BQSR##################

################## Covariate analysis##################
export recal_table=${outputPATH}/recal_data.table
export post_recal_table=${outputPATH}/post_recal_data.table
gatk AnalyzeCovariates \
	-before $recal_table \
	-after $post_recal_table \
	-plots ${outputPATH}/recalibration_plots.pdf
################## Covariate analysis##################

################## SNPEFF##################
# This package should use later version of java than gatk
export SNPEFF_JAR=/apps/snpEff/snpEff.jar
export snpeff_db="coronavirus"
mkdir -p /apps/snpeff/data
export snpeff_data=/apps/snpeff/data
/usr/bin/java -jar $SNPEFF_JAR -v \
	-dataDir $params.snpeff_data \
	${snpeff_db} \
	$filtered_snps > ${outputPATH}/filtered_snps.ann.vcf
################## SNPEFF##################

################## Sample-wised QC##################
cd ${outputPATH}

/home/pzw/Documents/centShare/panzhaowu/Documents/projects/workflow_templates/nextflow_pipline_VC/bin/parse_metrics.sh ${readID} > ${outputPATH}/report.csv
################## Sample-wised QC##################