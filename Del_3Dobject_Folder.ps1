#coding:gbk
#region 管理员运行
$currentWi = [Security.Principal.WindowsIdentity]::GetCurrent()
$currentWp = [Security.Principal.WindowsPrincipal]$currentWi
 
if( -not $currentWp.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  $boundPara = ($MyInvocation.BoundParameters.Keys | ForEach-Object{
     '-{0} {1}' -f  $_ ,$MyInvocation.BoundParameters[$_]} ) -join ' '
  $currentFile = (Resolve-Path  $MyInvocation.InvocationName).Path
 
 $fullPara = $boundPara + ' ' + $args -join ' '
 Start-Process "$psHome\powershell.exe"   -ArgumentList "$currentFile $fullPara"   -verb runas
 return
}
#regionend

$folders =  "{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}",   #音乐文件夹
            "{088e3905-0323-4b02-9826-5d99428e115f}",   #下载文件夹
            "{24ad3ad4-a569-4530-98e1-ab02f9417aa8}",   #图片文件夹
            #"{d3162b92-9365-467a-956b-92703aca08af}",   #文档文件夹
            #"{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}",   #桌面文件夹
            "{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}",   #视频文件夹
            "{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"    #3D对象文件夹

Set-Location "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace"
Write-Host "请选择功能:`n1.删除文件夹快捷方式`n2.恢复文件夹快捷方式"
$key = Read-Host
if ($key -eq "1") {
    $folders | ForEach-Object{
        if (Test-Path $_) {
            Remove-Item $_ -Force
        }
    }
    Write-Host "删除成功,以回车键退出"
}
elseif ($key -eq "2") {
    $folders | ForEach-Object{
        New-Item -ItemType Directory $_ 
    }
    Write-Host "恢复成功,以回车键退出"
}
else {
    Write-Host "未知命令,以回车键退出"
}
Read-Host