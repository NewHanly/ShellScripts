#coding:gbk
#region ����Ա����
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

$folders =  "{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}",   #�����ļ���
            "{088e3905-0323-4b02-9826-5d99428e115f}",   #�����ļ���
            "{24ad3ad4-a569-4530-98e1-ab02f9417aa8}",   #ͼƬ�ļ���
            #"{d3162b92-9365-467a-956b-92703aca08af}",   #�ĵ��ļ���
            #"{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}",   #�����ļ���
            "{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}",   #��Ƶ�ļ���
            "{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}"    #3D�����ļ���

Set-Location "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace"
Write-Host "��ѡ����:`n1.ɾ���ļ��п�ݷ�ʽ`n2.�ָ��ļ��п�ݷ�ʽ"
$key = Read-Host
if ($key -eq "1") {
    $folders | ForEach-Object{
        if (Test-Path $_) {
            Remove-Item $_ -Force
        }
    }
    Write-Host "ɾ���ɹ�,�Իس����˳�"
}
elseif ($key -eq "2") {
    $folders | ForEach-Object{
        New-Item -ItemType Directory $_ 
    }
    Write-Host "�ָ��ɹ�,�Իس����˳�"
}
else {
    Write-Host "δ֪����,�Իس����˳�"
}
Read-Host