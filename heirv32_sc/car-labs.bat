::==============================================================================
:: car-labs.bat
::   Starts HDL designer based on the generic hdlDesigner.bat
::
@echo off

::%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:: TO BE MODIFIED
::%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:: Define environment variables to be modified
:: You can change one or more values as needed
::
set VERBOSE=1

:: Define required Tools to be present
set REQUIRE_LIBS=1
set REQUIRE_HDS=1
set REQUIRE_MODELSIM=1
set REQUIRE_DIAMOND=1

:: Set project name
set design_name=car-labs

:: Manually override Library & Tools Folder location
::set HEI_LIBS_DIR=R:\SYND\Ele_2131\ELN\Labs\Libraries

::set HDS_HOME=C:\eda\MentorGraphics\HDS
::set MODELSIM_HOME=C:\eda\MentorGraphics\Modelsim\win64
::set ISE_VERSION=14.7
::set ISE_HOME=C:\eda\Xilinx\%ISE_VERSION%\ISE_DS\ISE
::set LIBERO_HOME=C:\eda\Microsemi\Libero

::set SCRATCH_DIR=C:\temp\eda\%username%
::
::%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

::------------------------------------------------------------------------------
:: Static environment variables
::
set SEPARATOR="--------------------------------------------------------------------------------"
set INDENT="  "
set design_directory=%~dp0
::remove trailing backslash
if %design_directory:~-1%==\ set design_directory=%design_directory:~0,-1%
pushd %design_directory%
set hdl_script_name="%design_directory:"=%\Scripts\hdlDesigner.bat"

::------------------------------------------------------------------------------
:: Main script
::
if %VERBOSE% == 1 (
  echo "%SEPARATOR:"=%"
  echo "-- HDL Designer Poject"
  echo "%INDENT:"=%Design name         is %design_name:"=%"
  echo "%INDENT:"=%Start directory     is %design_directory:"=%"
  echo "%INDENT:"=%HDL designer script is %hdl_script_name:"=%"
  echo.
)

::------------------------------------------------------------------------------
:: Launch application
::
if %VERBOSE% == 1 (
  set command=%hdl_script_name% -v -n %design_name% -d %design_directory%
) else (
  set command=%hdl_script_name% -n %design_name% -d %design_directory%
)
echo "Launch HDL Designer Script"
echo "%INDENT:"=%%command:"=%"
echo.
call %command%

:end
popd
echo.&goto:eof
