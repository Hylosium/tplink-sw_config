@echo off
set /P variable1=Escribe un num. del 1 al 999999:

IF "%variable1%"== "" (GOTO :hola) else (goto :adios)

:hola
echo HOLA
pause
exit


:adios
echo adios
pause
exit