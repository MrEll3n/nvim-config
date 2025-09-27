local M = {}

function M.setup()
  -- NvChad defaults (on_attach, capabilities, diagnostics, ...)
  local nvlsp = require("nvchad.configs.lspconfig")
  nvlsp.defaults()

  -- 1) Servers you always want enabled (add or remove as needed)
  local baseline = { "html", "cssls" }

  -- 2) Load per-server options from lua/configs/lsp/*.lua
  local opts_by_server, lsp_dir = {}, (vim.fn.stdpath("config") .. "/lua/configs/lsp")
  local ok_list, files = pcall(vim.fn.readdir, lsp_dir, [[v:val =~ '\.lua$']])
  if ok_list then
    for _, f in ipairs(files) do
      local name = f:gsub("%.lua$", "")
      local ok, mod = pcall(require, "configs.lsp." .. name)
      if ok and (type(mod) == "table" or type(mod) == "function") then
        opts_by_server[name] = mod
      else
        vim.notify(("LSP config load failed for %s: %s"):format(name, tostring(mod)), vim.log.levels.WARN)
      end
    end
  end

  -- 3) Combine baseline + configs from the directory
  local servers = vim.deepcopy(baseline)
  for name in pairs(opts_by_server) do
    if not vim.tbl_contains(servers, name) then table.insert(servers, name) end
  end

  -- 4) Merge helper with NvChad defaults
  local function merge_opts(user)
    local opts = type(user) == "table" and user or {}
    local user_on_attach = opts.on_attach
    opts.on_attach = function(client, bufnr)
      if nvlsp.on_attach then nvlsp.on_attach(client, bufnr) end
      if type(user_on_attach) == "function" then user_on_attach(client, bufnr) end
    end
    opts.capabilities = vim.tbl_deep_extend("force", {}, nvlsp.capabilities or {}, opts.capabilities or {})
    return opts
  end

  -- 5) Setup a single server (new API)
  local function setup_server(server)
    local mod = opts_by_server[server]
    local opts = {}
    if type(mod) == "function" then
      local ok, produced = pcall(mod, nvlsp)  -- module can return opts dynamically
      opts = ok and (produced or {}) or {}
    elseif type(mod) == "table" then
      opts = mod
    end

    -- Register configuration + enable server
    vim.lsp.config(server, merge_opts(opts))
    vim.lsp.enable(server)
  end

  -- 6) (Optional) ensure installation via mason-lspconfig
  local ok_mason, mason_lsp = pcall(require, "mason-lspconfig")
  if ok_mason then
    mason_lsp.setup { ensure_installed = servers, automatic_installation = false }
  end

  -- 7) Enable all servers
  for _, s in ipairs(servers) do
    setup_server(s)
  end
end

return M
