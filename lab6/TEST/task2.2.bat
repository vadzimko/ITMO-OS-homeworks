FOR %%f IN (*) DO 
REM	if ~z.\"%%f" gtr 300
	if exist .\"%%f" XCOPY .\"%%f" .\text\
pause