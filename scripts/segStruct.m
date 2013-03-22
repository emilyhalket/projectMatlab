
function [] = segStruct(subjids)

%-----------------------------------------------------------------------
% Perform structural segmentation for All Subjects
%-----------------------------------------------------------------------
% input subject ids, e.g.:
%      subjids = {'0103' '0108' '0109'}; 
spm_jobman('initcfg');
spm_get_defaults('cmdline',true);%suppresses gui output

x = numel(subjids);
for i=1:x;
    subjid = subjids{i}; 
    disp(['Working on Subj ' subjid])
    outDir = ['/data/fmri/gesture/data/SPM8/',subjid,'/structural/'];
   % scriptDir = ['/data/fmri/gesture/data/SPM8/analysis/scripts/'];
   % cd(scriptDir);  %change to where script is 
    
    clear matlabbatch
    datafilesA = [outDir,subjid,'_mprage_brain_ac.nii,1'];
        datafiles = cellstr(datafilesA);
    disp(['datafile is ' datafiles])
    matlabbatch{1}.spm.spatial.preproc.data = datafiles;
matlabbatch{1}.spm.spatial.preproc.output.GM = [0 0 1];
matlabbatch{1}.spm.spatial.preproc.output.WM = [0 0 1];
matlabbatch{1}.spm.spatial.preproc.output.CSF = [0 0 1];
matlabbatch{1}.spm.spatial.preproc.output.biascor = 1;
matlabbatch{1}.spm.spatial.preproc.output.cleanup = 0;
matlabbatch{1}.spm.spatial.preproc.opts.tpm = {
                                               '/data/fmri/SPM8/tpm/grey.nii'
                                               '/data/fmri/SPM8/tpm/white.nii'
                                               '/data/fmri/SPM8/tpm/csf.nii'
                                               };
matlabbatch{1}.spm.spatial.preproc.opts.ngaus = [2
                                                 2
                                                 2
                                                 4];
matlabbatch{1}.spm.spatial.preproc.opts.regtype = 'mni';
matlabbatch{1}.spm.spatial.preproc.opts.warpreg = 1;
matlabbatch{1}.spm.spatial.preproc.opts.warpco = 25;
matlabbatch{1}.spm.spatial.preproc.opts.biasreg = 0.0001;
matlabbatch{1}.spm.spatial.preproc.opts.biasfwhm = 60;
matlabbatch{1}.spm.spatial.preproc.opts.samp = 3;
matlabbatch{1}.spm.spatial.preproc.opts.msk = {''};

    
    %matlabbatch = segStruct;
    save([outDir,subjid,'_seg.mat'],'matlabbatch');
    spm_jobman('serial', [outDir,subjid,'_seg.mat'], matlabbatch);

%     
 
end
