#!/bin/sh
# This is a simple example of a SGE batch script

#
# print date and time
date

# This is a samle GATE script file for running a GATE simulation 
# program under Sun Grid Engine, I want Grid Engine to send mail 
# when the job begins and when it ends
# 
#$ -M ashok-tiwari@uiowa.edu
#$ -m be
#$ -l h_vmem=20G
#$ -l h_rt=50:00:00

#$ -cwd
# -q UI-HM
#$ -q UI

#$ -pe smp 20

# To start the simulation I need to run: Gate main.mac
Gate main.mac

# Gate will take care of output files according to macros
