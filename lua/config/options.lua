-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- UI & Aesthetics
opt.termguicolors = true
opt.laststatus = 3 -- Global statusline
opt.showmode = false -- Hide default mode (handled by lualine)
opt.cursorline = true -- Highlight current line
opt.number = true -- Show line numbers
opt.relativenumber = true -- Relative line numbers
opt.signcolumn = "yes" -- Always show signcolumn to avoid jitter
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ", -- Hide '~' on empty lines at end of buffer
}

-- Responsiveness & Timers
opt.timeoutlen = 300 -- Snappy key sequence timeout (default 1000 is too slow)
opt.ttimeoutlen = 0
opt.updatetime = 200 -- Faster cursorhold and git sign updates

-- Clipboard & Editing
opt.clipboard = "unnamedplus"
opt.undofile = true -- Persistent undo
opt.undolevels = 10000
opt.confirm = true -- Confirm to save changes before exiting modified buffer

-- Scrolling & Splits
opt.scrolloff = 8 -- Keep 8 lines above/below cursor
opt.sidescrolloff = 8
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current
opt.splitkeep = "screen"

-- Line Wrapping (Modern & Clean)
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- Search & Completion
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true
opt.pumheight = 10 -- Maximum number of items in popup menu
opt.pumblend = 10 -- Popup blend for modern look

-- PHP / Laravel
vim.g.lazyvim_php_lsp = "intelephense"

