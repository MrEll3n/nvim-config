-- ~/.config/nvim/lua/configs/lsp/lua_ls.lua
return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        -- Neřvi na globální `vim`, případně přidej další globály dle potřeby
        globals = { "vim" },
      },
      workspace = {
        -- Načti runtime Nvim soubory, aby fungoval completion/reference na vim api a pluginy
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },

      -- Volitelné: vestavěné formátování (pokud nechceš, vynech)
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
          quote_style = "auto",
        },
      },

      -- Volitelné: “semantic” hints a chování completion
      hint = { enable = true },
      completion = {
        callSnippet = "Replace", -- nebo "Both"/"Disable"
        displayContext = 5,
        keywordSnippet = "Replace",
      },
    },
  },
}
