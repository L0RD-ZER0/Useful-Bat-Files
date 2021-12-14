@ECHO off


REM This script is used to add the editor to the right click menu
ECHO Warning: Following script edits your registery entries. Use at your own risk.
ECHO The following script requires Administrator mode to run. Checking permissions...
ECHO.
GOTO :Admin-Check

:: Check if the script is running as Administrator
:: If not, run the script with admin rights
:: If the script is running as Administrator, continue

:Admin-Check
    NET SESSION > nul 2>&1

    IF %errorlevel% == 0 (
        ECHO Administrator access granted. Executing script...
        ECHO.
        GOTO :Editor-Setup
    ) ELSE (
        ECHO "Not running as Administrator"
        ECHO "Please run the script with Administrator rights"
        EXIT
    )


:Editor-Setup
    :: take input from the command line
    SET /p Editor="Name/Alias of the Editor: "
    SET /p EditorPath="Path to the Editor: "

    ECHO.
    ECHO Adding file entries
    REG add "HKEY_CLASSES_ROOT\*\shell\%Editor%" /t REG_SZ /v "" /d "Open with %Editor%"   /f
    REG add "HKEY_CLASSES_ROOT\*\shell\%Editor%" /t REG_EXPAND_SZ /v "Icon" /d "%EditorPath%,0" /f
    REG add "HKEY_CLASSES_ROOT\*\shell\%Editor%\command" /t REG_SZ /v "" /d "%EditorPath% \"%%V\"" /f
    
    ECHO.
    ECHO Adding within a folder entries
    REG add "HKEY_CLASSES_ROOT\Directory\Background\shell\%Editor%" /t REG_SZ /v "" /d "Open with %Editor%"   /f
    REG add "HKEY_CLASSES_ROOT\Directory\Background\shell\%Editor%" /t REG_EXPAND_SZ /v "Icon" /d "%EditorPath%,0" /f
    REG add "HKEY_CLASSES_ROOT\Directory\Background\shell\%Editor%\command" /t REG_SZ /v "" /d "%EditorPath% \"%%V\"" /f

    ECHO.
    ECHO Adding folder entries
    REG add "HKEY_CLASSES_ROOT\Directory\shell\%Editor%" /t REG_SZ /v "" /d "Open with %Editor%"   /f
    REG add "HKEY_CLASSES_ROOT\Directory\shell\%Editor%" /t REG_EXPAND_SZ /v "Icon" /d "%EditorPath%,0" /f
    REG add "HKEY_CLASSES_ROOT\Directory\shell\%Editor%\command" /t REG_SZ /v "" /d "%EditorPath% \"%%V\"" /f

    ECHO.
    PAUSE