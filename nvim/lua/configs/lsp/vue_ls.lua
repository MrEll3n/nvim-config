-- Vue LSP (Volar) v "Take Over" režimu: pokrývá i TS/JS soubory v monorepech s Vue
return {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
  init_options = {
    typescript = {
      -- pokud používáš Mason, tsdk najdeš tady:
      tsdk = vim.fn.stdpath("data")
        .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
    },
  },
}

