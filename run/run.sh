#!/bin/bash
ref=$1
chr_name=$2
fq_name1=$3
fq_name2=$4
read_length=$5
insert_size=$6
insert_size_diviation=$7
../software/bwa-0.7.5a/./bwa index ${ref}
../software/bwa-0.7.5a/./bwa mem ${ref} ${fq_name1} ${fq_name2} >all_mutation.sam
java -classpath ../ERINS filter_all_mutation.Filter all_mutation.sam mim.sam filtered.sam unmapped.sam discordant.txt ${read_length} ${insert_size} ${insert_size_diviation} mim_readname.lst filtered_readname.lst unmapped_read.lst merged_read_name.lst
../software/seqtk-master/./seqtk subseq ${fq_name1} merged_read_name.lst >out1.fq
../software/seqtk-master/./seqtk subseq ${fq_name2} merged_read_name.lst >out2.fq
java -classpath ../ERINS all_mutation_ref_upper2lower.Upper2Lower ${ref} lower.fa
cp lower.fa test1.fa
da="test"
db="1"
dc=${da}${db}
dd="out1_"
#ee="out2_"
ddc=${dd}${db}
#ddd=${ee}${db}
count=1
flag=100
while (test -e ${dc}".fa")
do
	../software/bwa-0.7.5a/./bwa index ${dc}".fa"
	../software/bwa-0.7.5a/./bwa mem ${dc}".fa" "out1.fq" "out2.fq">${dc}".sam"
	java -classpath ../ERINS allMutation_longInsertion_v2.Test $da $db ${chr_name}
	let db=$db+1
	echo $db
	dc=${da}${db}
	if [[ $count -gt $flag ]]
	then			
		break
	fi
	let count=$count+1
	rm -f temp_fqname.lst
done
let db=$db-1
dc=${da}${db}
java -classpath ../ERINS all_mutation_output.MutationOutput ${dc}".fa" "insertion_result.txt"
cp test1_i_pos_seq.txt first_filter.txt
java -classpath ../ERINS filter.Fileter ${ref} "first_filter.txt" "insertion_result.txt" "final_insertion_result.txt"
cp final_insertion_result.txt ../output/insertion_result.txt
rm -f final_insertion_result.txt
rm -f deletion_result.txt
rm -f test*
rm -f out*
rm -f temp.sam
rm -f temp_insertion_result.txt
rm -f first_filter.txt
rm -f insertion_result.txt
rm -f discordant.txt
rm -f single.fq
rm -f filtered.sam
rm -f filtered_readname.lst
rm -f merged_read_name.lst
rm -f mim.sam
rm -f mim_readname.lst
rm -f unmapped.sam
rm -f unmapped_read.lst
rm -f all_mutation_original.fa.*
rm -f all_mutation.sam
rm -f lower.fa
rm -f pair_read_name.lst

