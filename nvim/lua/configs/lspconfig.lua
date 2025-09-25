-- ~/.config/nvim/lua/configs/lspconfig.lua
local M = {}

-- bezpečné require
local function prequire(mod)
  local ok, m = pcall(require, mod)
  if ok then return m end
  return nil
end

-- TSDK pro Volar (Mason -> projekt -> nil)
local function find_tsdk()
  local mason_ts = vim.fn.stdpath("data")
    .. "/mason/packages/typescript-language-server/node_modules/typescript/lib"
  if vim.fn.isdirectory(mason_ts) == 1 then return mason_ts end

  local project_ts = vim.fn.getcwd() .. "/node_modules/typescript/lib"
  if vim.fn.isdirectory(project_ts) == 1 then return project_ts end

  return nil
end

-- start pomocí nového API; defaulty bereme z nvim-lspconfig
local function start_server(server, user_opts)
  -- nutný Neovim ≥ 0.11
  assert(vim.lsp and vim.lsp.config and vim.lsp.start, "Neovim 0.11+ required")

  local nv = require("nvchad.configs.lspconfig")
  nv.defaults()

  local lspcfg = require("lspconfig") -- jen jako zdroj default_config (cmd, root_dir…)
  local defaults = {}
  if lspcfg[server] and lspcfg[server].document_config then
    defaults = lspcfg[server].document_config.default_config or {}
  else
    vim.notify("Unknown LSP server: " .. server, vim.log.levels.WARN)
  end

  -- merge on_attach, capabilities + user_opts
  local opts = vim.tbl_deep_extend("force", defaults, {
    on_attach = nv.on_attach,
    capabilities = nv.capabilities or {},
  }, user_opts or {})

  -- rozumné defaulty, pokud chybí per-server soubory
  if server == "lua_ls" then
    opts.settings = vim.tbl_deep_extend("force", {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    }, opts.settings or {})
  elseif server == "volar" then
    opts.filetypes = opts.filetypes
      or { "vue", "typescript", "javascript", "javascriptreact", "typescriptreact" }
    if not opts.init_options then
      local tsdk = find_tsdk()
      if tsdk then opts.init_options = { typescript = { tsdk = tsdk } } end
    end
  end

  -- nové API
  local cfg = vim.lsp.config(opts)
  vim.lsp.start(cfg)
end

function M.setup()
  -- servery, které chceš
  local baseline = {
    "html",
    "cssls",
    "tsserver",
    "jsonls",
    "yamlls",
    "lua_ls",
    "volar",
  }

  -- volitelné per-server overrides z ~/.config/nvim/lua/configs/lsp/*.lua
  local overrides = {}
  local dir = vim.fn.stdpath("config") .. "/lua/configs/lsp"
  local ok, files = pcall(vim.fn.readdir, dir, [[v:val =~ '\.lua$']])
  if ok then
    for _, f in ipairs(files) do
      local name = f:gsub("%.lua$", "")
      local mod = prequire("configs.lsp." .. name)
      if type(mod) == "table" or type(mod) == "function" then
        overrides[name] = mod
      end
    end
  end

  -- sjednoť
  local servers = vim.deepcopy(baseline)
  for name, _ in pairs(overrides) do
    if not vim.tbl_contains(servers, name) then table.insert(servers, name) end
  end

  -- Mason (pokud je)
  local mason = prequire("mason")
  if mason then mason.setup() end
  local mason_lsp = prequire("mason-lspconfig")
  if mason_lsp then
    mason_lsp.setup {
      ensure_installed = servers,
      automatic_installation = false,
    }
  end

  -- start všech serverů
  for _, server in ipairs(servers) do
    local mod = overrides[server]
    local user_opts = {}
    if type(mod) == "function" then
      local ok2, produced = pcall(mod, { find_tsdk = find_tsdk })
      user_opts = ok2 and (produced or {}) or {}
    elseif type(mod) == "table" then
      user_opts = mod
    end
    start_server(server, user_opts)
  end
end

return M

