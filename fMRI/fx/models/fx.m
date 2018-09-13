%-----------------------------------------------------------------------
% Job saved on 01-Jul-2018 22:03:53 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_mkdir.parent = {'/projects/sanlab/shared/PROP/bids_data/derivatives/standard/fx/'};
matlabbatch{1}.cfg_basicio.file_dir.dir_ops.cfg_mkdir.name = 'sub-001';
matlabbatch{2}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/PROP/bids_data/derivatives/fmriprep/sub-001/ses-wave1/func/'};
matlabbatch{2}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^sub-001_ses-1_task-PROP1_bold_space-MNI152NLin2009cAsym_preproc.nii.gz';
matlabbatch{2}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{3}.cfg_basicio.file_dir.file_ops.file_fplist.dir = {'/projects/sanlab/shared/PROP/bids_data/derivatives/fmriprep/sub-001/ses-wave1/func/'};
matlabbatch{3}.cfg_basicio.file_dir.file_ops.file_fplist.filter = '^sub-001_ses-1_task-PROP2_bold_space-MNI152NLin2009cAsym_preproc.nii.gz';
matlabbatch{3}.cfg_basicio.file_dir.file_ops.file_fplist.rec = 'FPList';
matlabbatch{4}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (^sub-001_ses-1_task-PROP1_bold_space-MNI152NLin2009cAsym_preproc.nii.gz)', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{4}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir(1) = cfg_dep('Make Directory: Make Directory ''sub-001''', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dir'));
matlabbatch{4}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.files(1) = cfg_dep('File Selector (Batch Mode): Selected Files (^sub-001_ses-1_task-PROP2_bold_space-MNI152NLin2009cAsym_preproc.nii.gz)', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.outdir(1) = cfg_dep('Make Directory: Make Directory ''sub-001''', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dir'));
matlabbatch{5}.cfg_basicio.file_dir.file_ops.cfg_gunzip_files.keep = true;
matlabbatch{6}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{6}.spm.util.exp_frames.frames = Inf;
matlabbatch{7}.spm.util.exp_frames.files(1) = cfg_dep('Gunzip Files: Gunzipped Files', substruct('.','val', '{}',{5}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{':'}));
matlabbatch{7}.spm.util.exp_frames.frames = Inf;
matlabbatch{8}.spm.spatial.smooth.data(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{6}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{8}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{8}.spm.spatial.smooth.dtype = 0;
matlabbatch{8}.spm.spatial.smooth.im = 0;
matlabbatch{8}.spm.spatial.smooth.prefix = 's6_';
matlabbatch{9}.spm.spatial.smooth.data(1) = cfg_dep('Expand image frames: Expanded filename list.', substruct('.','val', '{}',{7}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{9}.spm.spatial.smooth.fwhm = [6 6 6];
matlabbatch{9}.spm.spatial.smooth.dtype = 0;
matlabbatch{9}.spm.spatial.smooth.im = 0;
matlabbatch{9}.spm.spatial.smooth.prefix = 's6_';
matlabbatch{10}.spm.stats.fmri_spec.dir(1) = cfg_dep('Make Directory: Make Directory ''sub-001''', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','dir'));
matlabbatch{10}.spm.stats.fmri_spec.timing.units = 'secs';
matlabbatch{10}.spm.stats.fmri_spec.timing.RT = 2;
matlabbatch{10}.spm.stats.fmri_spec.timing.fmri_t = 72;
matlabbatch{10}.spm.stats.fmri_spec.timing.fmri_t0 = 36;
matlabbatch{10}.spm.stats.fmri_spec.sess(1).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{8}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{10}.spm.stats.fmri_spec.sess(1).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{10}.spm.stats.fmri_spec.sess(1).multi = {'/projects/sanlab/shared/PROP/PROP_scripts/fMRI/fx/multiconds/standard/PROP001_run1_CBT_v_PST'};
matlabbatch{10}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
matlabbatch{10}.spm.stats.fmri_spec.sess(1).multi_reg = {'/projects/sanlab/shared/PROP/PROP_scripts/fMRI/fx/motion/rp_txt/rp_001_1_PROP_1.txt'};
matlabbatch{10}.spm.stats.fmri_spec.sess(1).hpf = 128;
matlabbatch{10}.spm.stats.fmri_spec.sess(2).scans(1) = cfg_dep('Smooth: Smoothed Images', substruct('.','val', '{}',{9}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files'));
matlabbatch{10}.spm.stats.fmri_spec.sess(2).cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
matlabbatch{10}.spm.stats.fmri_spec.sess(2).multi = {'/projects/sanlab/shared/PROP/PROP_scripts/fMRI/fx/multiconds/standard/PROP001_run2_CBT_v_PST'};
matlabbatch{10}.spm.stats.fmri_spec.sess(2).regress = struct('name', {}, 'val', {});
matlabbatch{10}.spm.stats.fmri_spec.sess(2).multi_reg = {'/projects/sanlab/shared/PROP/PROP_scripts/fMRI/fx/motion/rp_txt/rp_001_1_PROP_2.txt'};
matlabbatch{10}.spm.stats.fmri_spec.sess(2).hpf = 128;
matlabbatch{10}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
matlabbatch{10}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
matlabbatch{10}.spm.stats.fmri_spec.volt = 1;
matlabbatch{10}.spm.stats.fmri_spec.global = 'None';
matlabbatch{10}.spm.stats.fmri_spec.mthresh = -Inf;
matlabbatch{10}.spm.stats.fmri_spec.mask = {'/projects/sanlab/shared/PROP/bids_data/derivatives/fmriprep/sub-001/ses-wave1/func/sub-001_ses-1_task-PROP1_bold_space-T1w_brainmask.nii.gz'};
matlabbatch{10}.spm.stats.fmri_spec.cvi = 'AR(1)';
