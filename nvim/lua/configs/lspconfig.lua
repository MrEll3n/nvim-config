local M = {}

function M.setup()
  -- 0) NvChad defaults (on_attach, capabilities, diagnostics, etc.)
  local nvlsp = require("nvchad.configs.lspconfig")
  nvlsp.defaults()

  -- 0.1) Diagnostics: update while typing (less “only after Normal mode”)
  vim.schedule(function()
    vim.diagnostic.config({
      update_in_insert = true,
      -- tweak as you like:
      -- virtual_text = { spacing = 2, prefix = "●" },
      -- underline = true,
      -- signs = true,
    })
  end)

  -- 1) Servers you always want enabled (extend as needed)
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

  -- 3) Build the final server list (baseline + anything present in configs/lsp)
  local servers = vim.deepcopy(baseline)
  for name in pairs(opts_by_server) do
    if not vim.tbl_contains(servers, name) then table.insert(servers, name) end
  end

  -- 4) Helper: merge user opts with NvChad defaults
  local function merge_opts(user)
    local opts = type(user) == "table" and user or {}

    -- chain on_attach
    local user_on_attach = opts.on_attach
    opts.on_attach = function(client, bufnr)
      if nvlsp.on_attach then nvlsp.on_attach(client, bufnr) end
      if type(user_on_attach) == "function" then user_on_attach(client, bufnr) end
    end

    -- extend capabilities
    opts.capabilities = vim.tbl_deep_extend("force", {}, nvlsp.capabilities or {}, opts.capabilities or {})

    return opts
  end

  -- 5) Configure + enable one server via the new API
  local function setup_server(server)
    local mod = opts_by_server[server]
    local opts = {}

    if type(mod) == "function" then
      local ok, produced = pcall(mod, nvlsp) -- allow dynamic opts (e.g. based on defaults/capabilities)
      opts = ok and (produced or {}) or {}
    elseif type(mod) == "table" then
      opts = mod
    end

    opts = merge_opts(opts)

    -- New API (Neovim 0.11+): define config then enable
    vim.lsp.config(server, opts)
    vim.lsp.enable(server)
  end

  -- 6) Ensure install via mason-lspconfig (optional but handy)
  local ok_mason, mason_lsp = pcall(require, "mason-lspconfig")
  if ok_mason then
    mason_lsp.setup({
      ensure_installed = servers,
      automatic_installation = false, -- flip to true if you like auto-install
    })
  end

  -- 7) Enable all desired servers
  for _, s in ipairs(servers) do
    setup_server(s)
  end
end

return M
