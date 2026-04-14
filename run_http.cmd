@echo off
setlocal
doppler run -- py -3 "%~dp0server_http.py"
