require "nvchad.options"

-- add yours here!

local o = vim.o
o.cursorlineopt ='both' -- to enable cursorline!
local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- Auto-detect OS
local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
local is_macos = vim.fn.has("mac") == 1
local is_linux = not is_windows and not is_macos

if is_windows then
  -- PowerShell Core on Windows
  opt.shell = "pwsh.exe"
  opt.shellcmdflag = "-NoLogo -NoProfileLoadTime -ExecutionPolicy RemoteSigned -Command"
  opt.shellquote = ""
  opt.shellxquote = ""

elseif is_macos then
  -- macOS - use zsh
  opt.shell = "/bin/zsh"
  opt.shellcmdflag = "-c"
  opt.shellquote = ""
  opt.shellxquote = ""

elseif is_linux then
  -- Linux / Unix
  if vim.fn.executable("/usr/bin/zsh") == 1 then
    opt.shell = "/usr/bin/zsh"
  else
    opt.shell = "/bin/bash"
  end

  opt.shellcmdflag = "-c"
  opt.shellquote = ""
  opt.shellxquote = ""
end
