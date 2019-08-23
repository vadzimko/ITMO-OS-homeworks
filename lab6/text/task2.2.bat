set "FILENAME=commands.txt"
FOR %%f IN (*) DO XCOPY .\"%%f" .\text\ /m /y
pause