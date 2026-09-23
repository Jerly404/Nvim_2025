-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- 1. General & Editing Quality of Life
-- Fast escape
map({ "i", "n", "v" }, "<C-c>", [[<C-\><C-n>]], { desc = "Escape to Normal Mode" })

-- Delete word forward in insert mode
map("i", "<C-b>", "<C-o>de", { desc = "Delete word forward in insert mode" })

-- Better indenting (keeps visual selection)
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move lines up and down
map("n", "<A-j>", "<cmd>m .+1<cr>==g", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==g", { desc = "Move line up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move line down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Clear search highlight with <Esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Window Resizing with Ctrl + Arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- 2. Tmux & Neovim Seamless Navigation
local ok_tmux, nvim_tmux_nav = pcall(require, "nvim-tmux-navigation")
if ok_tmux then
  map("n", "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft, { desc = "Navigate Left" })
  map("n", "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown, { desc = "Navigate Down" })
  map("n", "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp, { desc = "Navigate Up" })
  map("n", "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight, { desc = "Navigate Right" })
  map("n", "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive, { desc = "Navigate Last Active" })
end

-- 3. File Explorer & Management
map("n", "-", "<CMD>Oil<CR>", { desc = "Open Parent Directory (Oil)" })

-- 4. Screenkey Toggle
map("n", "<leader>uk", "<cmd>Screenkey<CR>", { desc = "Toggle Screenkey" })

-- 5. Obsidian Shortcuts
map("n", "<leader>oc", "<cmd>Obsidian check<CR>", { desc = "Obsidian Check Checkbox" })
map("n", "<leader>ot", "<cmd>Obsidian template<CR>", { desc = "Insert Obsidian Template" })
map("n", "<leader>oo", "<cmd>Obsidian open<CR>", { desc = "Open in Obsidian App" })
map("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "Show Obsidian Backlinks" })
map("n", "<leader>ol", "<cmd>Obsidian links<CR>", { desc = "Show Obsidian Links" })
map("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "Create New Note" })
map("n", "<leader>os", "<cmd>Obsidian search<CR>", { desc = "Search Obsidian" })
map("n", "<leader>oq", "<cmd>Obsidian quick-switch<CR>", { desc = "Obsidian Quick Switch" })

-- 6. Visual Grep Selected Text
map("v", "<leader>sg", function()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local lines = vim.fn.getline(start_pos[2], end_pos[2])

  if #lines == 0 then return end
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end

  local selected_text = table.concat(lines, "\n")
  selected_text = vim.fn.escape(selected_text, "\\.*[]^$()+?{}")

  if pcall(require, "snacks") then
    Snacks.picker.grep({ search = selected_text })
  elseif pcall(require, "fzf-lua") then
    require("fzf-lua").live_grep({ search = selected_text })
  end
end, { desc = "Grep Selected Text" })

-- 7. Utility: Clear Marks
map("n", "<leader>md", function()
  vim.cmd("delmarks!")
  vim.cmd("delmarks A-Z0-9")
  vim.notify("All marks deleted", vim.log.levels.INFO, { title = "Marks" })
end, { desc = "Delete All Marks" })
