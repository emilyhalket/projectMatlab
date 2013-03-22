function [] = coregNormSmoothR(isub)


strSub = sprintf('%03d', isub);
sub= cellstr(strSub);
subjid = sub{1};

%-----------------------------------------------------------------------
% Perform rest of functional preprocessing following movement clearance
%-----------------------------------------------------------------------



spm_jobman('initcfg');
spm_get_defaults('cmdline',true);%suppresses gui output


    disp(['Working on Subj ' subjid])
    
    
    functDir = ['/home/esievers/projectMatlab/subjects/',subjid,'/functional/data_4_analysis/'];
    structDir = ['/home/esievers/projectMatlab/subjects/',subjid,'/structural/'];
   
    
    clear matlabbatch

    
    
    a = spm_select('FPList', fullfile(functDir, 'ges_01/'), '^0.*\.img$'); %read in all files from run 1
    b = spm_select('FPList', fullfile(functDir, 'ges_02/'), '^0.*\.img$'); %read in all files from run 2
    dataA = cellstr(a);
    dataB = cellstr(b);
    datafiles = [dataA; dataB];
    
    refImageA = [structDir,subjid,'_mprage_brain_ac.nii,1'];
    refImage = cellstr(refImageA);
    
    normParamA = [structDir,subjid,'_mprage_brain_ac_seg_sn.mat'];
    normParam = cellstr(normParamA);
    
    
matlabbatch{1}.spm.spatial.coreg.estimate.ref = refImage;
matlabbatch{1}.spm.spatial.coreg.estimate.source(1) = cfg_dep;
matlabbatch{1}.spm.spatial.coreg.estimate.source(1).tname = 'Source Image';
matlabbatch{1}.spm.spatial.coreg.estimate.source(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{1}.spm.spatial.coreg.estimate.source(1).tgt_spec{1}(1).value = 'image';
matlabbatch{1}.spm.spatial.coreg.estimate.source(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{1}.spm.spatial.coreg.estimate.source(1).tgt_spec{1}(2).value = 'e';
matlabbatch{1}.spm.spatial.coreg.estimate.source(1).sname = 'Realign & Unwarp: Unwarped Mean Image';
matlabbatch{1}.spm.spatial.coreg.estimate.source(1).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{1}.spm.spatial.coreg.estimate.source(1).src_output = substruct('.','meanuwr');
matlabbatch{1}.spm.spatial.coreg.estimate.other(1) = cfg_dep;
matlabbatch{1}.spm.spatial.coreg.estimate.other(1).tname = 'Other Images';
matlabbatch{1}.spm.spatial.coreg.estimate.other(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{1}.spm.spatial.coreg.estimate.other(1).tgt_spec{1}(1).value = 'image';
matlabbatch{1}.spm.spatial.coreg.estimate.other(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{1}.spm.spatial.coreg.estimate.other(1).tgt_spec{1}(2).value = 'e';
matlabbatch{1}.spm.spatial.coreg.estimate.other(1).sname = 'Realign & Unwarp: Unwarped Images (Sess 1)';
matlabbatch{1}.spm.spatial.coreg.estimate.other(1).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{1}.spm.spatial.coreg.estimate.other(1).src_output = substruct('.','sess', '()',{1}, '.','uwrfiles');
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{1}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];

matlabbatch{2}.spm.spatial.normalise.write.subj.matname = normParam;
matlabbatch{2}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep;
matlabbatch{2}.spm.spatial.normalise.write.subj.resample(1).tname = 'Images to Write';
matlabbatch{2}.spm.spatial.normalise.write.subj.resample(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.spatial.normalise.write.subj.resample(1).tgt_spec{1}(1).value = 'image';
matlabbatch{2}.spm.spatial.normalise.write.subj.resample(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.spatial.normalise.write.subj.resample(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.spatial.normalise.write.subj.resample(1).sname = 'Coregister: Estimate: Coregistered Images';
matlabbatch{2}.spm.spatial.normalise.write.subj.resample(1).src_exbranch = substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.spm.spatial.normalise.write.subj.resample(1).src_output = substruct('.','cfiles');
matlabbatch{2}.spm.spatial.normalise.write.roptions.preserve = 0;
matlabbatch{2}.spm.spatial.normalise.write.roptions.bb = [-78 -112 -50
                                                          78 76 85];
matlabbatch{2}.spm.spatial.normalise.write.roptions.vox = [2 2 2];
matlabbatch{2}.spm.spatial.normalise.write.roptions.interp = 4;
matlabbatch{2}.spm.spatial.normalise.write.roptions.wrap = [0 0 0];
matlabbatch{2}.spm.spatial.normalise.write.roptions.prefix = 'w';
matlabbatch{3}.spm.spatial.smooth.data(1) = cfg_dep;
matlabbatch{3}.spm.spatial.smooth.data(1).tname = 'Images to Smooth';
matlabbatch{3}.spm.spatial.smooth.data(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.spatial.smooth.data(1).tgt_spec{1}(1).value = 'image';
matlabbatch{3}.spm.spatial.smooth.data(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.spatial.smooth.data(1).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.spatial.smooth.data(1).sname = 'Normalise: Write: Normalised Images (Subj 1)';
matlabbatch{3}.spm.spatial.smooth.data(1).src_exbranch = substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.spatial.smooth.data(1).src_output = substruct('()',{1}, '.','files');
matlabbatch{3}.spm.spatial.smooth.fwhm = [5 5 5];
matlabbatch{3}.spm.spatial.smooth.dtype = 0;
matlabbatch{3}.spm.spatial.smooth.im = 0;
matlabbatch{3}.spm.spatial.smooth.prefix = 's';


 %matlabbatch = preprocess;
save([functDir,subjid,'_coreg_norm_smooth.mat'],'matlabbatch');
    spm_jobman('serial', [functDir,subjid,'_coreg_norm_smooth.mat'], matlabbatch);

%     
 



quit

