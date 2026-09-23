-- =============================================================================
-- Premium Aesthetics & Visual Enhancements
-- =============================================================================
-- Smooth animations, interactive scrollbars, and dynamic visual indicators.

return {
  -- 1. Smooth Scrolling Animation
  {
    "karb94/neoscroll.nvim",
    event = "BufReadPre",
    opts = {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor = true,
      stop_eof = true,
      use_local_scrolloff = false,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      easing_function = "quadratic",
      duration_multiplier = 0.7,
    },
  },

  -- 2. Modern Interactive Scrollbar with Diagnostics
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    opts = {
      show = true,
      handle = {
        text = " ",
        color = "#45475a",
        hide_if_all_visible = true,
      },
      marks = {
        Search = { color = "#ffb6c1" },
        Error = { color = "#ff6b6b" },
        Warn = { color = "#ffb5a7" },
        Info = { color = "#ff85c2" },
        Hint = { color = "#b4e4cd" },
        Misc = { color = "#dda0dd" },
      },
      handlers = {
        gitsigns = false,
        search = false,
      },
    },
  },

  -- 3. Dynamic Mode Color Indicator (Tintado Pink para Insert y Visual)
  {
    "mvllow/modes.nvim",
    tag = "v0.2.0",
    event = "VeryLazy",
    opts = {
      colors = {
        copy = "#ffb5a7",
        delete = "#ff6b6b",
        insert = "#ff85c2", -- Rosa suave brillante cuando escribes
        visual = "#da70d6", -- Orquídea/rosa pastel para selección visual
      },
      line_opacity = 0.22, -- Opacidad visible pero transparente
      set_cursor = true,
      set_cursorline = true,
      set_number = true,
      ignore_filetypes = { "NvimTree", "TelescopePrompt", "fzf", "oil", "neo-tree", "dashboard", "snacks_dashboard" },
    },
  },
}
