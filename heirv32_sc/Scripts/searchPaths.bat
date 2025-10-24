::==============================================================================
:: search_paths.bat - Search for Libraries and HDL Tools
::

:start
  @echo off
  set cmd_location="%~dp0"
  pushd %cmd_location%
  set SEPARATOR=--------------------------------------------------------------------------------
  set INDENT="  "

  echo %SEPARATOR%
  echo -- %~nx0 Started!
  echo.

echo Search HEI Library
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
    echo %INDENT:"=%Found HEI_LIBS_DIR   at !HEI_LIBS_DIR:"=!
  ) else (
    echo %INDENT:"=%ERROR: No valid HEI_LIBS_DIR found: please verify your HEI_LIBS_DIR settings.
    pause&goto:eof
  )
)


echo Search Design Tools: HDL Designer, Modelsim, Xilinx ISE, Microsemi Libero, Lattice Diamond, Lattice IceCube2
::------------------------------------------------------------------------------
:: Search HDL Designer directory
::
if !REQUIRE_HDS! == 1 (
  if "%HDS_HOME%" == "" (
    set HDS_HOME=C:\eda\MentorGraphics\HDS
    if not exist !HDS_HOME!\ (
      set HDS_HOME=C:\tools\eda\HDS
      if not exist !HDS_HOME!\ (
        echo %INDENT:"=%ERROR: No valid installation of HDL-Designer found: please verify your HDS_HOME settings.
        pause&goto:eof
      )
    )
  )
  if exist !HDS_HOME! (
      echo %INDENT:"=%Found HDL-Designer   at !HDS_HOME!
  ) else (
      echo %INDENT:"=%ERROR: No valid installation of HDL-Designer found: please verify your HDS_HOME settings.
      pause&goto:eof
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
            echo %INDENT:"=%ERROR: No valid installation of ModelSim found please verify your MODELSIM_HOME settings.
            pause&goto:eof
          )
        )
      )
    )
  )
  if exist !MODELSIM_HOME! (
    echo %INDENT:"=%Found ModelSim       at !MODELSIM_HOME:"=!
  ) else (
    echo %INDENT:"=%ERROR: No valid installation of ModelSim found please verify your MODELSIM_HOME settings.
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
        echo %INDENT:"=%ERROR: No valid installation of ISE found please verify your ISE_HOME settings.
        pause&goto:eof
      )
    )
  )
  if exist !ISE_HOME! (
    echo %INDENT:"=%Found ISE            at !ISE_HOME:"=!
  ) else (
    echo %INDENT:"=%ERROR: No valid installation of ISE found please verify your ISE_HOME settings.
    pause&goto:eof
  )
)

::------------------------------------------------------------------------------
:: Search Xilinx Vivado directory
::
if %REQUIRE_VIVADO% == 1 (
  if "%VIVADO_HOME%" == "" (
    set VIVADO_HOME=C:\eda\Xilinx\Vivado\2023.2\
    if not exist !VIVADO_HOME!\ (
      set VIVADO_HOME=C:\tools\eda\Xilinx\Vivado\$!VIVADO_VERSION:"=!\

      if not exist !VIVADO_HOME!\ (
        set VIVADO_HOME=\opt\EDA\Xilinx\Vivado\$!VIVADO_VERSION:"=!\
        if not exist !VIVADO_HOME!\ (
          echo %INDENT:"=%ERROR: No valid installation of Vivado found - please verify your VIVADO_HOME settings.
          pause&goto:eof
        )
      )
    )
  )
  if exist !VIVADO_HOME! (
    echo %INDENT:"=%Found Vivado        at !VIVADO_HOME:"=!
  ) else (
    echo %INDENT:"=%ERROR: No valid installation of Vivado found - please verify your VIVADO_HOME settings.
    pause
    goto:eof
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
        echo %INDENT:"=%ERROR: No valid installation of Libero found please verify your LIBERO_HOME settings.
        pause&goto:eof
      )
    )
  )
  if exist !LIBERO_HOME! (
    echo %INDENT:"=%Found Libero         at !LIBERO_HOME:"=!
  ) else (
    echo %INDENT:"=%ERROR: No valid installation of Libero found please verify your LIBERO_HOME settings.
    pause
    goto:eof
  )
)

