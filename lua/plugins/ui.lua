local mode = {
  "mode",
  fmt = function(s)
    local mode_map = {
      ["NORMAL"] = "N",
      ["O-PENDING"] = "N?",
      ["INSERT"] = "I",
      ["VISUAL"] = "V",
      ["V-BLOCK"] = "VB",
      ["V-LINE"] = "VL",
      ["V-REPLACE"] = "VR",
      ["REPLACE"] = "R",
      ["COMMAND"] = "!",
      ["SHELL"] = "SH",
      ["TERMINAL"] = "T",
      ["EX"] = "X",
      ["S-BLOCK"] = "SB",
      ["S-LINE"] = "SL",
      ["SELECT"] = "S",
      ["CONFIRM"] = "Y?",
      ["MORE"] = "M",
    }
    return mode_map[s] or s
  end,
}

local my_lualine_theme = {
  normal = {
    a = { bg = "#B7BDF7", fg = "#1a1a1a", gui = "bold" },
    b = { bg = "#2a1f2d", fg = "#ffb6c1" },
    c = { bg = "none", fg = "#ffb6c1" },
  },

  insert = {
    a = { bg = "#f5c6e0", fg = "#1a1a1a", gui = "bold" },
    b = { bg = "#2a1f2d", fg = "#f5c6e0" },
    c = { bg = "none", fg = "#f5c6e0" },
  },

  visual = {
    a = { bg = "#FFCBCB", fg = "#1a1a1a", gui = "bold" },
    b = { bg = "#2a1f2d", fg = "#d8b4ff" },
    c = { bg = "none", fg = "#d8b4ff" },
  },

  replace = {
    a = { bg = "#ff6b6b", fg = "#1a1a1a", gui = "bold" },
    b = { bg = "#2a1f2d", fg = "#ff6b6b" },
    c = { bg = "none", fg = "#ff6b6b" },
  },

  command = {
    a = { bg = "#FDEFEF", fg = "#1a1a1a", gui = "bold" },
    b = { bg = "#2a1f2d", fg = "#ffc0cb" },
    c = { bg = "none", fg = "#ffc0cb" },
  },
}

local function codecompanion_adapter_name()
  local ok, cc = pcall(require, "codecompanion")
  if not ok then return nil end
  local chat = cc.buf_get_chat(vim.api.nvim_get_current_buf())
  if not chat or not chat.adapter then return nil end
  return " " .. chat.adapter.formatted_name
end

local function codecompanion_current_model_name()
  local ok, cc = pcall(require, "codecompanion")
  if not ok then return nil end
  local chat = cc.buf_get_chat(vim.api.nvim_get_current_buf())
  if not chat or not chat.settings then return nil end
  return chat.settings.model
end

local function docker_project_indicator()
  local root = vim.fs.root(0, { "Dockerfile", "docker-compose.yml", "compose.yaml", "compose.yml" })
  if root then
    return "󰡨 docker"
  end
  return ""
end

return {
  -- Plugin: folke/todo-comments.nvim
  { "folke/todo-comments.nvim", version = "*" },

  -- Plugin: nvim-docs-view
  {
    "amrbashir/nvim-docs-view",
    lazy = true,
    cmd = "DocsViewToggle",
    opts = {
      position = "right",
      width = 60,
    },
  },

  -- Plugin: lualine.nvim
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = my_lualine_theme
      opts.options.icons_enabled = true
      opts.options.globalstatus = true

      opts.sections = opts.sections or {}
      opts.sections.lualine_a = {
        {
          "mode",
          icon = ".☘︎ ݁˖",
        },
      }

      opts.sections.lualine_x = opts.sections.lualine_x or {}
      table.insert(opts.sections.lualine_x, 1, {
        docker_project_indicator,
        color = { fg = "#ff85c2", gui = "bold" },
      })

      opts.extensions = opts.extensions or {}
      vim.list_extend(opts.extensions, {
        "quickfix",
        {
          filetypes = { "oil" },
          sections = {
            lualine_a = {
              mode,
            },
            lualine_b = {
              function()
                local ok, oil = pcall(require, "oil")
                if not ok then
                  return ""
                end

                local dir = oil.get_current_dir()
                if not dir then return "" end
                local path = vim.fn.fnamemodify(dir, ":~")
                return path .. " %m"
              end,
            },
          },
        },
        {
          filetypes = { "codecompanion" },
          sections = {
            lualine_a = { mode },
            lualine_b = { codecompanion_adapter_name },
            lualine_c = { codecompanion_current_model_name },
            lualine_x = {},
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = { codecompanion_adapter_name },
            lualine_c = {},
            lualine_x = {},
            lualine_y = { "progress" },
            lualine_z = {},
          },
        },
      })
    end,
  },

  -- Plugin: incline.nvim
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      require("incline").setup({
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if filename == "" then
            filename = "[No Name]"
          end
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end

          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- Plugin: zen-mode.nvim
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      plugins = {
        gitsigns = true,
        tmux = true,
        kitty = { enabled = false, font = "+2" },
        twilight = { enabled = true },
      },
    },
    keys = { { "<leader>z", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
  },

  -- Plugin: snacks.nvim
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Find Buffers",
      },
    },
    opts = {
      notifier = {},
      image = {},
      picker = {
        exclude = {
          ".git",
          "node_modules",
        },
        matcher = {
          fuzzy = true,
          smartcase = true,
          ignorecase = true,
          filename_bonus = true,
        },
      },
      dashboard = {
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
          { section = "startup" },
        },
        preset = {
          header = [[
   ⣤⣤⣤⠄⣀⠉⣉⣙⠒⠤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⠤⠒⣉⠉⣀⠠⣤⣤⣤
   ⣿⣧⠻⠇⠋⠀⠋⠀⢘⣿⢳⣦⣌⠳⠄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠞⣡⣴⣧⠻⣄⢸⣿⣿⡟⢁
   ⢿⣧⣙⠶⣿⣿⡷⢘⣡⣿⣿⣿⣷⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⣿⣿⣿⣷⣝⡳⠶⠶⠾
   ⠀⠀⠉⠻⣿⣶⠂⠘⠛⠛⠛⢛⡛⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠛⠀⠉⠒⠛⠀⠀
          ]],
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = "󰡨 ", key = "d", desc = "Docker / Containers", action = ":DockerMenu" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },
    },
  },
}
