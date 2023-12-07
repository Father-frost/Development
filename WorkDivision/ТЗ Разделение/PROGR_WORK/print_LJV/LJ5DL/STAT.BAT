echo off
if exist C:\LJ5DL\status\stat.exe goto run
cls
echo "Программа Монитор состояния принтера не установлена."
echo "Чтобы установить эту программу, необходимо запустить SETUP."
pause
goto :end
:run
C:\LJ5DL\status\stat %1 %2 %3 %4 %5 %6 %7 %8 %9
:end
