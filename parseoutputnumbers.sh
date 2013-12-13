#!/bin/bash
# Script makes a csv file with all info for contigs and scaffolds gt 500 nt from ray output
# run this script in the directory that alls all your ray run directories
# in other words, ls -d */ should list all your ray runs
# it puts the output into outputfile

outputfile=raystats.csv

# column headings from OutputNumbers.txt
echo "kmer, dirname, c_num, c_totlen, c_ave, c_n50, c_med, c_larg, s_num, s_totlen, s_ave, s_n50, s_med, s_larg" > $outputfile

for dir in `ls -d */`;
do
# get kmer from the CoverageDistributionAnalysis.txt
head -1 $dir/CoverageDistributionAnalysis.txt |cut -d":" -f2|tr -d [:blank:] |tr -d '\n' >> $outputfile
echo ", " |tr -d '\n' >>$outputfile
# add the directory name for reference
echo $dir |tr -d '\n' >> $outputfile 
echo "," |tr -d '\n'>> $outputfile
# next put all the stuff from OutputNumbers.txt for contig bigger than 500
head -14 $dir/OutputNumbers.txt |tail -6 | cut -d":" -f2 |tr '\n' ','  >> $outputfile   
tail -6 $dir/OutputNumbers.txt | cut -d":" -f2 |tr '\n' ',' >> $outputfile
echo ' ' >> $outputfile
done
cat $outputfile
