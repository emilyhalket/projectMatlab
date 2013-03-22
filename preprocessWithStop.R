#segstruct AC/PC aligned brains
#begin funtional preprocessing: realign 
#check movement parameters to decide whether or not to continue preprocessing

#if bad movement then alert user, stop preprocessing, plot movement

#if OK movement call further preprocessing function


preprocessWithStop = function(subID){
  
  #segment structural images, slice time functiotional, realign functional 
  curDir <- getwd()
  cmd <- sprintf('matlab -nodesktop -r "segStructSTRealignR(%s)" ',subID)
  system(cmd)
  
  #examine movement parameters
  
  newWD <- sprintf('/home/esievers/projectMatlab/subjects/%s', subID)
  setwd(newWD)
  
  newName <- sprintf('cp /functional/data_4_analysis/ges_01/rp* ./%s_movement.txt', subID)
  
  mvmt <- read.table(sprintf('%s_movement.txt'), subID)
  
  if (apply(mvmt,2,min) < -3.4 | apply(mvmt,2,max) > 3.4){
    stop("movement exceeds thresholds, examine movement parameters")
    
  }
  
  else
  
}