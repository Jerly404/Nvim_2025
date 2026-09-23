return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<C-t>", "<cmd>ToggleTerm direction=float<cr>", mode = { "n", "i", "t" }, desc = "Toggle Floating Terminal" },
      { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Floating Terminal" },
      { "<leader>th", "<cmd>ToggleTerm direction=horizontal size=15<cr>", desc = "Toggle Horizontal Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=60<cr>", desc = "Toggle Vertical Terminal" },
    },
    opts = {
      open_mapping = [[<C-t>]],
      hide_numbers = true,
      shade_terminals = false,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "float",
      close_on_exit = true,
      float_opts = {
        border = "rounded",
        winblend = 0,
        title_pos = "center",
      },
      highlights = {
        Normal = { bg = "NONE" },
        NormalFloat = { bg = "NONE" },
        FloatBorder = { fg = "#cba6f7", bg = "NONE" },
      },
    },
  },
}
