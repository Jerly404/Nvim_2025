return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- Prioridad alta para que cargue al inicio
    priority = 1000,
    opts = {
      transparent = true, -- Transparencia básica
      theme = "dragon", -- Forzamos la variante Dragon
      overrides = function(colors)
        local theme = colors.theme
        return {
          -- Esto asegura que los paneles laterales y ventanas flotantes sean transparentes
          NormalFloat = { bg = "none" },
          FloatBorder = { bg = "none" },
          FloatTitle = { bg = "none" },

          -- Si usas Neo-tree o Nvim-Tree, esto quita su fondo sólido
          NeoTreeNormal = { bg = "none" },
          NeoTreeNormalNC = { bg = "none" },

          -- Quita el fondo de la columna de números y signos
          LineNr = { bg = "none" },
          SignColumn = { bg = "none" },
          StatusLine = { bg = "none" },
        }
      end,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none", -- Elimina el fondo del gutter (donde van los números)
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },

  -- Opcional: Esto asegura que LazyVim reconozca kanagawa como el tema principal
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-dragon",
    },
  },
}
