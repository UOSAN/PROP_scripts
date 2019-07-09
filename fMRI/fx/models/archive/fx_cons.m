%-----------------------------------------------------------------------
% Job saved on 19-Aug-2018 23:52:11 by cfg_util (rev $Rev: 6942 $)
% spm SPM - SPM12 (7219)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
matlabbatch{1}.spm.stats.fmri_est.spmmat = {'/projects/sanlab/shared/PROP/bids_data/derivatives/standard/fx/sub-001/SPM.mat'};
matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;
matlabbatch{2}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.con.consess{1}.tcon.name = 'cbt';
matlabbatch{2}.spm.stats.con.consess{1}.tcon.weights = [1 0 0 0];
matlabbatch{2}.spm.stats.con.consess{1}.tcon.sessrep = 'repl';
matlabbatch{2}.spm.stats.con.consess{2}.tcon.name = 'pst';
matlabbatch{2}.spm.stats.con.consess{2}.tcon.weights = [0 1 0 0];
matlabbatch{2}.spm.stats.con.consess{2}.tcon.sessrep = 'repl';
matlabbatch{2}.spm.stats.con.consess{3}.tcon.name = 'instrux';
matlabbatch{2}.spm.stats.con.consess{3}.tcon.weights = [0 0 1 0];
matlabbatch{2}.spm.stats.con.consess{3}.tcon.sessrep = 'repl';
matlabbatch{2}.spm.stats.con.consess{4}.tcon.name = 'rating';
matlabbatch{2}.spm.stats.con.consess{4}.tcon.weights = [0 0 0 1];
matlabbatch{2}.spm.stats.con.consess{4}.tcon.sessrep = 'repl';
matlabbatch{2}.spm.stats.con.consess{5}.tcon.name = 'cbt_pst';
matlabbatch{2}.spm.stats.con.consess{5}.tcon.weights = [1 -1 0 0];
matlabbatch{2}.spm.stats.con.consess{5}.tcon.sessrep = 'repl';
matlabbatch{2}.spm.stats.con.consess{6}.tcon.name = 'pst_cbt';
matlabbatch{2}.spm.stats.con.consess{6}.tcon.weights = [-1 1 0 0];
matlabbatch{2}.spm.stats.con.consess{6}.tcon.sessrep = 'repl';
matlabbatch{2}.spm.stats.con.delete = 0;
