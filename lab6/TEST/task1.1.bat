ver > ver.txt
systeminfo | findstr "Available.Physical.Memory" > systeminfo.txt
systeminfo | findstr "Total.Physical.Memory" >> systeminfo.txt
wmic LOGICALDISK GET DeviceId, VolumeName, Description, Size > wmic.txt
pause