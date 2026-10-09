$map = @{}

Get-Content "vi.txt" -Encoding UTF8 | ForEach-Object {
    if ($_ -match "(.+?)\s*-\s*(.+)") {
        $map[$matches[1]] = $matches[2]
    }
}

$text = Get-Content "input.txt" -Raw -Encoding UTF8

foreach ($k in ($map.Keys | Sort-Object Length -Descending)) {
    $text = $text -creplace [regex]::Escape($k), $map[$k]
}

[System.IO.File]::WriteAllText("output.txt", $text, [System.Text.Encoding]::ASCII)

"done"