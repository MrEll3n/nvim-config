return {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
  -- note: clangd handles C, C++, and Objective-C. No need for separate "c" and "cpp" servers.
  init_options = {
    clangdFileStatus = true,
  },
  -- setting offsetEncoding helps with some plugins:
  capabilities = { offsetEncoding = { "utf-16" } },
}

