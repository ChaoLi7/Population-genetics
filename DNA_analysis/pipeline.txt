# DNA
# trim
java -Xmx30g -jar trimmomatic-0.36.jar PE -threads 10 ${sample}_1.fq.gz ${sample}_2.fq.gz ${sample}_1.clean.fastq.gz ${sample}_1.unpaired.fastq.gz ${sample}_2.clean.fastq.gz ${sample}_2.unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:40 TOPHRED33 > ${sample}.log

# mapping
bwa mem -t 16 -M -R '@RG\tID:${sample}\tLB:${sample}\tPL:ILLUMINA\tSM:${sample}' $ref ${sample}_1.clean.fastq.gz ${sample}_2.clean.fastq.gz | samtools view -Sbh - > ${sample}.bam

java -Xmx60g -Djava.io.tmpdir=${tmp} -jar picard.jar SortSam \
        ${sample}.bam ${sample}.sort.bam \
        SORT_ORDER=coordinate VALIDATION_STRINGENCY=LENIENT 

java -Xmx60g -Djava.io.tmpdir=${tmp} -jar picard.jar MergeSamFiles \
        I=${sample}_L1.sort.bam \
        I=${sample}_L2.sort.bam \
        O=${sample}.sort.merge.bam

samtools index ${sample}.sort.merge.bam

java -Xmx60g -Djava.io.tmpdir=${tmp} -jar picard.jar MarkDuplicates \
        INPUT=${sample}.sort.merge.bam \
        OUTPUT=${sample}.sort.merge.dedup.bam \
        METRICS_FILE=${sample}_dedup \
        REMOVE_DUPLICATES=true \
        CREATE_INDEX=true \
        ASSUME_SORTED=true \
        VALIDATION_STRINGENCY=LENIENT \
        MAX_FILE_HANDLES=2000

java -Xmx60g -Djava.io.tmpdir=${tmp} -jar GenomeAnalysisTK.jar -T RealignerTargetCreator \
        -R $ref \
        -I ${sample}.sort.merge.dedup.bam \
        -o ${sample}_intervals.list

java -Xmx60g -Djava.io.tmpdir=${tmp} -jar GenomeAnalysisTK.jar -T IndelRealigner 
        -R $ref \
        -I ${sample}.sort.merge.dedup.bam \
        -targetIntervals ${sample}_intervals.list \
        -o ${sample}.sort.merge.dedup.realn.bam

java -Xmx60g -Djava.io.tmpdir=${tmp} -jar picard.jar ReorderSam \
        R=$ref \
        I=${sample}.sort.merge.dedup.realn.bam \
        O=${sample}.sort.merge.dedup.realn.reorder.bam \
        CREATE_INDEX=TRUE

java -Xmx60g -Djava.io.tmpdir=${tmp} -jar picard.jar AddOrReplaceReadGroups \
        I=${sample}.sort.merge.dedup.realn.reorder.bam \
        O=${sample}.sort.merge.dedup.realn.reorder.reheader.bam \
        RGID=165 RGLB=${i} RGPL=illumina RGPU=${i} RGSM=${i} \
        CREATE_INDEX=True

#variants calling
java -Xmx60g -Djava.io.tmpdir=${tmp} -jar GenomeAnalysisTK.jar -T HaplotypeCaller \
        -R $ref \
        -ERC GVCF \
        -I ${sample}.sort.merge.dedup.realn.reorder.reheader.bam \
        -o ${sample}.g.vcf.gz

for i in $(chr)
do
for j in $(samples)
do
ls path/${j}/${j}_chr${i}.g.vcf.gz >> $i.gvcf.list
done
done

for i in {1..29} X Y
do
echo "java -Xmx60g -Djava.io.tmpdir=${tmp} -jar gatk-package-4.1.7.0-local.jar \
        -CombineGVCFs \
        -R ref.fa \
        -V ${i}.gvcf.list \
        -O Merge.${i}.g.vcf.gz " > ${i}.sh
        
for i in {1..29} X Y
do
echo "java -Xmx60g -Djava.io.tmpdir=${tmp} -jar gatk-package-4.1.7.0-local.jar \
        -CombineGVCFs \
        -R ref.fa \
        -V Merge.${i}.g.vcf.gz \
        -O Merge.genotype.${i}.vcf.gz" > ${i}.sh
        
for i in {1..29} #X Y need instead
do
	echo "plink --vcf Merge.genotype.$i.vcf.gz \
        --chr-set 29 no-xy \
        --vcf-half-call m \
        --geno 1 \
        --recode vcf-iid \
        --keep-allele-order \
        --out ${i}" >> ${i}.sh
	echo "bgzip ${i}.vcf" >> ${i}.sh
	echo "tabix -p vcf ${i}.vcf.gz" >> ${i}.sh
        
for i in {1..29}
do
	echo "plink --vcf Merge.genotype.$i.vcf.gz \
        --chr-set 29 no-xy \
        --vcf-half-call m --geno 1 \
        --recode vcf-iid \
        --keep-allele-order --out ${i}" >> ${i}.sh
	echo "bgzip ${i}.vcf" >> ${i}.sh
	echo "tabix -p vcf ${i}.vcf.gz" >> ${i}.sh

