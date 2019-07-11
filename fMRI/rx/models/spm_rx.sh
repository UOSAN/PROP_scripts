#!/bin/bash
#SBATCH --time=0-00:01:00
#SBATCH --partition=short

# Set your study
STUDY=/projects/sanlab/shared/PROP/PROP_scripts

# SPM Path
SPM_PATH=/projects/sanlab/shared/spm12

# Set MATLAB script path
SCRIPT=${STUDY}/fMRI/rx/cbt_pst_relevance.m

# PROP the results files
RESULTS_INFIX=rx_relevance

# Set output dir and make it if it doesn't exist
OUTPUTDIR=${STUDY}/fMRI/rx/output

if [ ! -d ${OUTPUTDIR} ]; then
	mkdir -p ${OUTPUTDIR}
fi

# run script
module load matlab
srun --job-name="${RESULTS_INFIX}" \
	 -o "${OUTPUTDIR}"/"${RESULTS_INFIX}".log \
	 --account=sanlab \
	 matlab -nosplash -nodisplay -nodesktop -r "clear; addpath('$SPM_PATH'); spm_jobman('initcfg'); spm_jobman('run',$SCRIPT); exit"