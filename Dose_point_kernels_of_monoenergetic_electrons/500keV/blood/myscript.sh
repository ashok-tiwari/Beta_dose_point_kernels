#!/bin/sh
# print date and time
date

#$ -M ashok-tiwari@uiowa.edu
#$ -m be

# -l h_vmem=20G
# -l h_rt=45:00:00

#$ -cwd
#$ -q UI,PET

# -l mf=10G
# -q UI-HM

#$ -pe smp 2

Gate main.mac
