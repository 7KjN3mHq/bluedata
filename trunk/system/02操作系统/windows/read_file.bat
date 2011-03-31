@echo off
set filename=test.txt

for /f %opt% %%i in (%filename%) do (
echo %%i
)

pause;