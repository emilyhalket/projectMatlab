rToMatTest = function(subID){
  cmd <- sprintf('matlab -nodesktop -r "subTestWrap(%s)" ',subID)
  system(cmd)
  #return(cmd)
}





