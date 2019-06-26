#!/bin/bash

# This script runs fmriprep on subjects located in the BIDS directory 
# and saves ppc-ed output and motion confounds
# in the derivatives folder.

# Set bids directories
bids_dir="${group_dir}""${study}"/bids_data
derivatives="${bids_dir}"/derivatives
image="${group_dir}""${container}"

echo -e "\nfMRIprep on ${subid}_${sessid}"
echo -e "\nContainer: $image"
echo -e "\nSubject directory: $bids_dir"

# Source task list
#tasks=`cat tasks.txt` 
tasks=(PROP1 PROP2)

# Load packages
module load singularity

# Run container using singularity
cd $bids_dir

for task in ${tasks[@]}; do

echo -e "\nStarting on: $task"
echo -e "\n"

PYTHONPATH="" singularity run --bind "${group_dir}":"${group_dir}" $image $bids_dir $derivatives participant --participant_label $subid -t $task -w /tmp --output-space {template,T1w,fsnative} --nthreads 1 --mem-mb 100000 --fs-license-file /projects/sanlab/shared/"${study}"/"${study}"_scripts/fMRI/ppc/license.txt --account=sanlab


echo -e "\n"
echo -e "\ndone"
echo -e "\n-----------------------"

done

# clean tmp folder
/usr/bin/rm -rvf /tmp/fmriprep*