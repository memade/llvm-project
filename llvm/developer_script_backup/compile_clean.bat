del *.opt /s /q /f
del *.positions /s /q /f
del *.sdf /s /q /f
del *.old /s /q /f
del *.tlog /s /q /f
del *.obj /s /q /f
del *.ncb /s /q /f
del *.plg /s /q /f

del *.user /s /q /f
del *.log /s /q /f
del *.pch /s /q /f

del *.sbr /s /q /f
del *.suo /s /q /f
del *.asp /s /q /f
del *.aps /s /q /f
del *.ilk /s /q /f
del *.idb /s /q /f
del *.~* /s /q /f
del *.bsc /s /q /f


del *.xslt /s /q /f
del *.ipch /s /q /f
del *.aps /s /q /f
del *.clw /s /q /f
del *.RH /s /q /f

rem rd /s /q objs

del *.vcxproj /s /q /f
del *.vcxproj.filters /s /q /f
del *.cmake /s /q /f
del *.txt /s /q /f
del *.stamp /s /q /f
del *.args /s /q /f
del *.cfg /s /q /f
del *.modulemap /s /q /f
del *.recipe /s /q /f
del *.vers /s /q /f
del *.bin /s /q /f
del *.check_cache /s /q /f
del *.list /s /q /f
del *.in /s /q /f
del *.lastbuildstate /s /q /f
del *.py /s /q /f
del *.configured /s /q /f
del *.stamp.depend /s /q /f
del *.txt /s /q /f
del *.rule /s /q /f
del *.pc /s /q /f
del *.spec /s /q /f
del *.sln /s /q /f

del *.iobj /s /q /f
del *.ipdb /s /q /f
rem del *.res /s /q /f
rem del *.inc /s /q /f
rem del *.pdb /s /q /f
rem del *.h /s /q /f
rem del *.c /s /q /f
rem del *.cc /s /q /f
rem del *.o /s /q /f
rem del *.def /s /q /f
rem del *.gen /s /q /f
rem del *.td /s /q /f
rem del *.cpp /s /q /f

rd /s /q CMakeFiles
rd /s /q /f /ah  .vs

rem delete current directory empty folder.
for /f "delims=" %%a in ('dir . /b /ad /s ^|sort /r' ) do rd /q "%%a" 2>nul


rem rem delete 'debug' folder.
rem for /f "delims=" %%i in ('dir /s/b/ad debug*') do (
rem rd /s/q "%%~i"
rem )