-- Resolve Mason root directory.
-- Mason v2 no longer exposes get_install_path() via registry,
-- so we rely on either $MASON or the default stdpath("data")/mason.
local mason_root = vim.fn.expand("$MASON")
if mason_root == "" then
  mason_root = vim.fn.stdpath("data") .. "/mason"
end

-- Path to the Vue TypeScript plugin shipped inside the vue-language-server package.
local vue_ts_plugin = mason_root
  .. "/packages/vue-language-server/node_modules/@vue/language-server"

-- Uncomment to debug the resolved path:
-- print("Vue TS Plugin path:", vue_ts_plugin)

return {
  -- Allow TS LSP to attach to .vue files as well.
  filetypes = {
    "typescript",
    "typescriptreact",
    "javascript",
    "javascriptreact",
    "vue",
  },

  single_file_support = false,

  init_options = {
    plugins = {
      {
        -- Official Vue TypeScript plugin name.
        name = "@vue/typescript-plugin",

        -- Path we constructed above.
        location = vue_ts_plugin,

        -- Files that should use this plugin.
        languages = { "vue" },
      },
    },
  },
}
