function[] = preProWrap(isub)

strSub = sprintf('%03d', isub);
subid = cellstr(strSub);
PreprocessFunctional(subid)

quit