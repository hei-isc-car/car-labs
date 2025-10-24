@echo off 

:data_sel
CLS
set dta_arg=
echo Bubble Sort - C version
echo     Data Selection
echo. 
echo 1. 20
echo 2. 1k
echo 3. 5k
echo 4. 10k
echo 5. 10k (sorted)
echo 6. 50k
echo 7. 50k (sorted)
echo 8. 100k
echo 0. Exit
echo.
set /p sel="Enter your choice: "
IF [%sel%] == [] goto data_sel
if %sel%==1 (
   set dta_arg=../../../data/20.txt
   goto sort
)
if %sel%==2 (
   set dta_arg=../../../data/1k.txt
   goto sort
)
if %sel%==3 (
   set dta_arg=../../../data/5k.txt
   goto sort
)
if %sel%==4 (
   set dta_arg=../../../data/10k.txt
   goto sort
)
if %sel%==5 (
   set dta_arg=../../../data/10k_sorted.txt
   goto sort
)
if %sel%==6 (
   set dta_arg=../../../data/50k.txt
   goto sort
)
if %sel%==7 (
   set dta_arg=../../../data/50k_sorted.txt
   goto sort
)
if %sel%==8 (
   set dta_arg=../../../data/100k.txt
   goto sort
)
if %sel%==0 (
   goto :EOF
)
goto data_sel

:sort
bubbleSort.exe %dta_arg%
pause