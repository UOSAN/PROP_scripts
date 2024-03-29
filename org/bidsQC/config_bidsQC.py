import os
from datetime import datetime
from bidsQC_classes import Sequence
from bidsQC_classes import TimePoint

######################## CONFIGURAGBLE PART BELOW ########################

# Set study info (change these for your study)
# These variables are used only in this file for path names.
# They can be removed if desired.
group = 'sanlab'
study = 'PROP'

# Set directories (Check these for your study)
# These variables are used in the main script and need to be defined here. 
# They need to exist prior to running the script.
logdir = os.path.join(os.getcwd(), 'logs_bidsQC')  # Where log files will go
bidsdir = os.path.join(os.sep, 'projects', group, 'shared', study, 'bids_data')  # Where your subjects' nifti directories are


# Create a dictionary (the thing below) for each timepoint in your study where the pairs are 'sequence_directory_name' : 'expected_number_runs'
# Each unique version of a sequence gets its own entry, e.g. 'gng_acq-1' and 'gng_acq-2'
sequence1 = Sequence('func', {'PROP1': 1, 'PROP2':1})
sequence2 = Sequence('anat', {'T1w':1})
sequence3 = Sequence('fmap', {'dir-ap':1, 'dir-pa':1})
timepoint1 = TimePoint('ses-1', [sequence1, sequence2, sequence3])
expected_timepoints = [timepoint1]


# Files g-zipped or not? 
# NOTE: All files must be either zipped or unzipped. 
# A mixture won't work properly.
gzipped = True


# Do we want runs based on sequence order? Yes = True
# This is for tasks that use counterbalancing (of e.g. stimulus blocks) anf for which we want to identify the content
# with the 'acq-' label and order administered with the 'task-' label.
order_sequences = False
tasks_to_order = 'task1', 'task2'


# Paths that are required and that should not be changed
tempdir = os.path.join(bidsdir, 'tmp_dcm2bids')  # holding folder for undesired files
outputlog = os.path.join(logdir, 'outputlog_bidsQC' + datetime.now().strftime('%Y%m%d-%H%M%S') + '.txt')
errorlog = os.path.join(logdir, 'errorlog_bidsQC' + datetime.now().strftime('%Y%m%d-%H%M%S') + '.txt')
derivatives = os.path.join(bidsdir, 'derivatives')  # Where processed data will go