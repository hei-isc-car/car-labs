::==============================================================================
:: hdl_designer.bash - Starts HDL designer
::
:start
  setlocal EnableExtensions EnableDelayedExpansion
  set cmd_location=%~dp0
  pushd %cmd_location%
  set SEPARATOR="--------------------------------------------------------------------------------"
  set INDENT="  "

  echo %SEPARATOR%
  echo "-- %~nx0 Started!"
  echo.

:: -----------------------------------------------------------------------------
:: Define default environment variables
::
::remove trailing backslash
if %cmd_location:~-1%==\ set design_directory=%design_directory:~0,-1%

set design_name=%~n0
set hpd_name=hds

if "%ISE_VERSION%"== "" (
  set ISE_VERSION=14.7
)
set prefs_directory="%design_directory:"=%\Prefs"
set library_matchings="%hpd_name%.hdp"
set simulation_directory="%design_directory:"=%\Simulation"
set user_prefs_directory="%prefs_directory:"=%\hds_user"
set team_prefs_directory="%prefs_directory:"=%\hds_team"
if "%SCRATCH_DIR%" == "" (
  set scratch_directory=C:\temp\eda\%username%
) else (
  set scratch_directory=%SCRATCH_DIR%
)

set synthesis_subdirectory=""
if %REQUIRE_ISE% == 1 (
  set synthesis_subdirectory="Board\ise"
)
if %REQUIRE_LIBERO% == 1 (
  set synthesis_subdirectory="Board\libero"
)
set concat_directory="%design_directory:"=%\Board\concat"

::------------------------------------------------------------------------------
:: Parse command line options
::
:parse
set usage1="Usage: hdl_designer.bat [-v] [-h]"
set usage2="                        [-n designName] [-d designDirectory]"
set usage3="                        [-p prefsDirectory] [-u userPrefsDirectory] [-t teamPrefsDirectory]"
set usage4="                        [-s scratchDirectory] [-c concatDirectory]"
set usage5="                        [-y synthesisDirectory] [-m library_matchings]"

echo "Search Commandline Parameters"
:parseloop
if not "%1"=="" (
    if "%1"=="-v" (
        set VERBOSE=1
        echo "%INDENT:"=%verbose enabled"
        shift
    )
    if "%1"=="-h" (
        goto :HELP
        shift
    )
    if "%1"=="-n" (
        set design_name=%2
        echo "%INDENT:"=%design_name=!design_name:"=! "
        shift & shift
    )
    if "%1"=="-d" (
        set design_directory=%2
        echo "%INDENT:"=%design_directory=!design_directory:"=! "
        shift & shift
    )
    if "%1"=="-p" (
        set prefs_directory=%2
        echo "%INDENT:"=%prefs_directory=!prefs_directory:"=! "
        shift & shift
    )
    if "%1"=="-u" (
        set user_prefs_directory=%2
        echo "%INDENT:"=%user_prefs_directory=%user_prefs_directory:"=% "
        shift & shift
    )
    if "%1"=="-t" (
        set team_prefs_directory=%2
        echo "%INDENT:"=%team_prefs_directory=%team_prefs_directory:"=% "
        shift & shift
    )
    if "%1"=="-s" (
        set scratch_directory=%2
        echo "%INDENT:"=%scratch_directory=%scratch_directory:"=% "
        shift & shift
    )
    if "%1"=="-c" (
        set concat_directory=%2
        echo "%INDENT:"=%concat_directory=%concat_directory:"=% "
        shift & shift
    )
    if "%1"=="-y" (
        set synthesis_subdirectory=%2
        echo "%INDENT:"=%synthesis_subdirectory=%synthesis_subdirectory:"=% "
        shift & shift
    )
    if "%1"=="-m" (
        set set library_matchings="%2.hdp"
        echo "%INDENT:"=%library_matchings=%library_matchings:"=% "
        shift & shift
    )
    goto :parseloop
)
echo.

:: Setting all concurrent variables
set prefs_directory="!design_directory:"=!\Prefs"
set user_prefs_directory="!prefs_directory:"=!\hds_user"
set team_prefs_directory="!prefs_directory:"=!\hds_team"
set library_matchings=!prefs_directory:"=!\!library_matchings:"=!
set simulation_directory="!design_directory:"=!\Simulation"
set concat_directory="!design_directory:"=!\Board\concat"

:: Getting realpath
:: TODO

:: create scratch dir
if not exist "%scratch_directory%" (
  mkdir "%scratch_directory:"=%"
)

::================================================================================
:: Main script
::
call "./searchPaths.bat"

