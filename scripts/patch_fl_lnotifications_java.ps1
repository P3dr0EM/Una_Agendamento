# Patch FlutterLocalNotificationsPlugin.java in pub cache to remove v1 embedding registerWith and disambiguate bigLargeIcon(null)
# Usage: run from project root in PowerShell

$cache = Join-Path $env:USERPROFILE "AppData\Local\Pub\Cache\hosted\pub.dev"
Get-ChildItem -Path $cache -Directory -Filter 'flutter_local_notifications*' -ErrorAction SilentlyContinue | ForEach-Object {
    $pkgPath = $_.FullName
    $java = Join-Path $pkgPath 'android\src\main\java\com\dexterous\flutterlocalnotifications\FlutterLocalNotificationsPlugin.java'
    if (-not (Test-Path $java)) { Write-Host "No Java plugin file at: $java"; return }

    Write-Host "Processing: $java"
    $bak = "$java.bak"
    if (-not (Test-Path $bak)) { Copy-Item -Path $java -Destination $bak -Force; Write-Host "Backup created: $bak" }

    $text = Get-Content -Path $java -Encoding UTF8 -Raw

    $orig = $text

    # 1) Remove the V1 registerWith method if present
    # Match: public static void registerWith(...){ ... }
    $text = [regex]::Replace($text, '(?ms)public\s+static\s+void\s+registerWith\s*\([^\)]*\)\s*\{.*?\n\s*\}', '')

    # 2) Disambiguate bigLargeIcon(null) -> bigLargeIcon((android.graphics.Bitmap) null)
    $text = $text -replace 'bigPictureStyle\.bigLargeIcon\(\s*null\s*\)', 'bigPictureStyle.bigLargeIcon((android.graphics.Bitmap) null)'

    if ($text -ne $orig) {
        Set-Content -Path $java -Value $text -Encoding UTF8
        Write-Host "Patched: $java"
    } else {
        Write-Host "No changes required for: $java"
    }

    Write-Host "--- Preview (first 120 lines) ---"
    Get-Content -Path $java -Encoding UTF8 | Select-Object -First 120 | ForEach-Object { Write-Host $_ }
    Write-Host "--- End preview ---"
}

Write-Host "Done. If files were patched, run 'flutter clean; flutter pub get; flutter run -d <device-id>'"