@echo off
chcp 65001 >nul

set MAP=vi.txt
set INPUT=input.txt
set OUTPUT=output.txt

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
echo DONE! File da duoc chuyen: %OUTPUT%
pause