-- Minimal JDT. For advanced features (code actions, tests, debug) I recommend the "nvim-jdtls" plugin.
return {
  -- mason-lspconfig sets cmd/root_dir automatically
  on_attach = function(client, bufnr)
    -- put Java-specific mappings here; NvChad on_attach is already chained in the loader
  end,
}

