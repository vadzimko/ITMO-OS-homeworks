REM driverquery /FO TABLE > driverquery.txt
break > drivers.txt
for /f "tokens=1" %%a in ('driverquery /FO TABLE') do (
   if not "%%a" == "============" ( 
		if not "%%a" == "Module" (
			echo %%a >> drivers.txt
		)
	)
)
pause