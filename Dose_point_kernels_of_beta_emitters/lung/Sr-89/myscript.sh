#!/bin/sh
# This is a simple script to run simulation in the SGE cluster
# print date and time
date

# I want to get an email when the simulation begins and when it ends
#$ -M ashok-tiwari@uiowa.edu
#$ -m be

# let us set the virtual memory and wall clock time
# -l h_vmem=8G
# -l h_rt=24:00:00

# run simulations in current working directory
#$ -cwd

# specify the cluster name
# -q all.q
#$ -q UI

# May request for free memory
# -l mf=10G

# specify the number of job slots
#$ -pe smp 8

# Now, let us run the simulation
Gate main.mac
