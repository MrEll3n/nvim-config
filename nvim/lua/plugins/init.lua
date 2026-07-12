return {
    {
        "folke/which-key.nvim",
        lazy = false,
    },
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        opts = require("configs.conform"),
    },
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("configs.lspconfig").setup()
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = require("configs.mason"),
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
    },
    {
        "folke/trouble.nvim",
        lazy = false,
        opts = {},
        cmd = "Trouble",
    },
    {
        "folke/todo-comments.nvim",
        lazy = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        -- build = "make install_jsregexp"
    },
    {
        "ficcdaf/ashen.nvim",
        -- optional but recommended,
        -- pin to the latest stable release:
        lazy = false,
        priority = 1000,
        config = function()
            -- require("ashen").setup({ ... })
            vim.cmd("colorscheme ashen")
        end,
        opts = {},
    },
    -- {
    --   "stevearc/oil.nvim",
    --   lazy = false,  -- fine to leave as-is, Oil itself recommends not lazy-loading
    --   dependencies = { { "echasnovski/mini.icons", opts = {} } },
    --   -- which-key v3 "Suggested Spec" - the mappings also show up in NvCheatsheet
    --   keys = {
    --     { "<leader>o",  group = "Oil" },
    --     { "<leader>oo", function() require("oil").open() end,                                      desc = "Open (here)",  mode = "n" },
    --     { "<leader>of", function() require("oil").open_float() end,                                desc = "Open (float)", mode = "n" },
    --     { "<leader>or", function() require("oil").refresh() end,                                   desc = "Refresh",      mode = "n" },
    --     { "<leader>ou", function() require("oil").open("..") end,                                  desc = "Up directory", mode = "n" },
    --     { "<leader>oh", function() require("oil").set_columns({ "icon","permissions","size","mtime" }) end,
    --                                                                                                desc = "Show columns", mode = "n" },
    --     { "<leader>ot", "<cmd>Oil --float<CR>",                                                    desc = "Toggle float", mode = "n" },
    --   },
    --   -- keep your detailed Oil settings in configs.oil (it can include buffer keymaps with desc too)
    --   opts = require "configs.oil",
    -- }

    -- test new blink
    -- { import = "nvchad.blink.lazyspec" },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "lua",
                "vim",
                "vue",
                "typescript",
                "tsx",
                "javascript",
                "html",
                "css",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        },
    },
    {
        "joosepalviste/nvim-ts-context-commentstring",
        lazy = true,
    },
    {
        "nvim-tree/nvim-tree.lua",
        lazy = false,
        opts = require("configs.nvimtree"),
    },
    {
        "fei6409/log-highlight.nvim",
        opts = {},
    },
    -- {
    --   "sphamba/smear-cursor.nvim",
    --   event = "VeryLazy",
    --   opts = require "configs.smear-cursor",
    -- },
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        opts = require("configs.neoscroll"),
    },
}
