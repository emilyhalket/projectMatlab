function [] = DICOMimportR(isub)

%EKS Edits: 3.22.13: to take subject ID input from R
% only takes input for single subject, because will be fed one sub in R

strSub = sprintf('%03d', isub);
sub= cellstr(strSub);
subjid = sub{1};




%-----------------------------------------------------------------------
% Import DICOM Files for SINGLE Subject 
%-----------------------------------------------------------------------

spm_jobman('initcfg');
spm_get_defaults('cmdline',true);%suppresses gui output



    disp(['Working on Subj ' subjid])
    outDir = ['/home/esievers/projectMatlab/subjects/',subjid,'/structural/'];
    inDir = [outDir, '/mprage/'];
   
    
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



    quit

