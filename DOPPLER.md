# Doppler Secret Management

此 MCP server 透過 [Doppler](https://doppler.com) 管理環境變數與 API key。

## 設定

- **Doppler project**: `handcraft-mcp`
- **Config**: `dev`
- **Scope**: `C:\Users\EdgarsTool\Projects\mcp-handcraft`

## 啟動方式

```cmd
run.cmd          # stdio MCP (Claude Desktop / OpenClaw)
run_http.cmd     # HTTP MCP (遠端呼叫)
```

兩者皆透過 `doppler run --` 注入環境變數，server 內直接讀 `os.getenv()`。

## 新增 key

```bash
doppler secrets set MY_API_KEY=<值>
```

或到 Doppler Web UI：https://dashboard.doppler.com

## 讀取（server.py 內）

```python
import os
MY_KEY = os.getenv("MY_API_KEY")
```

## 安全邊界

| 位置 | key 是否存在 |
|------|------------|
| `.env` 檔 | ❌ 不使用 |
| git repo | ❌ 不進 git |
| Doppler 雲端 | ✅ 集中管理 |
| server memory | 啟動時注入，不落地 |

## 參考

- fork: https://github.com/Edgars-tool/python-doppler-env
- 官方: https://github.com/DopplerHQ/python-doppler-env
