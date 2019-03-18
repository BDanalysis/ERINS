#!/bin/bash
insertion_result=$1
ref=$2
virtual_ref=$3
fq_name1=$4
fq_name2=$5
java -classpath ../ERINS all_mutation_hytero.ToFinalFa ${insertion_result} ${ref} ${virtual_ref} "pos_info.txt"
../software/bwa-0.7.5a/./bwa index ${virtual_ref}
../software/bwa-0.7.5a/./bwa mem ${virtual_ref} ${fq_name1} ${fq_name2} >final.sam
java -classpath ../ERINS all_mutation_hytero.ProcessSam "final.sam" "final_process.sam"
../software/samtools-0.1.18/./samtools view -S final_process.sam -b>fina_process.bam
../software/samtools-0.1.18/./samtools sort fina_process.bam final_process.sort
../software/samtools-0.1.18/./samtools index final_process.sort.bam
../software/samtools-0.1.18/./samtools depth final_process.sort.bam>final_process.depth.txt
java -classpath ../ERINS all_mutation_hytero.Pvalue "final_process.depth.txt" "pos_info.txt" "hytero_process_result.txt"
cp hytero_process_result.txt ../output/hetero_homo_result.txt
rm -f hytero_process_result.txt
rm -f *.sam
rm -f *.bam
rm ${virtual_ref}*
rm -f pos_info.txt
rm -f final_process*
rm -f temp.txt


