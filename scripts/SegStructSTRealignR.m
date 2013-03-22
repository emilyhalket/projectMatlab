function[]= SegStructSTRealignR(isub)

%---------------------------
% segment structural images
% realign functional images
% --------------------------
strSub = sprintf('%03d', isub);
sub= cellstr(strSub);
subjid = sub{1};


spm_jobman('initcfg');
spm_get_defaults('cmdline',true);%suppresses gui output


    
disp(['Working on Subj ' subjid])
outDir = ['/home/esievers/projectMatlab/',subjid,'/structural/'];
   
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

    
save([outDir,subjid,'_seg.mat'],'matlabbatch');
spm_jobman('serial', [outDir,subjid,'_seg.mat'], matlabbatch);


%----------------------slice time & realign-----------------------------------
spm_jobman('initcfg');
spm_get_defaults('cmdline',true);
  

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

save([functDir,subjid,'_stRealign.mat'],'matlabbatch');
    spm_jobman('serial', [functDir,subjid,'_stRealign.mat'], matlabbatch);

quit
