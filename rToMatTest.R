rToMatTest = function(subID){
  cmd <- sprintf('/Applications/MATLAB_R2011a.app/bin/matlab -nodesktop -r "subTestWrap(%s)" ',subID)
  system(cmd)
  #return(cmd)
}





