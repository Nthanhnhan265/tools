@echo off
chcp 65001 >nul
title Convert Unicode -> TELEX ASCII

powershell -ExecutionPolicy Bypass -File "%~dp0convert.ps1"

echo.
pause