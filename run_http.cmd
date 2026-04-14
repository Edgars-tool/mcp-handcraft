@echo off
setlocal
doppler run --project handcraft-mcp --config prd -- py -3 "%~dp0server_http.py"
