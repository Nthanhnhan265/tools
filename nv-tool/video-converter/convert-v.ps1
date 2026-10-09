$input  = ".\in"
$temp   = ".\tmp"
$output = ".\out"

# Tạo thư mục nếu chưa tồn tại
New-Item -ItemType Directory -Force -Path $temp   | Out-Null
New-Item -ItemType Directory -Force -Path $output | Out-Null

Get-ChildItem $input -Filter *.mp4 | ForEach-Object {

    $inFile  = $_.FullName
    $base    = $_.BaseName

    $tmpFile = Join-Path $temp   "$base-opt.mp4"
    $outFile = Join-Path $output "$base.avi"

    Write-Host "Processing: $($_.Name)"

    # Bước 1: Tối ưu mp4
    ffmpeg -y -i "$inFile" `
        -vf "setpts=0.8*PTS" `
        -af "atempo=1.25" `
        -c:v libx264 -crf 28 -preset veryfast `
        -c:a libmp3lame -b:a 64k `
        "$tmpFile"

    # Bước 2: MP4 → AVI cho máy mp3
    ffmpeg -y -i "$tmpFile" `
        -vf "scale=128:160:force_original_aspect_ratio=increase,crop=128:160" `
        -r 16 `
        -acodec pcm_s16le -ac 2 -ar 22050 `
        -pix_fmt yuvj420p `
        -c:v mjpeg -q:v 2 `
        "$outFile"

    # Xóa file tạm nếu muốn
    Remove-Item "$tmpFile" -Force
}