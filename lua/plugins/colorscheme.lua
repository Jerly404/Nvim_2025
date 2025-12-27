return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      -- Habilitamos estilos específicos para que acepten cursivas
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = { "italic" },
        functions = { "bold" },
        keywords = { "italic" },
        strings = {},
        variables = { "italic" }, -- Esto hace que la mayoría del código sea cursiva
        numbers = {},
        booleans = { "bold" },
        properties = {},
        types = { "italic" },
        operators = {},
      },
      custom_highlights = function(colors)
        local c = colors

        -- 🌸 Paleta pastel más intensa
        local pastel = {
          rose = "#f0a1c2",
          pink = "#f8c6d8",
          peach = "#f8b88b",
          mint = "#a7d9c4",
          sky = "#7fc6f5",
          cream = "#f6f1eb",
          coral = "#f28fad",
          lavender = "#c29fd6",
          dark_pink = "#45313d",
        }

        return {
          -- =====================
          -- UI BASE Y TEXTO GENERAL
          -- =====================
          -- Forzamos cursiva en el texto normal si el terminal lo soporta
          Normal = { bg = "none", fg = pastel.cream, italic = true },
          NormalFloat = { bg = "none" },
          FloatBorder = { fg = pastel.pink },
          SignColumn = { bg = "none" },
          CursorLine = { bg = "none" },
          StatusLine = { bg = "none", fg = pastel.rose },

          -- =====================
          -- LINE NUMBERS
          -- =====================
          LineNr = { fg = pastel.lavender },
          CursorLineNr = { fg = pastel.pink, bold = true },

          -- =====================
          -- SELECCIÓN
          -- =====================
          Visual = { bg = pastel.dark_pink },
          VisualNOS = { bg = pastel.dark_pink },

          -- =====================
          -- VARIABLES / KEYS
          -- =====================
          ["@property"] = { fg = pastel.peach, bold = true },
          ["@field"] = { fg = pastel.peach },
          ["@variable"] = { fg = pastel.pink, italic = true },
          ["@variable.builtin"] = { fg = pastel.pink, italic = true },

          -- =====================
          -- FUNCIONES / KEYWORDS / TIPOS
          -- =====================
          ["@function"] = { fg = pastel.rose, bold = true, italic = true },
          ["@keyword"] = { fg = pastel.rose, italic = true },
          ["@type"] = { fg = pastel.sky, italic = true },

          -- =====================
          -- STRINGS / VALORES
          -- =====================
          ["@string"] = { fg = pastel.mint },
          ["@string.escape"] = { fg = pastel.sky },
          ["@string.delimiter"] = { fg = pastel.pink },

          ["@number"] = { fg = pastel.peach },
          ["@boolean"] = { fg = pastel.mint, bold = true },
          ["@constant"] = { fg = pastel.pink },

          ["@operator"] = { fg = pastel.rose },
          ["@comment"] = { fg = pastel.lavender, italic = true },

          -- =====================
          -- 🌸 NEO-TREE (TODO PINK)
          -- =====================
          NeoTreeNormal = { bg = "none", fg = pastel.pink },
          NeoTreeNormalNC = { bg = "none", fg = pastel.pink },

          NeoTreeRootName = { fg = pastel.pink, bold = true, italic = true },
          NeoTreeDirectoryName = { fg = pastel.pink },
          NeoTreeDirectoryIcon = { fg = pastel.pink },

          NeoTreeFileName = { fg = pastel.pink },
          NeoTreeFileIcon = { fg = pastel.pink },

          NeoTreeExpander = { fg = pastel.pink },
          NeoTreeIndentMarker = { fg = pastel.pink },

          -- Estados de Git en el árbol (opcionalmente pink o mantener color)
          NeoTreeGitAdded = { fg = pastel.pink },
          NeoTreeGitModified = { fg = pastel.pink },
          NeoTreeGitDeleted = { fg = pastel.coral },
        }
      end,
    },

    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
