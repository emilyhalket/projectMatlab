clc;
clear;
subids = {'800', '801','802','803'};
tic
t=cputime;
PreprocessFunctional(subids);
cpu_elapsed = cputime - t
toc_time = toc
