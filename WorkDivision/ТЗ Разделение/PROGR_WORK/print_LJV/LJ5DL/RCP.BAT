echo off
cls
if exist C:\LJ5DL\rcp\rcp.exe goto run
echo "Программа Панель дистанционного управления не установлена."
echo "Чтобы установить эту программу, необходимо запустить SETUP."
pause
goto :end
:run
C:\LJ5DL\rcp\rcp %1 %2 %3 %4 %5 %6 %7 %8 %9
:end
