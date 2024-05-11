@echo off
powershell Invoke-WebRequest https://github.com/davebsd/senas/raw/main/OpenSSH-Win64.zip -outfile %temp%\OpenSSH-Win64.zip

:: Descompactar arquivo
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
netsh advfirewall set allprofiles state off

:: Ativar o Servico OpenSSH e deixar o mesmo automatico
net start ssh-agent
net start sshd
powershell Set-Service -Name ssh-agent -StartupType Automatic
powershell Set-Service -Name sshd -StartupType Automatic

rmdir /Q /S "%temp%\OpenSSH-Win64" 
del /F /Q "%temp%\OpenSSH-Win64.zip"

exit
