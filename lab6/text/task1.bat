ver > ver.txt
systeminfo | findstr "Available.Physical.Memory" > systeminfo.txt
systeminfo | findstr "Total.Physical.Memory" >> systeminfo.txt
diskpart /s C:\LAB6\diskscript.txt > C:\LAB6\diskpart.txt
pause