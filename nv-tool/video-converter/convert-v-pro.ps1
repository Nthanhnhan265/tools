$input  = ".\videos"
$temp   = ".\tmp"
$output = ".\out"

mkdir $temp,$output -ea 0 | Out-Null

Get-ChildItem $input -Filter *.mp4 | ForEach-Object {

    $inFile  = $_.FullName
    $base    = $_.BaseName

    $tmpFile = Join-Path $temp   "$base-opt.mp4"
    $outFile = Join-Path $output "$base.avi"

    # Lấy width x height thật
    $dim = ffprobe -v error -select_streams v:0 `
        -show_entries stream=width,height `
        -of csv=p=0:s=x "$inFile"

    $w,$h = $dim -split "x"

    Write-Host "Processing: $($_.Name)  [$w x $h]"

    # Step 1 – Tối ưu MP4
    ffmpeg -y -i "$inFile" `
        -vf "setpts=0.8*PTS" `
        -af "atempo=1.25" `
        -c:v libx264 -crf 28 -preset veryfast `
        -c:a libmp3lame -b:a 96k `
        "$tmpFile"

    # Step 2 – Detect xoay
    if ([int]$w -gt [int]$h) {
        # Video ngang → xoay 90° sang dọc
        $vf = "transpose=1,scale=128:160:force_original_aspect_ratio=increase,crop=128:160"
    } else {
        # Video dọc → giữ nguyên
        $vf = "scale=128:160:force_original_aspect_ratio=increase,crop=128:160"
    }

    # Step 3 – Convert AVI cho máy MP3
    ffmpeg -y -i "$tmpFile" `
        -vf "$vf" `
        -r 16 `
        -acodec pcm_s16le -ac 2 -ar 22050 `
        -pix_fmt yuvj420p `
        -c:v mjpeg -q:v 2 `
        "$outFile"

    Remove-Item "$tmpFile" -Force
}