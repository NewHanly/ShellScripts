$num = 1
Get-ChildItem | ForEach-Object {
    foreach ($ob in (Get-ChildItem $_.Name *.jpeg -Recurse)) {
        $filename = [string]$num + 't' + $ob
        Copy-Item  E:\Download\manga-0.5.5_linux\manga_res\$_\origins\$ob -Destination E:\Download\manga-0.5.5_linux\all\$filename
        Write-Output $filename
    }
    $num++
}