::------------------------------------------------------------------------------
:: Project environment variables
::
set DESIGN_NAME=%design_name:"=%
set HDS_LIBS=%library_matchings:"=%
set HDS_USER_HOME=%user_prefs_directory:"=%
set HDS_TEAM_HOME=%team_prefs_directory:"=%
set SIMULATION_DIR=%simulation_directory:"=%
:: Changing Slashed (Needed for Modelsim)
set SIMULATION_DIR=%SIMULATION_DIR:\=/%
set SCRATCH_DIR=%scratch_directory:"=%
set CONCAT_DIR=%concat_directory:"=%
set ISE_BASE_DIR=%design_directory:"=%\%synthesis_subdirectory:"=%
set ISE_WORK_DIR=%scratch_directory:"=%\%DESIGN_NAME:"=%\%synthesis_subdirectory:"=%
set LIBERO_BASE_DIR=%design_directory:"=%\%synthesis_subdirectory:"=%
set LIBERO_WORK_DIR=%scratch_directory:"=%\%DESIGN_NAME:"=%\%synthesis_subdirectory:"=%

::------------------------------------------------------------------------------
:: Display info
::
if !VERBOSE! == 1 (
  echo "Program Parameters"
  echo "%INDENT:"=%DESIGN_NAME     is %DESIGN_NAME:"=%"
  echo "%INDENT:"=%HEI_LIBS_DIR    is %HEI_LIBS_DIR:"=%"
  echo "%INDENT:"=%HDS_LIBS        is %HDS_LIBS:"=%"
  echo "%INDENT:"=%SIMULATION_DIR  is %SIMULATION_DIR:"=%"
  echo "%INDENT:"=%HDS_USER_HOME   is %HDS_USER_HOME:"=%"
  echo "%INDENT:"=%HDS_TEAM_HOME   is %HDS_TEAM_HOME:"=%"
  echo "%INDENT:"=%SCRATCH_DIR     is %SCRATCH_DIR:"=%"
  echo "%INDENT:"=%CONCAT_DIR      is %CONCAT_DIR:"=%"
  if %REQUIRE_HDS% == 1 (
    echo "%INDENT:"=%HDS_HOME        is %HDS_HOME:"=%"
  )
  if %REQUIRE_MODELSIM% == 1 (
    echo "%INDENT:"=%MODELSIM_HOME   is %MODELSIM_HOME:"=%"
  )
  if %REQUIRE_ISE% == 1 (
    echo "%INDENT:"=%ISE_HOME        is %ISE_HOME:"=%"
    echo "%INDENT:"=%ISE_BASE_DIR    is %ISE_BASE_DIR:"=%"
    echo "%INDENT:"=%ISE_WORK_DIR    is %ISE_WORK_DIR:"=%"
  )
  if %REQUIRE_LIBERO% == 1 (
    echo "%INDENT:"=%LIBERO_HOME     is %LIBERO_HOME:"=%"
    echo "%INDENT:"=%LIBERO_BASE_DIR is %LIBERO_BASE_DIR:"=%"
    echo "%INDENT:"=%LIBERO_WORK_DIR is %LIBERO_WORK_DIR:"=%"
  )
  echo.
)

::------------------------------------------------------------------------------
:: Delete scratch directory
::
call "./cleanScratch.bat"

::------------------------------------------------------------------------------
:: Copy synthesis data to scratch directory
::
if %REQUIRE_ISE% == 1 (
  if exist %ISE_BASE_DIR% (
    echo "%ISE_BASE_DIR:"=%"
    echo "  -> %ISE_WORK_DIR:"=%"
    if exist %ISE_WORK_DIR% (
      rmdir /S /Q "%ISE_WORK_DIR%"
    )
    mkdir "%ISE_WORK_DIR%"
    xcopy /Y "%ISE_BASE_DIR%" "%ISE_WORK_DIR%\"
  )
)

if %REQUIRE_LIBERO% == 1 (
  if exist %LIBERO_BASE_DIR% (
    echo "%LIBERO_BASE_DIR:"=%"
    echo "  -> %LIBERO_BASE_DIR:"=%"
    if exist %LIBERO_WORK_DIR% (
      rmdir /S /Q "%LIBERO_WORK_DIR%"
    )
    mkdir "%LIBERO_WORK_DIR%"
    xcopy /S /Y "%LIBERO_BASE_DIR%" "%LIBERO_WORK_DIR%\"
  )
)

::------------------------------------------------------------------------------
:: Launch application
::
echo "%SEPARATOR:"=%"
echo "-- Launching program"
echo "%INDENT:"=%Waiting until programs finished..."
echo "-- Finished... YOU CAN CLOSE THIS WINDOW NOW!"
::start /wait !HDS_HOME:"=!\bin\hdldesigner.exe
%windir%\system32\cmd.exe /c start /wait !HDS_HOME!\bin\hdldesigner.exe
echo "%SEPARATOR:"=%"

:end
  popd
  endlocal
  pause&goto:eof

::------------------------------------------------------------------------------
:: Helper Functions
::
:HELP
  echo.
  echo %usage1:"=%
  echo %usage2:"=%
  echo %usage3:"=%
  echo %usage4:"=%
  echo %usage5:"=%
  echo.&pause&goto:eof
