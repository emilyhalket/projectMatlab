function [] = PreprocessFunctR(subjids)


%EKS EDITS: 3.21.13 - changed to test with R/parallel
%EKS EDITS: 3.1.13 - changed regular expression to select correct scans

%-----------------------------------------------------------------------
% Perform preprocessing of functional data for All Subjects
%-----------------------------------------------------------------------
% input subject ids, e.g.:
%      subjids = {'0103' '0108' '0109'}; 


spm_jobman('initcfg');
spm_get_defaults('cmdline',true);%suppresses gui output

x = numel(subjids);
for i=1:x;
    subjid = subjids{i}; 
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
    
    matlabbatch{1}.spm.temporal.st.scans = {datafiles};
    matlabbatch{1}.spm.temporal.st.nslices = 36;
matlabbatch{1}.spm.temporal.st.tr = 2;
matlabbatch{1}.spm.temporal.st.ta = 1.94444444444444;
matlabbatch{1}.spm.temporal.st.so = [2 4 6 8 10 12 14 16 18 20 22 24 26 28 30 32 34 36 1 3 5 7 9 11 13 15 17 19 21 23 25 27 29 31 33 35];
matlabbatch{1}.spm.temporal.st.refslice = 36;
matlabbatch{1}.spm.temporal.st.prefix = 'a';
matlabbatch{2}.spm.spatial.realignunwarp.data.scans(1) = cfg_dep;
matlabbatch{2}.spm.spatial.realignunwarp.data.scans(1).tname = 'Images';
matlabbatch{2}.spm.spatial.realignunwarp.data.scans(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{2}.spm.spatial.realignunwarp.data.scans(1).tgt_spec{1}(1).value = 'image';
matlabbatch{2}.spm.spatial.realignunwarp.data.scans(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{2}.spm.spatial.realignunwarp.data.scans(1).tgt_spec{1}(2).value = 'e';
matlabbatch{2}.spm.spatial.realignunwarp.data.scans(1).sname = 'Slice Timing: Slice Timing Corr. Images (Sess 1)';
matlabbatch{2}.spm.spatial.realignunwarp.data.scans(1).src_exbranch = substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{2}.spm.spatial.realignunwarp.data.scans(1).src_output = substruct('()',{1}, '.','files');
matlabbatch{2}.spm.spatial.realignunwarp.data.pmscan = '';
matlabbatch{2}.spm.spatial.realignunwarp.eoptions.quality = 0.9;
matlabbatch{2}.spm.spatial.realignunwarp.eoptions.sep = 4;
matlabbatch{2}.spm.spatial.realignunwarp.eoptions.fwhm = 5;
matlabbatch{2}.spm.spatial.realignunwarp.eoptions.rtm = 0;
matlabbatch{2}.spm.spatial.realignunwarp.eoptions.einterp = 4;
matlabbatch{2}.spm.spatial.realignunwarp.eoptions.ewrap = [0 1 0];
matlabbatch{2}.spm.spatial.realignunwarp.eoptions.weight = '';
matlabbatch{2}.spm.spatial.realignunwarp.uweoptions.basfcn = [12 12];
matlabbatch{2}.spm.spatial.realignunwarp.uweoptions.regorder = 1;
matlabbatch{2}.spm.spatial.realignunwarp.uweoptions.lambda = 100000;
matlabbatch{2}.spm.spatial.realignunwarp.uweoptions.jm = 0;
matlabbatch{2}.spm.spatial.realignunwarp.uweoptions.fot = [4 5]; 
matlabbatch{2}.spm.spatial.realignunwarp.uweoptions.sot = [];
matlabbatch{2}.spm.spatial.realignunwarp.uweoptions.uwfwhm = 4;
matlabbatch{2}.spm.spatial.realignunwarp.uweoptions.rem = 1;
matlabbatch{2}.spm.spatial.realignunwarp.uweoptions.noi = 5;
matlabbatch{2}.spm.spatial.realignunwarp.uweoptions.expround = 'Average';
matlabbatch{2}.spm.spatial.realignunwarp.uwroptions.uwwhich = [2 1];
matlabbatch{2}.spm.spatial.realignunwarp.uwroptions.rinterp = 4;
matlabbatch{2}.spm.spatial.realignunwarp.uwroptions.wrap = [0 0 0];
matlabbatch{2}.spm.spatial.realignunwarp.uwroptions.mask = 1;
matlabbatch{2}.spm.spatial.realignunwarp.uwroptions.prefix = 'u';
matlabbatch{3}.spm.spatial.coreg.estimate.ref = refImage;
matlabbatch{3}.spm.spatial.coreg.estimate.source(1) = cfg_dep;
matlabbatch{3}.spm.spatial.coreg.estimate.source(1).tname = 'Source Image';
matlabbatch{3}.spm.spatial.coreg.estimate.source(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.spatial.coreg.estimate.source(1).tgt_spec{1}(1).value = 'image';
matlabbatch{3}.spm.spatial.coreg.estimate.source(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.spatial.coreg.estimate.source(1).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.spatial.coreg.estimate.source(1).sname = 'Realign & Unwarp: Unwarped Mean Image';
matlabbatch{3}.spm.spatial.coreg.estimate.source(1).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.spatial.coreg.estimate.source(1).src_output = substruct('.','meanuwr');
matlabbatch{3}.spm.spatial.coreg.estimate.other(1) = cfg_dep;
matlabbatch{3}.spm.spatial.coreg.estimate.other(1).tname = 'Other Images';
matlabbatch{3}.spm.spatial.coreg.estimate.other(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{3}.spm.spatial.coreg.estimate.other(1).tgt_spec{1}(1).value = 'image';
matlabbatch{3}.spm.spatial.coreg.estimate.other(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{3}.spm.spatial.coreg.estimate.other(1).tgt_spec{1}(2).value = 'e';
matlabbatch{3}.spm.spatial.coreg.estimate.other(1).sname = 'Realign & Unwarp: Unwarped Images (Sess 1)';
matlabbatch{3}.spm.spatial.coreg.estimate.other(1).src_exbranch = substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{3}.spm.spatial.coreg.estimate.other(1).src_output = substruct('.','sess', '()',{1}, '.','uwrfiles');
matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
matlabbatch{3}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
matlabbatch{4}.spm.spatial.normalise.write.subj.matname = normParam;
matlabbatch{4}.spm.spatial.normalise.write.subj.resample(1) = cfg_dep;
matlabbatch{4}.spm.spatial.normalise.write.subj.resample(1).tname = 'Images to Write';
matlabbatch{4}.spm.spatial.normalise.write.subj.resample(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{4}.spm.spatial.normalise.write.subj.resample(1).tgt_spec{1}(1).value = 'image';
matlabbatch{4}.spm.spatial.normalise.write.subj.resample(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{4}.spm.spatial.normalise.write.subj.resample(1).tgt_spec{1}(2).value = 'e';
matlabbatch{4}.spm.spatial.normalise.write.subj.resample(1).sname = 'Coregister: Estimate: Coregistered Images';
matlabbatch{4}.spm.spatial.normalise.write.subj.resample(1).src_exbranch = substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{4}.spm.spatial.normalise.write.subj.resample(1).src_output = substruct('.','cfiles');
matlabbatch{4}.spm.spatial.normalise.write.roptions.preserve = 0;
matlabbatch{4}.spm.spatial.normalise.write.roptions.bb = [-78 -112 -50
                                                          78 76 85];
matlabbatch{4}.spm.spatial.normalise.write.roptions.vox = [2 2 2];
matlabbatch{4}.spm.spatial.normalise.write.roptions.interp = 4;
matlabbatch{4}.spm.spatial.normalise.write.roptions.wrap = [0 0 0];
matlabbatch{4}.spm.spatial.normalise.write.roptions.prefix = 'w';
matlabbatch{5}.spm.spatial.smooth.data(1) = cfg_dep;
matlabbatch{5}.spm.spatial.smooth.data(1).tname = 'Images to Smooth';
matlabbatch{5}.spm.spatial.smooth.data(1).tgt_spec{1}(1).name = 'filter';
matlabbatch{5}.spm.spatial.smooth.data(1).tgt_spec{1}(1).value = 'image';
matlabbatch{5}.spm.spatial.smooth.data(1).tgt_spec{1}(2).name = 'strtype';
matlabbatch{5}.spm.spatial.smooth.data(1).tgt_spec{1}(2).value = 'e';
matlabbatch{5}.spm.spatial.smooth.data(1).sname = 'Normalise: Write: Normalised Images (Subj 1)';
matlabbatch{5}.spm.spatial.smooth.data(1).src_exbranch = substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1});
matlabbatch{5}.spm.spatial.smooth.data(1).src_output = substruct('()',{1}, '.','files');
matlabbatch{5}.spm.spatial.smooth.fwhm = [5 5 5];
matlabbatch{5}.spm.spatial.smooth.dtype = 0;
matlabbatch{5}.spm.spatial.smooth.im = 0;
matlabbatch{5}.spm.spatial.smooth.prefix = 's';


 %matlabbatch = preprocess;
    save([functDir,subjid,'_preprocess.mat'],'matlabbatch');
    spm_jobman('serial', [functDir,subjid,'_preprocess.mat'], matlabbatch);

%     
 
end




