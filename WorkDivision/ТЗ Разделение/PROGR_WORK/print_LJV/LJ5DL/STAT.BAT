echo off
if exist C:\LJ5DL\status\stat.exe goto run
cls
echo "�ணࠬ�� ������ ���ﭨ� �ਭ�� �� ��⠭������."
echo "�⮡� ��⠭����� ��� �ணࠬ��, ����室��� �������� SETUP."
pause
goto :end
:run
C:\LJ5DL\status\stat %1 %2 %3 %4 %5 %6 %7 %8 %9
:end
