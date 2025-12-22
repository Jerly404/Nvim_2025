return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = true,
      theme = "dragon",

      colors = {
        palette = {
          -- 🌸 Sakura Core
          sakura = "#f5c2e7",
          sakuraDark = "#d48fbf", -- rosa oscuro elegante (KEYS)
          lavenderDark = "#b48ead", -- lila oscuro clean
          rose = "#f2a7c6",

          -- 🌿 Pasteles
          sky = "#89dceb",
          mint = "#b1e3ad",
          peach = "#f8bd96",

          -- 🧁 Base
          cream = "#f6f1eb",
          pinkMuted = "#c59ac3",
        },
      },

      overrides = function(c)
        local p = c.palette
        return {
          -- =====================
          -- UI LIMPIA
          -- =====================
          Normal = { bg = "none", fg = p.cream },
          NormalFloat = { bg = "none" },
          FloatBorder = { fg = p.sakura },
          StatusLine = { bg = "none", fg = p.sakuraDark },
          SignColumn = { bg = "none" },
          CursorLine = { bg = "none" },

          -- =====================
          -- LINE NUMBERS
          -- =====================
          LineNr = { fg = p.pinkMuted },
          CursorLineNr = { fg = p.sakura, bold = true },

          -- =====================
          -- SELECCIÓN
          -- =====================
          Visual = { bg = "#3b2736" },

          -- =====================
          -- 🔑 KEYS / VARIABLES (ROSA-LILA OSCURO)
          -- =====================
          ["@property"] = {
            fg = p.lavenderDark,
            bold = true,
          },

          ["@field"] = {
            fg = p.lavenderDark,
          },

          ["@variable"] = {
            fg = p.sakuraDark,
          },

          ["@variable.builtin"] = {
            fg = p.lavenderDark,
            italic = true,
          },

          -- =====================
          -- FUNCIONES & KEYWORDS
          -- =====================
          ["@function"] = {
            fg = p.sakura,
            bold = true,
          },

          ["@keyword"] = {
            fg = p.lavenderDark,
            italic = true,
          },

          ["@type"] = {
            fg = p.rose,
          },

          -- =====================
          -- STRINGS (VERDE PASTEL CLEAN)
          -- =====================
          ["@string"] = {
            fg = p.mint,
          },

          ["@string.delimiter"] = {
            fg = p.sakura,
          },

          ["@string.escape"] = {
            fg = p.sky,
          },

          -- =====================
          -- VALORES
          -- =====================
          ["@number"] = {
            fg = p.peach,
          },

          ["@boolean"] = {
            fg = p.mint,
            bold = true,
          },

          ["@constant"] = {
            fg = p.lavenderDark,
          },

          ["@operator"] = {
            fg = p.sakuraDark,
          },

          ["@comment"] = {
            fg = p.pinkMuted,
            italic = true,
          },

          -- =====================
          -- 🌸 NEO-TREE (MÁS PINK, CLEAN)
          -- =====================
          NeoTreeNormal = { bg = "none", fg = p.cream },
          NeoTreeNormalNC = { bg = "none", fg = p.cream },

          NeoTreeRootName = {
            fg = p.sakura,
            bold = true,
          },

          NeoTreeDirectoryName = {
            fg = p.sakuraDark,
            bold = true,
          },

          NeoTreeDirectoryIcon = {
            fg = p.sakura,
          },

          NeoTreeFileName = {
            fg = p.lavenderDark,
          },

          NeoTreeFileIcon = {
            fg = p.rose,
          },

          NeoTreeGitAdded = {
            fg = p.mint,
          },

          NeoTreeGitModified = {
            fg = p.peach,
          },

          NeoTreeGitDeleted = {
            fg = "#f28fad", -- rojo pastel
          },

          NeoTreeIndentMarker = {
            fg = p.pinkMuted,
          },
        }
      end,
    },

    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-dragon",
    },
  },
}
