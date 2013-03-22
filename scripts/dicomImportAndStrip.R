# take in subject ID(s) and use matlab-SPM to perform dicom import 
# then use FSL to skull strip

# outputs brain,mask,overlay images to be ac/pc aligned(manually)


dicomImportAndStrip = function(subID){
  
  
  # Call DICOMimportR.m (matlab) - indirectly 
  
  cmd <- sprintf('matlab -nodesktop -r "DICOMimportR(%s)" ',subID)
  system(cmd)
  
  # rename output file
  
  cmd2 <- sprintf('mv /home/esievers/projectMatlab/subjects/%s/structural/*.nii ../subjects/%s/structural/%s_mprage.nii', subID, subID, subID)
  system(cmd2)
  
  
  # Call FSL to skull strip (shell-fsl) ; use shell script skullStrip.sh
  # Note this function strips, copies images to be AC/PC aligned, and unzips .gz
  
  
  cmd3 <- sprintf('sh skullStrip.sh %s', subID)
  system(cmd3)
  

  
}



