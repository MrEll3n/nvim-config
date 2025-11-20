-- ~/.config/nvim/lua/configs/lspconfig.lua

local M = {}

function M.setup()
  -- 0) NvChad defaults (capabilities, on_attach, etc.)
  local nvlsp = require("nvchad.configs.lspconfig")
  nvlsp.defaults()

  -- 0.1) Diagnostics: update while typing
  vim.schedule(function()
    vim.diagnostic.config({
      update_in_insert = true,
      -- you can tweak virtual_text / signs / underline here
    })
  end)

  -- 1) Servers that are always enabled (you can extend this list)
  -- NOTE: everything in lua/configs/lsp/*.lua will be added automatically.
  local baseline = { "html", "cssls" }

  -- 2) Load per-server options from lua/configs/lsp/*.lua
  local opts_by_server = {}
  local lsp_dir = vim.fn.stdpath("config") .. "/lua/configs/lsp"

  local ok_list, files = pcall(vim.fn.readdir, lsp_dir, [[v:val =~ '\.lua$']])
  if ok_list then
    for _, f in ipairs(files) do
      local name = f:gsub("%.lua$", "")
      local ok, mod = pcall(require, "configs.lsp." .. name)

      if ok and (type(mod) == "table" or type(mod) == "function") then
        opts_by_server[name] = mod
      else
        vim.notify(
          ("LSP config load failed for %s: %s"):format(name, tostring(mod)),
          vim.log.levels.WARN
        )
      end
    end
  end

  -- 3) Build the final server list (baseline + anything present in configs/lsp)
  local servers = vim.deepcopy(baseline)
  for name in pairs(opts_by_server) do
    if not vim.tbl_contains(servers, name) then
      table.insert(servers, name)
    end
  end

  -- 4) Helper to merge user opts with NvChad defaults
  local function merge_opts(user)
    local opts = type(user) == "table" and user or {}

    -- chain on_attach
    local user_on_attach = opts.on_attach
    opts.on_attach = function(client, bufnr)
      if nvlsp.on_attach then
        nvlsp.on_attach(client, bufnr)
      end
      if type(user_on_attach) == "function" then
        user_on_attach(client, bufnr)
      end
    end

    -- extend capabilities
    opts.capabilities = vim.tbl_deep_extend(
      "force",
      {},
      nvlsp.capabilities or {},
      opts.capabilities or {}
    )

    return opts
  end

  -- 5) Configure + enable one server via the new Neovim LSP API
  local function setup_server(server)
    local mod = opts_by_server[server]
    local opts = {}

    if type(mod) == "function" then
      local ok, produced = pcall(mod, nvlsp)
      opts = ok and (produced or {}) or {}
    elseif type(mod) == "table" then
      opts = mod
    end

    opts = merge_opts(opts)

    -- Neovim 0.11+: define config, then enable it
    vim.lsp.config(server, opts)
    vim.lsp.enable(server)
  end

  -- 6) Ensure installation via mason-lspconfig (optional but nice)
  local ok_mason, mason_lsp = pcall(require, "mason-lspconfig")
  if ok_mason then
    mason_lsp.setup({
      ensure_installed = servers,
      automatic_installation = false, -- set true if you want auto-install
    })
  end

  -- 7) Enable all configured servers
  for _, s in ipairs(servers) do
    setup_server(s)
  end
end

return M
