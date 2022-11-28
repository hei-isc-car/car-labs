::==============================================================================
:: search_paths.bat - Search for Libraries and HDL Tools
::

:start
  @echo off
  set cmd_location="%~dp0"
  pushd %cmd_location%
  set SEPARATOR="--------------------------------------------------------------------------------"
  set INDENT="  "

  echo %SEPARATOR%
  echo "-- %~nx0 Started!"
  echo.

echo "Search HEI Library"
::------------------------------------------------------------------------------
:: Search HEI library directory
::
if !REQUIRE_LIBS! == 1 (
  if "%HEI_LIBS_DIR%" == "" (
    set HEI_LIBS_DIR=%design_directory:"=!%\Libs
    if not exist !HEI_LIBS_DIR!\ (
      :: check at folder one level above project folder, as used on svn for boards libraries
      set HEI_LIBS_DIR=%design_directory:"=!%\..\Libs
      if not exist !HEI_LIBS_DIR!\ (
        :: check at folder one level above project folder, as used on svn for boards libraries
        set HEI_LIBS_DIR=%design_directory:"=!%\..\..\Libs
        if not exist !HEI_LIBS_DIR!\ (
          :: check on server, as used for ET labs
          set HEI_LIBS_DIR=R:\ETE\Ele1_8132\ELN\Labs\Libraries
          if not exist !HEI_LIBS_DIR!\ (
            :: check on server, as used for SI labs
            set HEI_LIBS_DIR=R:\SYND\Ele_2131\ELN\Labs\Libraries
            if not exist !HEI_LIBS_DIR!\ (
              echo "ERROR: No valid libraries found: please verify your project setup."
              pause&goto:end
            )
          )
        )
      )
    )
  )
  if exist !HEI_LIBS_DIR!\ (
    echo "%INDENT:"=%Found HEI_LIBS_DIR   at !HEI_LIBS_DIR:"=!"
  ) else (
    echo "%INDENT:"=%ERROR: No valid HEI_LIBS_DIR found: please verify your HEI_LIBS_DIR settings."
    pause&goto:eof
  )
)


echo "Search Design Tools: HDL Designer, Modelsim, Xilinx ISE, Microsemi Libero"
::------------------------------------------------------------------------------
:: Search HDL Designer directory
::
if !REQUIRE_HDS! == 1 (
  if "%HDS_HOME%" == "" (
    set HDS_HOME=C:\eda\MentorGraphics\HDS
    if not exist !HDS_HOME!\ (
      set HDS_HOME=C:\tools\eda\HDS
      if not exist !HDS_HOME!\ (
        echo "%INDENT:"=%ERROR: No valid installation of HDL-Designer found: please verify your HDS_HOME settings."
        pause&goto:eof
      )
    )
  )
  if exist !HDS_HOME! (
      echo "%INDENT:"=%Found HDL-Designer   at !HDS_HOME!"
  ) else (
      echo "%INDENT:"=%ERROR: No valid installation of HDL-Designer found: please verify your HDS_HOME settings."
      pause&goto:eof
    )
  )
)

::------------------------------------------------------------------------------
:: Search Modelsim directory
::
if !REQUIRE_MODELSIM! == 1 (
  if "%MODELSIM_HOME%" == "" (
    set MODELSIM_HOME=C:\eda\MentorGraphics\modelsim\win64
    if not exist !MODELSIM_HOME!\ (
      set MODELSIM_HOME=C:\eda\MentorGraphics\modelsim\win32
      if not exist !MODELSIM_HOME!\ (
        set MODELSIM_HOME=C:\tools\eda\Modelsim\win64
        if not exist !MODELSIM_HOME!\ (
          set MODELSIM_HOME=C:\tools\eda\Modelsim\win32
          if not exist !MODELSIM_HOME!\ (
            echo "%INDENT:"=%ERROR: No valid installation of ModelSim found please verify your MODELSIM_HOME settings."
            pause&goto:eof
          )
        )
      )
    )
  )
  if exist !MODELSIM_HOME! (
    echo "%INDENT:"=%Found ModelSim       at !MODELSIM_HOME:"=!"
  ) else (
    echo "%INDENT:"=%ERROR: No valid installation of ModelSim found please verify your MODELSIM_HOME settings."
    pause
    goto:eof
  )
)

::------------------------------------------------------------------------------
:: Search Xilinx ISE directory
::

if !REQUIRE_ISE! == 1 (
  if "%ISE_HOME%" == "" (
    set ISE_HOME=C:\eda\Xilinx\!ISE_VERSION:"=!\ISE_DS\ISE
    if not exist !ISE_HOME!\ (
      set ISE_HOME=C:\tools\eda\Xilinx\!ISE_VERSION:"=!\ISE_DS\ISE
      if not exist !ISE_HOME!\ (
        echo "%INDENT:"=%ERROR: No valid installation of ISE found please verify your ISE_HOME settings."
        pause&goto:eof
      )
    )
  )
  if exist !ISE_HOME! (
    echo "%INDENT:"=%Found ISE            at !ISE_HOME:"=!"
  ) else (
    echo "%INDENT:"=%ERROR: No valid installation of ISE found please verify your ISE_HOME settings."
    pause&goto:eof
  )
)

::------------------------------------------------------------------------------
:: Search Microsemi Libero directory
::
if %REQUIRE_LIBERO% == 1 (
  if "%LIBERO_HOME%" == "" (
    set LIBERO_HOME=C:\eda\Microsemi\Libero
    if not exist !LIBERO_HOME!\ (
      set LIBERO_HOME=C:\tools\eda\Microsemi\Libero
      if not exist !LIBERO_HOME!\ (
        echo "%INDENT:"=%ERROR: No valid installation of Libero found please verify your LIBERO_HOME settings."
        pause&goto:eof
      )
    )
  )
  if exist !LIBERO_HOME! (
    echo "%INDENT:"=%Found Libero         at !LIBERO_HOME:"=!"
  ) else (
    echo "%INDENT:"=%ERROR: No valid installation of Libero found please verify your LIBERO_HOME settings."
    pause
    goto:eof
  )
)

:end
  echo.
  echo "-- %~nx0 Finished!"
  echo %SEPARATOR%
  popd
  goto:eof