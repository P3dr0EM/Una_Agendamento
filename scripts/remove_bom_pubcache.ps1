# Remove UTF-8 BOM (EF BB BF) from flutter_local_notifications android/build.gradle files in the Pub cache
# Usage: run from project root in PowerShell

$cache = Join-Path $env:USERPROFILE "AppData\Local\Pub\Cache\hosted\pub.dev"
Get-ChildItem -Path $cache -Directory -Filter 'flutter_local_notifications*' -ErrorAction SilentlyContinue | ForEach-Object {
    $file = Join-Path $_.FullName 'android\build.gradle'
    if (Test-Path $file) {
        Write-Host "Checking: $file"
        $bytes = [System.IO.File]::ReadAllBytes($file)
        if ($bytes.Length -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
            $rest = $bytes[3..($bytes.Length - 1)]
            # Overwrite file without BOM (preserve remaining bytes)
            [System.IO.File]::WriteAllBytes($file, $rest)
            Write-Host "Removed UTF-8 BOM from: $file"
        } else {
            Write-Host "No BOM in: $file"
        }
    }
}

Write-Host "Done. Run 'flutter clean' and rebuild your app."