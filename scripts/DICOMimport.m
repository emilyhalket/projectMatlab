function [] = DICOMimport(subjids)

%-----------------------------------------------------------------------
% Import DICOM Files for All Subjects
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
    inDir = [outDir, '/mprage/'];
   % scriptDir = ['/data/fmri/gesture/data/SPM8/analysis/scripts/'];
   % cd(scriptDir);  %change to where script is 
    
    clear matlabbatch
    
    a = spm_select('FPList', inDir,'^0.*\.dcm$');    %read in all the .dcm files
    filesa = cellstr(a);
    matlabbatch{1}.spm.util.dicom.data = filesa;
    matlabbatch{1}.spm.util.dicom.root = 'flat';
    matlabbatch{1}.spm.util.dicom.outdir = {outDir};
    matlabbatch{1}.spm.util.dicom.convopts.format = 'nii';
    matlabbatch{1}.spm.util.dicom.convopts.icedims = 0;

    %matlabbatch = dicom_import_job;
    save([outDir,subjid,'_import.mat'],'matlabbatch');
    spm_jobman('serial', [outDir,subjid,'_import.mat'], matlabbatch);

%     cd (outDir);
%     
%     oldfile = dir('s*.nii');
%     oldfilename = [oldfile(1).name];
%     newfile = strcat(subjid, '_mprage.nii');
%     newfilename = newfile{1};
%     movefile(oldfilename,newfilename);
 
end
    

% 
% 
% matlabbatch{1}.spm.util.dicom
% 
% ans = 
% 
%         data: {208x1 cell}
%         root: 'flat'
%       outdir: {'/data/fmri/nNTRI/pSPM8/Mag/228/mprage/'}
%     convopts: [1x1 struct]

% data:  '/data/fmri/nNTRI/pSPM8/Mag/228/mprage/orig/0206.dcm'
%     '/data/fmri/nNTRI/pSPM8/Mag/228/mprage/orig/0207.dcm'
%     '/data/fmri/nNTRI/pSPM8/Mag/228/mprage/orig/0208.dcm'

% 
% 
% matlabbatch{1}.spm.util.dicom.outdir
% ans = 
%     '/data/fmri/nNTRI/pSPM8/Mag/228/mprage/'
% 
%     
% matlabbatch{1}.spm.util.dicom.convopts
% ans = 
%      format: 'nii'
%     icedims: 0
%     
% 
% 1) set path of input
% 2) set path of output
% 3) set variables you need
% 4) save and run