@echo off
curl -o "%appdata%\rsimage.jpg" "https://raw.githubusercontent.com/davebsd/senas/refs/heads/main/Wallpaper/rsimage.jpg" > nul 2>&1

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop" /v NoChangingWallPaper /f > nul 2>&1
gpupdate /force > nul 2>&1

powershell -ExecutionPolicy Bypass -Command "Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value '%appdata%\rsimage.jpg'" > nul 2>&1
powershell -Command "Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name WallpaperStyle -Value 6; Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name TileWallpaper -Value 0" > nul 2>&1
RUNDLL32.EXE USER32.DLL,UpdatePerUserSystemParameters 1, True > nul 2>&1
del /q /s "%appdata%\wallpaper.bat" && exit > nul 2>&1
