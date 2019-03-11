#!/bin/sh
#
#  Reserve 1 CPUs for this job
#$ -pe parallel 1
#  Request 10G of RAM
#$ -l h_vmem=10G
#
#  The name shown in the qstat output and in the output file(s). The
#  default is to use the script name.
# -N $name
#
#  The path used for the standard output stream of the job
# -o 
#
# Merge stdout and stderr. The job will create only one output file which
# contains both the real output and the error messages.
# -j y
#
#  Use /bin/bash to execute this script
#$ -S /bin/bash
#
#  Run job from current working directory
#$ -cwd
#
#  Send email when the job begins, ends, aborts, or is suspended
##$ -m beas

merged=$1
usearch=/ebio/abt6_projects7/bacterial_strain_analysis/code/usearch10

#515 1-3-5
rm "$merged"_515F1F3F5.fastq

#515_f1 with #806_f2
grep "^GAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTA$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 21 -stripright 23  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F1F3F5.fastq
rm "$merged"_temp*
#515_f1 with #806_f4
grep "^GAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTAGT$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 21 -stripright 25  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F1F3F5.fastq
rm "$merged"_temp*
#515_f1 with #806_f6
grep "^GAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTAGTCA$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 21 -stripright 27  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F1F3F5.fastq
rm "$merged"_temp*

#515_f3 with #806_f2
grep "^CTGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTA$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 23 -stripright 23  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F1F3F5.fastq
rm "$merged"_temp*
#515_f3 with #806_f4
grep "^CTGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTAGT$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 23 -stripright 25  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F1F3F5.fastq
rm "$merged"_temp*
#515_f3 with #806_f6
grep "^CTGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTAGTCA$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 23 -stripright 27  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F1F3F5.fastq
rm "$merged"_temp*

#515_f5 with #806_f2
grep "^GACTGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTA$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 25 -stripright 23  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F1F3F5.fastq
rm "$merged"_temp*
#515_f5 with #806_f4
grep "^GACTGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTAGT$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 25 -stripright 25  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F1F3F5.fastq
rm "$merged"_temp*
#515_f5 with #806_f6
grep "^GACTGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTAGTCA$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 25 -stripright 27  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F1F3F5.fastq
rm "$merged"_temp*

#515 2-4-6
rm "$merged"_515F2F4F6.fastq

#515_f2 with #806_f1
grep "^TGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGT$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 22 -stripright 22  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F2F4F6.fastq
rm "$merged"_temp*
#515_f2 with #806_f3
grep "^TGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTAG$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 22 -stripright 24  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F2F4F6.fastq
rm "$merged"_temp*
#515_f2 with #806_f5
grep "^TGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTAGTC$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 22 -stripright 26  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F2F4F6.fastq
rm "$merged"_temp*

#515_f4 with #806_f1
grep "^ACTGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGT$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 24 -stripright 22  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F2F4F6.fastq
rm "$merged"_temp*
#515_f4 with #806_f3
grep "^ACTGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTAG$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 24 -stripright 24  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F2F4F6.fastq
rm "$merged"_temp*
#515_f4 with #806_f5
grep "^ACTGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTAGTC$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 24 -stripright 26  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F2F4F6.fastq
rm "$merged"_temp*

#515_f6 with #806_f1
grep "^TGACTGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGT$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 26 -stripright 22  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F2F4F6.fastq
rm "$merged"_temp*
#515_f6 with #806_f3
grep "^TGACTGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTAG$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 26 -stripright 24  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F2F4F6.fastq
rm "$merged"_temp*
#515_f6 with #806_f5
grep "^TGACTGAGTG[ACTG]CAGC[ATCG]GCCGCGGTAA[ATCG]*ATTAGA[ATCG]ACCC[ATCG][ATCG]GTAGTCCGTAGTC$" $merged -B 1 -A 2 --no-group-separator > "$merged"_temp.fq 
$usearch -fastx_truncate "$merged"_temp.fq -stripleft 26 -stripright 26  -fastqout "$merged"_temp.fq.stripped
cat "$merged"_temp.fq.stripped >> "$merged"_515F2F4F6.fastq
rm "$merged"_temp*


