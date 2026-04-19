# GitHub Copilot Instructions — mcp-handcraft

## Project Overview
MCP server with dual entry points: stdio (local agents) and HTTP (browser/inspector clients).
Stack: Python 3 · Windows py -3 launcher · stdio + HTTP MCP protocol

## Entry Points — Keep Them Separate
- server.py + run.cmd: stdio MCP for local agents (Ollama, OpenClaw) via stdin/stdout
  - server_http.py + run_http.cmd: HTTP MCP on POST /mcp for browser clients
- Do NOT mix stdio and HTTP logic
- server_http.py integrates codex_agent and claude_code_agent

## Git Workflow
- Always git pull origin master before starting (default branch is master)
- Use conventional commits: feat/fix/chore(scope): description
- Scopes: stdio, http, agent, codex, claude, tools, config
  - Reference issues in commits: fix(#5): handle timeout in http agent

## Windows Environment
- Use py -3 launcher, not python directly — do not hardcode user paths
- Claude Code agent requires: winget install Anthropic.ClaudeCode then claude auth login
  - If claude is not in PATH, HTTP tool calls to claude_code_agent will fail

  ## Architecture
  - HTTP server defaults to 90s agent timeout (override: MCP_AGENT_TIMEOUT_SECONDS env var)
  - Timeout prevents Cloudflare Tunnel from cutting response before agent finishes
  - Exposed via Cloudflare Tunnel at mcp.whoasked.vip

  ## Code Style
  - Python: PEP 8, f-strings, clear error messages
  - Keep tool implementations focused and single-purpose
  - Log agent errors clearly so HTTP callers get useful responses, not blank 500s
  - Validate inputs at tool boundary before calling agents

  ## Secrets and Config
  - Never hardcode API keys or paths
  - Use environment variables or .env for agent credentials
