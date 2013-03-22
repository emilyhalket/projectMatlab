function subTest(subid)

sub = subid{1};
 
d = datestr(now, 'HH:MM:SS');

sprintf('Subject: %s at %s \n', sub, d)

%quit