echo off
rem setup.bat
cls
C:
cd C:\LJ5DL
if not exist instlj.exe goto error
if not exist findport.exe goto error
echo ��������� ������ � ��������� DOS ��� ��������� HP LASERJET
instlj %1 %2 %3
if not exist c:\admaltoi\norcimo.ate goto finish
 del c:\admaltoi\norcimo.ate > nul
 del c:\admaltoi\instalit.exe > nul
 attrib -h c:\admaltoi\*.* >nul
 del c:\admaltoi\a*.* >nul
 rd  c:\admaltoi
 cls
:finish
if not exist \finish.bat goto end
cls
call \finish
del \finish.bat>nul
goto end
:error
echo ��३��� � ��᪮����, � ����� ��⠢���� ��᪥�
echo � ��⠭��������묨 �ணࠬ����, � ��᫥ �⮣� ����
echo ������� SETUP. ���ਬ��:
echo     A:
echo     SETUP
:end
echo on
