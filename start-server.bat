@echo off
rem Раздаёт переведённый манифест NOMNOM для NOMM по http://localhost:8765/
rem Запуск: двойной клик по файлу. Остановить: закрыть окно.
cd /d "%~dp0dist"
echo Serving translated NOMNOM manifest at http://localhost:8765/
echo Close this window to stop the server.
python -m http.server 8765 --bind 127.0.0.1
pause
