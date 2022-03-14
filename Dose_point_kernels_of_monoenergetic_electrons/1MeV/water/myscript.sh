#!/bin/sh
#
# print date and time
date

# This is a sample script file for running a GATE simulation
# program under Sun Grid Engine, I want Grid Engine to send email
# when the job begins and when it ends

#$ -M ashok-tiwari@uiowa.edu
#$ -m be

# -l h_vmem=20G
# -l h_rt=60:00:00

#$ -cwd
# -q UI-HM

#$ -q UI

#$ -pe smp 2

Gate main.mac
