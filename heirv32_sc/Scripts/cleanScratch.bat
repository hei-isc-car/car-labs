::==============================================================================
:: cleanScratch.bat
:: Clean scratch directory
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
:: Delete scratch directory
::
if "%SCRATCH_DIR%" == "" (
  set SCRATCH_DIR=C:\temp\eda\
)

echo Delete scratch directory %SCRATCH_DIR%
if exist %SCRATCH_DIR% (
  echo    Scratch directory found, deleting!
  rmdir /S /Q "%SCRATCH_DIR%"
) else (
  echo    Scratch directory not found!
)

:end
  echo.
  echo "-- %~nx0 Finished!"
  echo %SEPARATOR%
  popd
  endlocal
  goto:eof