@echo off
setlocal

where powershell >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo PowerShell is required to run this installer.
    exit /b 1
)

if "%~1"=="" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$script = (Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.ps1').Content; & ([scriptblock]::Create($script))"
) else (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "$script = (Invoke-WebRequest -UseBasicParsing 'https://raw.githubusercontent.com/gimenorum/opencode-agents/main/setup.ps1').Content; & ([scriptblock]::Create($script)) -Destination '%~1'"
)
exit /b %ERRORLEVEL%
