#!/bin/sh
# print date and time
date

#$ -M ashok-tiwari@uiowa.edu
#$ -m be 
#$ -l h_vmem=8G
#$ -l h_rt=40:00:00

#$ -cwd
#$ -q all.q

# -l mf=10G
# -q UI-HM
#$ -pe smp 8

Gate main.mac
