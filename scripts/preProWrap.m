function[] = preProWrap(isub)

% changed to call updated preprocessing function 'functR' that has 
% updated directory information 
strSub = sprintf('%03d', isub);
subid = cellstr(strSub);
PreprocessFunctR(subid)

quit