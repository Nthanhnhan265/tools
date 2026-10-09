@echo off
title Realme 5 Pro - Safe Debloat
echo ==========================================
echo       REALME 5 PRO - SAFE DEBLOAT
echo ==========================================
echo.
echo WARNING:
echo Script chi go app cho User 0.
echo Khong xoa file he thong khoi phan vung system.
echo.

adb start-server
adb wait-for-device

echo.
echo Kiem tra thiet bi:
adb devices
echo.

pause

echo.
echo ==========================================
echo [1] HEYTAP / OPPO BLOATWARE
echo ==========================================

call :remove com.heytap.themestore "Theme Store"
call :remove com.heytap.pictorial "Lock Screen Magazine"
call :remove com.heytap.browser "HeyTap Browser"
call :remove com.heytap.market "HeyTap App Market"
call :remove com.heytap.music "HeyTap Music"
call :remove com.heytap.cloud "HeyTap Cloud"
call :remove com.heytap.usercenter "HeyTap User Center"

echo.
echo ==========================================
echo [2] OPPO / REALME OPTIONAL APPS
echo ==========================================

call :remove com.coloros.video "ColorOS Video"
call :remove com.nearme.gamecenter "Game Center"
call :remove com.oppo.operationManual "OPPO Operation Manual"
call :remove com.oppo.qualityprotect "OPPO Quality Protect"
call :remove com.oppo.nhs "OPPO NHS"

echo.
echo ==========================================
echo [3] FACEBOOK BLOATWARE
echo ==========================================

call :remove com.facebook.appmanager "Facebook App Manager"
call :remove com.facebook.services "Facebook Services"
call :remove com.facebook.system "Facebook System"
call :remove com.facebook.lite "Facebook Lite"
call :remove com.facebook.orca "Facebook Messenger"

echo.
echo ==========================================
echo [4] OTHER OPTIONAL SERVICES
echo ==========================================

call :remove com.google.android.videos "Google TV / Videos"
call :remove com.google.android.apps.youtube.music "YouTube Music"
call :remove com.google.android.apps.labs.language.tailwind "Google Experimental App"
call :remove com.google.android.apps.bard "Google Gemini"
call :remove com.google.android.apps.tachyon "Google Duo"
call :remove com.google.android.apps.fitness "Google Fit"
call :remove com.google.android.keep "Google Keep"
call :remove com.google.android.play.games "Google Play Games"

echo.
echo ==========================================
echo           DEBLOAT HOAN TAT
echo ==========================================
echo.
echo Khuyen nghi khoi dong lai dien thoai.
echo.
pause
exit /b


:remove
echo.
echo ------------------------------------------
echo Dang go: %~2
echo Package: %~1
adb shell pm uninstall --user 0 %~1

if %errorlevel%==0 (
    echo [OK] %~2
) else (
    echo [SKIP] Khong go duoc / khong ton tai: %~2
)

exit /b