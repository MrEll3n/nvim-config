---@type Base46Table
local M = {}

-- Převzatá paleta z ashen.nvim (1:1 z tvého snippetu)
local p = {
  -- used for errors
  red_flame = "#C53030", -- Brightest, most intense red
  -- standard red colors
  red_glowing = "#DF6464", -- Slightly deeper glowing red
  red_ember = "#B14242", -- Deep, smoldering ember red

  -- standard orange colors
  orange_glow = "#D87C4A", -- Bright, glowing orange
  orange_blaze = "#C4693D", -- Vibrant blaze orange
  orange_smolder = "#E49A44",

  -- used for warnings
  orange_golden = "#E5A72A",

  -- NOTE: These reds are not widely used and will likely be fazed out in a future update.
  red_kindling = "#BD4C4C", -- Light, warm red
  red_burnt_crimson = "#A84848", -- Muted crimson red
  red_brick = "#853D3D", -- Muted, earthy brick red
  red_deep_ember = "#7A2E2E", -- Dark, deep ember red
  red_ashen = "#6F2929", -- Cool, ashen red

  -- standard misc colors
  blue = "#4A8B8B", -- Muted teal, soft and unobtrusive
  blue_dark = "#3A6E6E", -- Dark teal, ideal for subtle backgrounds
  green_light = "#629C7D",
  green = "#1E6F54",

  -- standard grayscale palette
  background = "#121212",
  g_0 = "#e5e5e5",
  g_1 = "#e5e5e5",
  g_2 = "#d5d5d5",
  g_3 = "#b4b4b4",
  g_4 = "#a7a7a7",
  g_5 = "#949494",
  g_6 = "#737373",
  g_7 = "#535353",
  g_8 = "#323232",
  g_9 = "#212121",
  g_10 = "#1d1d1d",
  g_11 = "#191919",
  g_12 = "#151515",

  -- "normal" colors (autor píše, že nejsou core paleta, ale hodí se nám)
  red = "#C53030", -- Brightest, most intense red
  yellow = "#F4CA64", -- Bright sunflower yellow
  orange = "#D87C4A", -- Bright, glowing orange
  purple = "#7A3D82", -- Rich violet purple
  pink = "#D1728C", -- Deep rose pink
  brown = "#853D3D", -- Muted, earthy brick red
  black = "#121212", -- Deep background black
  white = "#FFFFFF", -- Pure white
  gray = "#A7A7A7", -- Neutral mid-gray
  cyan = "#6E91C4", -- Sky-like cyan
  magenta = "#C9347C", -- Vibrant fuchsia
  lime = "#8CD437", -- Bright lime green
  teal = "#1A3F3F", -- Dark teal
  navy = "#223A70", -- Deep navy blue
  maroon = "#7A2E2E", -- Dark, deep ember red
  olive = "#708238", -- Muted olive green
  indigo = "#502E5F", -- Deep, muted indigo
  violet = "#8E5E93", -- Soft mauve violet
  gold = "#D7A933", -- Rich golden yellow
  silver = "#D5D5D5", -- Soft, muted silver
  beige = "#F5F5DC", -- Light, warm beige
  aqua = "#4AC4C4", -- Bright aqua
  coral = "#E492B4", -- Soft coral pink
}

-- === Odvozené "role" pro NvChad ===
local bg      = p.background          -- hlavní pozadí
local bg_alt  = p.g_11                -- panely, split background
local bg_alt2 = p.g_10                -- cursorline, zvýraznění
local fg      = p.g_1                 -- hlavní text
local fg_dim  = p.g_3                 -- méně důležitý text
local fg_dark = p.g_5                 -- komentáře

local black   = p.black
local darker_black = p.g_12

-- === base_30 – používá NvChad UI (statusline, tabline, tree, atd.) ===
M.base_30 = {
  white        = p.white,
  black        = black,
  darker_black = darker_black,
  black2       = bg_alt,
  one_bg       = bg_alt,   -- hlavní panel pozadí
  one_bg2      = bg_alt2,  -- další level panelu
  one_bg3      = p.g_8,    -- ještě světlejší šedá

  grey         = p.g_6,
  grey_fg      = p.g_5,
  grey_fg2     = p.g_4,
  light_grey   = p.g_3,

  red          = p.red_ember,
  baby_pink    = p.pink,
  pink         = p.coral,

  line         = p.g_9,    -- barva dělicích linek / splitů

  green        = p.green_light,
  vibrant_green = p.green,

  nord_blue    = p.blue_dark,
  blue         = p.blue,
  seablue      = p.cyan,

  yellow       = p.yellow,
  sun          = p.gold,

  purple       = p.purple,
  dark_purple  = p.indigo,

  teal         = p.teal,
  orange       = p.orange_glow,
  cyan         = p.cyan,

  statusline_bg = p.g_10,
  lightbg       = p.g_9,
  pmenu_bg      = p.blue_dark,
  folder_bg     = p.blue,
}

-- === base_16 – generické barvy pro base46 ===
M.base_16 = {
  base00 = bg,        -- main background
  base01 = bg_alt,    -- secondary bg
  base02 = bg_alt2,   -- selection / cursorline
  base03 = p.g_7,     -- comments
  base04 = p.g_4,     -- secondary fg
  base05 = fg,        -- main fg
  base06 = p.white,   -- bright fg
  base07 = p.beige,   -- nejjasnější "světlo"

  base08 = p.red_flame,    -- red
  base09 = p.orange_golden,-- orange / warnings
  base0A = p.yellow,       -- yellow
  base0B = p.green_light,  -- green
  base0C = p.cyan,         -- cyan
  base0D = p.blue,         -- blue / teal
  base0E = p.purple,       -- purple
  base0F = p.maroon,       -- extra accent / types
}

M.type = "dark"

-- === polish_hl – drobné doladění pár klíčových skupin ===
M.polish_hl = {
  Normal      = { fg = fg, bg = bg },
  NormalFloat = { fg = fg, bg = bg_alt },
  FloatBorder = { fg = p.g_6, bg = bg_alt },

  Comment     = { fg = fg_dark, italic = true },

  CursorLine  = { bg = bg_alt2 },
  Visual      = { bg = p.g_8 },

  StatusLine   = { fg = fg_dim, bg = p.g_10 },
  StatusLineNC = { fg = p.g_6,  bg = darker_black },

  VertSplit   = { fg = p.g_9, bg = bg },

  TabLine     = { fg = p.g_5, bg = p.g_9 },
  TabLineSel  = { fg = fg,    bg = p.g_10 },
  TabLineFill = { fg = p.g_6, bg = p.g_9 },
}

-- === Zavoláme skutečný ashen colorscheme po base46 ===
vim.schedule(function()
  -- volitelné: kdybys chtěl custom setup, odkomentuj:
  -- require("ashen").setup({
  --   -- tvoje volby...
  -- })

  vim.cmd("colorscheme ashen")
end)

return M
