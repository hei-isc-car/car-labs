::==============================================================================
:: cleanGenerated.bat
:: Clean intermediate files from folder
::
:start
  @echo off
  setlocal
  set cmd_location="%~dp0"
  pushd %cmd_location%
  set SEPARATOR="--------------------------------------------------------------------------------"
  set INDENT="  "

  echo %SEPARATOR%
  echo "-- %~nx0 Started!"
  echo.
::------------------------------------------------------------------------------
:: Delete intermediate files
::
set base_directory="%cmd_location:"=%.."

echo "Delete intermediate files in: %base_directory%"
del /f /s /a %base_directory%\*cache.dat
del /f /s /a %base_directory%\*.bak
del /f /s /a %base_directory%\*.lck
del /f /s /a %base_directory%\*.vhd.info
del /f /s /a %base_directory%\default_view
del /f /s /a %base_directory%\*_entity.vhd
del /f /s /a %base_directory%\*_struct.vhd
del /f /s /a %base_directory%\*_fsm.vhd
del /f /s /a %base_directory%\*.vhg
del /f /s /a %base_directory%\*.DS_Store

echo "Delete intermediate directories in: %base_directory%"
for /d /r "%base_directory:"=%\" %%a in (.xrf\) do if exist "%%a" rmdir /s /q "%%a"

:end
  echo.
  echo "-- %~nx0 Finished!"
  echo %SEPARATOR%
  popd
  endlocal
  goto:eof