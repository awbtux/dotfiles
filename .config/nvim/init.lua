-- user options/globals
require "user.options"

-- autocmds for different events
require "user.autocmds"

-- keybinds
require "user.keymaps"

-- delete buffers without screwing up win layout
require "user.bufdelete"

-- file containing theme name
local themename = io.open(vim.fn.stdpath("config") .. (vim.fn.has("win32") == 1 and "\\" or "/") .. "colors" .. (vim.fn.has("win32") == 1 and "\\" or "/") .. ".theme_name", "r")

-- set colorscheme
vim.cmd.colorscheme(themename and themename:read("*line") or "default")

-- lazy.nvim package manager
require "user.lazy"
