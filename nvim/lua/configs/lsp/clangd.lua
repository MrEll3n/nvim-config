return {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
  init_options = {
    clangdFileStatus = true,
  },
  capabilities = { offsetEncoding = { "utf-16" } },
}

