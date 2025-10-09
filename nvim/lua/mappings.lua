-- require "nvchad.mappings" -- has been turned off for better readability and customization

-----------------------------  Default NVChad config  -----------------------------

local map = vim.keymap.set

map("i", "<C-b>", "<ESC>^i", { desc = "move beginning of line" })
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "general clear highlights" })

map("n", "<C-s>", "<cmd>w<CR>", { desc = "general save file" })
map("n", "<C-c>", "<cmd>%y+<CR>", { desc = "general copy whole file" })

map("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "General toggle line number" })
map("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "General toggle relative number" })
map("n", "<leader>ch", "<cmd>NvCheatsheet<CR>", { desc = "General toggle nvcheatsheet" })

map({ "n", "x" }, "<leader>fm", function()
  require("conform").format { lsp_fallback = true }
end, { desc = "General format file" })

-- global lsp mappings
map("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "LSP diagnostic loclist" })

-- tabufline
if require("nvconfig").ui.tabufline.enabled then
  map("n", "<leader>b", "<cmd>enew<CR>", { desc = "Buffer new" })

  map("n", "<tab>", function()
    require("nvchad.tabufline").next()
  end, { desc = "Buffer goto next" })

  map("n", "<S-tab>", function()
    require("nvchad.tabufline").prev()
  end, { desc = "Buffer goto prev" })

  map("n", "<leader>x", function()
    require("nvchad.tabufline").close_buffer()
  end, { desc = "Buffer close" })
end

-- Comment
map("n", "<leader>/", "gcc", { desc = "General toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "General toggle comment", remap = true })

-- nvimtree
map("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "NVIMTree toggle window" })
map("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "NVIMTree focus window" })

-- telescope
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Telescope live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope help page" })
map("n", "<leader>ma", "<cmd>Telescope marks<CR>", { desc = "Telescope find marks" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope find oldfiles" })
map("n", "<leader>fz", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope find in current buffer" })
map("n", "<leader>cm", "<cmd>Telescope git_commits<CR>", { desc = "Telescope git commits" })
map("n", "<leader>gt", "<cmd>Telescope git_status<CR>", { desc = "Telescope git status" })
map("n", "<leader>pt", "<cmd>Telescope terms<CR>", { desc = "Telescope pick hidden term" })

map("n", "<leader>th", function()
  require("nvchad.themes").open()
end, { desc = "Telescope nvchad themes" })

map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Telescope find files" })
map(
  "n",
  "<leader>fa",
  "<cmd>Telescope find_files follow=true no_ignore=true hidden=true<CR>",
  { desc = "Telescope find all files" }
)

-- terminal
map("t", "<C-x>", "<C-\\><C-N>", { desc = "Terminal escape terminal mode" })
 
-- new terminals
map("n", "<leader>h", function()
  require("nvchad.term").new { pos = "sp" }
end, { desc = "Terminal new horizontal term" })

map("n", "<leader>v", function()
  require("nvchad.term").new { pos = "vsp" }
end, { desc = "Terminal new vertical term" })

-- toggleable
map({ "n", "t" }, "<A-v>", function()
  require("nvchad.term").toggle { pos = "vsp", id = "vtoggleTerm" }
end, { desc = "Terminal toggleable vertical term" })

map({ "n", "t" }, "<A-h>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "Terminal toggleable horizontal term" })

map({ "n", "t" }, "<A-i>", function()
  require("nvchad.term").toggle { pos = "float", id = "floatTerm" }
end, { desc = "Terminal toggle floating term" })

-- whichkey
map("n", "<leader>wK", "<cmd>WhichKey <CR>", { desc = "Whichkey all keymaps" })

map("n", "<leader>wk", function()
  vim.cmd("WhichKey " .. vim.fn.input "WhichKey: ")
end, { desc = "Whichkey query lookup" })

-----------------------------  Custom config  -----------------------------

-- General
map("n", ";", ":", { desc = "General enter command mode" })
map("i", "kj", "<esc>", { desc = "General Escape in insert mode" })
map({"n"}, "<leader>.", "<cmd>lua vim.diagnostic.open_float()<cr>", { desc = "Diagnostics Open Float Diagnostic" })
map("n", "<leader>lg", "<cmd>LazyGit<cr>", { desc = "General Open LazyGit" })
map({"n", "i", "v"}, "<c-a>", "ggVG", { desc = "General Selects all text" })

-- Trouble keymaps
map("n", "<leader>td", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble Diagnostics (Trouble)" })
map("n", "<leader>tD", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble Buffer Diagnostics (Trouble)" })
map("n", "<leader>ts", "<cmd>Trouble symbos toggle focus=false<cr>", { desc = "Trouble Symbols (Trouble)" })
map("n", "<leader>tl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "Trouble LSP Definitions / References / ... (Trouble)" })
map("n", "<leader>tL", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble Location List (Trouble)" })
map("n", "<leader>tq", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble Quickfix List (Trouble)" })

-- Telescope keymaps - custom
map("n", "<leader>fi", "<cmd>Telescope lsp_implemetation<cr>", { desc = "Telescope Find Implementations" })
map("n", "<leader>fd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Telescope Find Definitions" })


-------------  Oil mappings  -------------
-- map("t", "<Leader><ESC>", "<C-\\><C-n>", { desc = "Escape Terminal" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")


 -------------  Oil mappings  -------------
-- local function in_oil() return vim.bo.filetype == "oil" end
-- local act = function() retu rn require("oil.actions") end
--
-- map("n", "<C-s>", function() if in_oil() then act().select.callback({ vertical = true }) else vim.cmd("silent! write") end end,
--   { desc = "Oil: Open vsplit  | Save file" })
-- map("n", "<C-h>", function() if in_oil() then act().select.callback({ horizontal = true }) else vim.cmd("wincmd h") end end,
--   { desc = "Oil: Open split   | Window left" })
-- map("n", "<C-t>", function() if in_oil() then act().select.callback({ tab = true }) else vim.cmd("tabnew") end end,
--   { desc = "Oil: Open tab     | New tab" })
-- map("n", "<C-l>", function() if in_oil() then act().refresh.callback() else vim.cmd("wincmd l") end end,
--   { desc = "Oil: Refresh      | Window right" })
-- map("n", "<C-p>", function() if in_oil() then act().preview.callback() else vim.cmd("bprevious") end end,
--   { desc = "Oil: Preview      | Prev buffer" })
-- map("n", "q", function() if in_oil() then act().close.callback() else vim.cmd("close") end end,
--   { desc = "Oil: Close        | Close window" })


