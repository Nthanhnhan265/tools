@echo off
REM Usage: start.bat [input_file] [output_dir]
SETLOCAL

if "%~1"=="" (
  set "INPUT=book.txt"
) else (
  set "INPUT=%~1"
)

if "%~2"=="" (
  set "OUTDIR=bmp_pages"
) else (
  set "OUTDIR=%~2"
)

echo Running: python render_book.py "%INPUT%" "%OUTDIR%"
python render_book.py "%INPUT%" "%OUTDIR%"
echo Done.
pause
ENDLOCAL