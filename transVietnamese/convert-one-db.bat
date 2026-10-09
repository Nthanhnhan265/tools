@echo off
chcp 65001 >nul
title Convert Unicode -> TELEX ASCII

echo Dang chuan bi bang thay the...
echo.

set MAP=vi.txt
set INPUT=input.txt
set OUTPUT=output.txt

if not exist "%MAP%" (
  echo Loi: Khong tim thay %MAP%
  goto end
)

if not exist "%INPUT%" (
  echo Loi: Khong tim thay %INPUT%
  goto end
)

powershell -NoProfile -Command ^
"$map = @{}; ^
Get-Content '%MAP%' -Encoding UTF8 | ForEach-Object { ^
  if ($_ -match '(.+?)\s*-\s*(.+)') { ^
    $map[$matches[1]] = $matches[2] ^
  } ^
}; ^
$text = Get-Content '%INPUT%' -Raw -Encoding UTF8; ^
foreach ($k in ($map.Keys | Sort-Object Length -Descending)) { ^
  $text = $text -replace [regex]::Escape($k), $map[$k] ^
}; ^
[System.IO.File]::WriteAllText('%OUTPUT%', $text, [System.Text.Encoding]::ASCII)"

echo.
echo Da chuyen xong -> %OUTPUT%
echo.

:end
pause