--------------------------------------------------------------------------------
Table of Contents
--------------------------------------------------------------------------------

  1. Folder information

  2. Usage of ERINS

  3. Output
  
  4. Platform
  
  
--------------------------------------------------------------------------------
1.Folder information
--------------------------------------------------------------------------------
When you download ERINS, you will see that there are five directories.
1.input
This directory contains your input files, including a pair of fastq files and a reference sequence file.
2.output
This directory stores the detection results.The example folder contains an example for verification. If you use the test input in the input file to do the detection and get the same output, then you have successfully run ERINS.
3.run
This directory contains the running script. If you want to do the insertion detection, run run.sh. If you want to do genotype detection, run hytero_run.sh; see below for specific usage.
4.software
This directory contains three software that depends on it.
5.ERINS
This directory contains the ERINS program.


--------------------------------------------------------------------------------
2.Usage of ERINS
--------------------------------------------------------------------------------
(1)how to run run.sh
bash run.sh args1 args2 args3 args4 args5 args6 args7
args1：args1 is the reference sequence
args2: args2 is the name of your reference sequence (ie the string behind the character '>' in the fasta file)
args3:first fastq file
args4: second fastq file
args5: read length
args6: insert size
args7: insert size diviation

For example, when running the test sample, you can do this:
bash ../run/run.sh all_mutation_original.fa chr21 hytero1.fq hytero2.fq 100 500 30

(2)how to run hytero_run.sh
bash hytero_run.sh args1 args2 args3 args4 args5
args1:args1 is the result of your insertion detection
args2:args2 is the reference sequence
args3:args3 is the name of the virtual sequence you want to generate (name it yourself)
args4:first fastq file
args5:second fastq file
For example, when running the test sample, you can do this:
bash ../run/hytero_run.sh ../output/example/insertion_result.txt all_mutation_original.fa all_mutation_final.fa hytero1.fq hytero2.fq

--------------------------------------------------------------------------------
3.Output
--------------------------------------------------------------------------------
insertion_result.txt has a total of five columns
(1)：reference sequence name
(2)：the position where the mutation occurred
(3)：Because it is an insertiion variation, the position is the same as the second column
(4)：Sequence information without mutation
(5)：Sequence information with mutation

hetero_homo_result.txt has a total of four columns
(1)：the position where the mutation occurred
(2)：Variation size
(3)：P-value
(4)：Indicate whether it is a heterozygous variation or a homozygous variation（1 represents heterozygous variation, 2 represents homozygous variation）


--------------------------------------------------------------------------------
4.Platform
--------------------------------------------------------------------------------
ERINS runs on a Linux system
