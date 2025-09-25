return function(ctx)
  local tsdk = ctx.find_tsdk and ctx.find_tsdk() or nil
  return {
    filetypes = { "vue", "typescript", "javascript", "javascriptreact", "typescriptreact" },
    init_options = tsdk and { typescript = { tsdk = tsdk } } or nil,
  }
end

