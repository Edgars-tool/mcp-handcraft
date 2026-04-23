# mcp-handcraft

這個資料夾有兩條不同的 MCP server 入口，請分開使用，不要混用。

## 入口分工

- `run.cmd`
  啟動 `server.py`
  給本地 `stdio` 方式的 MCP client 使用。
  適合 Ollama、龍蝦這類直接用標準輸入輸出溝通的本地流程。
  目前走 Windows `py -3` launcher，不綁死特定使用者路徑。

- `run_http.cmd`
  啟動 `server_http.py`
  給 HTTP 方式的 MCP client 使用。
  適合 MCP Inspector、瀏覽器測試、或其他會用 `POST /mcp` 連進來的 client。
  目前走 Windows `py -3` launcher，不綁死特定使用者路徑。

## 現況提醒

- `server.py` 是本地 `stdio` 入口
- `server_http.py` 是 HTTP 入口
- `server_http.py` 目前已接上 `codex_agent`
- `server_http.py` 目前也已接上 `claude_code_agent`
- `server_http.py` 已整合 Linear（list / get / create / update / search）

## Claude Code 前提

如果要用 `claude_code_agent`，本機需要先完成：

```powershell
winget install Anthropic.ClaudeCode
claude auth login
```

如果 `claude` 指令不在 PATH，HTTP tool call 會失敗。

## Linear 前提

Linear 工具需要設定 API key：

```
LINEAR_API_KEY=lin_api_xxxxxxxxxxxxxxxx
```

在 Doppler 加入後重啟 server 即生效。取得方式：Linear → Settings → API → Personal API keys。

## HTTP 版注意事項

- `server_http.py` 目前預設會在 `90` 秒內等 agent 回覆。
- 這是為了避免 Cloudflare Tunnel 一類的 HTTP 代理先超時，外面只看到空白或中斷。
- 若要改長一點，可設定環境變數 `MCP_AGENT_TIMEOUT_SECONDS`。

## OAuth 授權端點（完整三件套）

| 端點 | 用途 |
|---|---|
| `POST /mcp` | MCP 主端點 |
| `GET /authorize` | OAuth 授權（發 code） |
| `POST /token` | 換 access_token |
| `POST /register` | Dynamic Client Registration |
| `GET /.well-known/oauth-authorization-server` | OAuth metadata |
| `GET /.well-known/oauth-protected-resource` | Resource metadata |

401 回應會帶 `WWW-Authenticate` header，讓支援 OAuth 的 MCP client（如 Claude Desktop）自動走授權流程。