::------------------------------------------------------------------------------
:: Search Lattice Diamond directory
::
if %REQUIRE_DIAMOND% == 1 (
  if "%DIAMOND_HOME%" == "" (
    set DIAMOND_HOME=C:\eda\lscc\diamond\3.14
    if not exist !DIAMOND_HOME!\ (
      set DIAMOND_HOME=C:\tools\eda\lscc\diamond\3.14
      if not exist !DIAMOND_HOME!\ (
        set DIAMOND_HOME=C:\lscc\diamond\3.14
        if not exist !DIAMOND_HOME!\ (
          echo %INDENT:"=%WARNING: No valid installation of Lattice Diamond 3.14 found - looking for older version."
          set DIAMOND_HOME=C:\eda\lscc\diamond\3.12
          if not exist !DIAMOND_HOME!\ (
            set DIAMOND_HOME=C:\tools\eda\lscc\diamond\3.12
            if not exist !DIAMOND_HOME!\ (
              set DIAMOND_HOME=C:\lscc\diamond\3.12
              if not exist !DIAMOND_HOME!\ (
                echo %INDENT:"=%ERROR: No valid installation of Lattice Diamond found - please verify your DIAMOND_HOME settings.
                pause&goto:eof
              )
            )
          )
        )
      )
    )
    
  )
  if exist !DIAMOND_HOME! (
    echo %INDENT:"=%Found Diamond        at !DIAMOND_HOME:"=!
  ) else (
    echo %INDENT:"=%ERROR: No valid installation of Diamond found - please verify your DIAMOND_HOME settings.
    pause
    goto:eof
  )
)

::------------------------------------------------------------------------------
:: Search Lattice IceCube2 directory
::
if %REQUIRE_ICECUBE2% == 1 (
  if "%ICECUBE2_HOME%" == "" (
    set ICECUBE2_HOME=C:\eda\lscc\iCEcube2.2020.12
    if not exist !ICECUBE2_HOME!\ (
      set ICECUBE2_HOME=C:\tools\eda\lscc\iCEcube2.2020.12
      if not exist !ICECUBE2_HOME!\ (
        set ICECUBE2_HOME=C:\lscc\iCEcube2.2020.12
        if not exist !ICECUBE2_HOME!\ (
          echo %INDENT:"=%ERROR: No valid installation of Lattice IceCube2 found - please verify your ICECUBE2_HOME settings.
          pause&goto:eof
        )
      )
    )
  )
  if exist !ICECUBE2_HOME! (
    echo %INDENT:"=%Found IceCube2        at !ICECUBE2_HOME:"=!
  ) else (
    echo %INDENT:"=%ERROR: No valid installation of IceCube2 found - please verify your ICECUBE2_HOME settings.
    pause
    goto:eof
  )
)

::------------------------------------------------------------------------------
:: Search Lattice Radiant directory
::
if %REQUIRE_RADIANT% == 1 (
  if "%RADIANT_HOME%" == "" (
    set RADIANT_HOME=C:\eda\lscc\radiant\2023.2
    if not exist !RADIANT_HOME!\ (
      set RADIANT_HOME=C:\tools\eda\lscc\radiant\2023.2
      if not exist !RADIANT_HOME!\ (
        set RADIANT_HOME=C:\lscc\radiant\2023.2
        if not exist !RADIANT_HOME!\ (
          echo %INDENT:"=%ERROR: No valid installation of Lattice Radiant found - please verify your RADIANT_HOME settings.
          pause&goto:eof
        )
      )
    )
  )
  if exist !RADIANT_HOME! (
    echo %INDENT:"=%Found Radiant        at !RADIANT_HOME:"=!
  ) else (
    echo %INDENT:"=%ERROR: No valid installation of Radiant found - please verify your RADIANT_HOME settings.
    pause
    goto:eof
  )
)

:end
  echo.
  echo -- %~nx0 Finished!
  echo %SEPARATOR%
  echo. && echo.
  popd
  goto:eof