return {

  -- ╭──────────────────────────────────────────────────────────╮
  -- │ 1. MARKDOWN RENDER — Markdown hermoso y legible          │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "Avante" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      file_types = { "markdown", "Avante" },

      code = {
        sign = false,
        width = "block",
        right_pad = 2,
        left_pad = 1,
        position = "center",
      },

      heading = {
        sign = false,
        position = "inline",
        icons = {
          "󰲡 ", -- 1
          "󰲣 ", -- 2
          "󰲥 ", -- 3
          "󰲧 ", -- 4
          "󰲩 ", -- 5
          "󰲫 ", -- 6
          "󰲭 ", -- 7
          "󰲯 ", -- 8
          "󰲱 ", -- 9
          "󰲳 ", -- 10
          "󰲵 ", -- 11
          "󰲷 ", -- 12
          "󰲹 ", -- 13
          "󰲻 ", -- 14
          "󰲽 ", -- 15
        },
      },

      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇", "▶" },
      },

      checkbox = {
        enabled = true,
        unchecked = "󰄱 ",
        checked = "󰄵 ",
        custom = {
          todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
        },
      },
    },
  },

  -- ╭──────────────────────────────────────────────────────────╮
  -- │ 2. ZEN MODE — Modo enfoque absoluto                      │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = {
      { "<leader>zz", "<cmd>ZenMode<cr>", desc = "🧘 Zen Mode — Focus" },
    },
    opts = {
      window = {
        backdrop = 0.95,
        width = 90,
        height = 0.9,
        options = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
          foldcolumn = "0",
          cursorline = false,
        },
      },

      plugins = {
        options = {
          enabled = true,
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = true },
        gitsigns = { enabled = false },
        tmux = { enabled = false },
      },
    },
  },

  -- ╭──────────────────────────────────────────────────────────╮
  -- │ 3. TWILIGHT — Enfoque en bloque actual                   │
  -- ╰──────────────────────────────────────────────────────────╯
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    keys = {
      { "<leader>tw", "<cmd>Twilight<cr>", desc = "🌙 Twilight — Focus block" },
    },
    opts = {
      dimming = {
        alpha = 0.25,
        color = { "Normal", "#ffffff" },
        inactive = true,
      },
      context = 12,
      treesitter = true,
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
        "for_statement",
      },
    },
  },
}
