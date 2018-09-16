#!/bin/bash
#SBATCH --time=0-00:01:00
#SBATCH --partition=short

# Set your study
STUDY=/projects/sanlab/shared/PROP/PROP_scripts

# SPM Path
SPM_PATH=/projects/sanlab/shared/spm12

# Set MATLAB script path
SCRIPT=${STUDY}/fMRI/rx/models/pst_relevance.m

# PROP the results files
RESULTS_INFIX=rx_pst_relevance

# Set output dir
OUTPUTDIR=${STUDY}/fMRI/rx/shell/output


# run script
module load matlab
srun --job-name="${RESULTS_INFIX}" -o "${OUTPUTDIR}"/"${RESULTS_INFIX}".log \
	 matlab -nosplash -nodisplay -nodesktop -r "clear; addpath('$SPM_PATH'); spm_jobman('initcfg'); spm_jobman('run',$SCRIPT); exit"