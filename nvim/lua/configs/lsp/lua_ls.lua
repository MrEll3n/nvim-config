-- ~/.config/nvim/lua/configs/lsp/lua_ls.lua
return {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        -- Don't warn about the global `vim`; add more globals here if needed
        globals = { "vim" },
      },
      workspace = {
        -- Load Nvim runtime files so completion/references work for the vim api and plugins
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },

      -- Optional: built-in formatting (omit if you don't want it)
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "4",
          quote_style = "auto",
        },
      },

      -- Optional: "semantic" hints and completion behavior
      hint = { enable = true },
      completion = {
        callSnippet = "Replace", -- nebo "Both"/"Disable"
        displayContext = 5,
        keywordSnippet = "Replace",
      },
    },
  },
}
