@echo off
REM フォルダクリーンアップバッチファイル
REM ログファイルパス
set LOGFILE=C:\jdl_backup\cleanup.log

REM PowerShellスクリプトを実行
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\jdl_backup\cleanup_folders.ps1"

REM 完了をログに記録
for /f "tokens=2-4 delims=/ " %%%%a in ('date /t') do (set mydate=%%%%c-%%%%a-%%%%b)
for /f "tokens=1-2 delims=/:" %%%%a in ('time /t') do (set mytime=%%%%a:%%%%b)
echo %mydate% %mytime% - バッチ実行完了 >> %LOGFILE%

REM 30秒後に終了（ウィンドウを少しの間表示させるため）
timeout /t 30 /nobreak
