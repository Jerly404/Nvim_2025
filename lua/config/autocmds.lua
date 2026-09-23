-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- 1. Highlight on Yank (Modern smooth feedback)
autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    (vim.hl or vim.highlight).on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

-- 2. Auto-resize splits when terminal window is resized
autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- 3. Return to last edit position when opening a file
autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit", "gitrebase" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- 4. Close auxiliary windows with 'q'
autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "checkhealth",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "neotest-summary",
    "neotest-output-panel",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true, desc = "Close Buffer" })
  end,
})

-- 5. Auto create parent directories when saving a file
autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- 6. Enable wrap and spell for prose / text files
autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown", "txt" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- 7. Blade template settings
autocmd("FileType", {
  group = augroup("blade_settings"),
  pattern = "blade",
  callback = function()
    vim.bo.commentstring = "{{-- %s --}}"
  end,
})

-- 8. Auto-register Laravel / project database for vim-dadbod
local function auto_register_env_db()
  local root = vim.fs.root(0, { "artisan", "composer.json", ".env" })
  if not root then
    return
  end
  local env_file = root .. "/.env"
  if vim.fn.filereadable(env_file) ~= 1 then
    return
  end

  local f = io.open(env_file, "r")
  if not f then
    return
  end

  local env = {}
  for line in f:lines() do
    local k, v = line:match("^([%w_]+)%s*=%s*(.*)$")
    if k and v then
      v = v:gsub('^["\']', ""):gsub('["\']$', "")
      env[k] = v
    end
  end
  f:close()

  local conn = env.DB_CONNECTION or "pgsql"
  local db_name = env.DB_DATABASE
  if not db_name or db_name == "" then
    return
  end

  local app_name = env.APP_NAME or "Laravel"
  local url = nil

  if conn == "pgsql" or conn == "postgres" or conn == "postgresql" then
    local user = env.DB_USERNAME or "postgres"
    local pass = env.DB_PASSWORD or ""
    local host = env.DB_HOST or "127.0.0.1"
    local port = env.DB_PORT or "5432"
    local auth = user
    if pass ~= "" then
      auth = auth .. ":" .. pass
    end
    url = string.format("postgresql://%s@%s:%s/%s", auth, host, port, db_name)
  elseif conn == "mysql" or conn == "mariadb" then
    local user = env.DB_USERNAME or "root"
    local pass = env.DB_PASSWORD or ""
    local host = env.DB_HOST or "127.0.0.1"
    local port = env.DB_PORT or "3306"
    local auth = user
    if pass ~= "" then
      auth = auth .. ":" .. pass
    end
    url = string.format("mysql://%s@%s:%s/%s", auth, host, port, db_name)
  elseif conn == "sqlite" then
    url = string.format("sqlite:%s", db_name)
  end

  if url then
    local dbs = vim.g.dbs or {}
    local name = string.format("%s (%s)", app_name, conn)
    if type(dbs) == "table" and not vim.islist(dbs) then
      dbs[name] = url
    elseif vim.islist(dbs) then
      local exists = false
      for _, item in ipairs(dbs) do
        if item.name == name then
          item.url = url
          exists = true
          break
        end
      end
      if not exists then
        table.insert(dbs, { name = name, url = url })
      end
    else
      dbs = { { name = name, url = url } }
    end
    vim.g.dbs = dbs
  end
end

autocmd({ "BufEnter", "DirChanged" }, {
  group = augroup("dadbod_auto_env"),
  callback = function()
    auto_register_env_db()
  end,
})


