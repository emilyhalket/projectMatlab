rToMatPPtest = function(subID){
  cmd <- sprintf('matlab -nodesktop -r "preProWrap(%s)" ',subID)
  system(cmd)
  #return(cmd)
}





