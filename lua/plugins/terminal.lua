-- ~/.config/nvim/lua/config/terminal.lua
return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      transparent = true,
      highlights = {
        Normal = {
          bg = "NONE",
        },
        NormalFloat = {
          bg = "NONE",
        },
      },
    },
  },
}
