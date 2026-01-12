return {
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = false,
    priority = 1000,
    opts = {
      compile = true,
      transparent = true, -- Mantiene la estética con el blur de Kitty
      theme = "dragon",
      styles = {
        comment = { italic = true },
        keyword = { italic = true, bold = true }, -- Más presencia
        function_ = { bold = true, italic = false },
        type = { italic = true },
        variable = { italic = false },
      },
      colors = {
        theme = {
          dragon = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        local theme = colors.theme

        -- 🌸 PALETA SAKURA PREMIUM (Más vibrante)
        local sakura = {
          bright_pink = "#ff7eb6", -- Rosa neón pastel
          soft_pink = "#f8c6d8",
          blossom = "#f0a1c2",
          lavender = "#d4bbdf",
          sky = "#a1d6f8", -- Azul más vivo
          mint = "#b8e2d1",
          peach = "#ffb86c",
          white = "#ffffff",
          selection = "#5a3f4d", -- Fondo de selección más claro
          accent = "#f28fad",
        }

        return {
          -- =====================
          -- UI BASE (Más contraste)
          -- =====================
          Normal = { bg = "none", fg = sakura.white },
          NormalFloat = { bg = "none", fg = sakura.soft_pink },
          FloatBorder = { fg = sakura.blossom, bg = "none" },
          CursorLine = { bg = "#2d2a2b" }, -- Sutil resalte de línea
          CursorLineNr = { fg = sakura.bright_pink, bold = true },
          LineNr = { fg = "#5a5255" },

          -- Borde de división de ventanas
          WinSeparator = { fg = sakura.selection, bold = true },

          -- =====================
          -- SYNTAX (Brillante y Pastel)
          -- =====================
          Keyword = { fg = sakura.accent, italic = true, bold = true },
          Statement = { fg = sakura.accent },
          Conditional = { fg = sakura.accent, italic = true },

          Function = { fg = sakura.sky, bold = true }, -- Funciones en azul cielo
          Identifier = { fg = sakura.blossom },
          Variable = { fg = sakura.soft_pink },

          String = { fg = sakura.mint }, -- Strings en menta suave
          Number = { fg = sakura.peach },
          Boolean = { fg = sakura.peach, bold = true },

          Type = { fg = sakura.lavender, italic = true },
          Special = { fg = sakura.bright_pink },
          Comment = { fg = "#6272a4", italic = true }, -- Comandos estilo Dracula para legibilidad

          -- =====================
          -- 🌸 NEO-TREE (Upgrade Visual)
          -- =====================
          NeoTreeNormal = { fg = sakura.soft_pink },
          NeoTreeNormalNC = { fg = sakura.soft_pink },
          NeoTreeRootName = { fg = sakura.bright_pink, bold = true },
          NeoTreeDirectoryName = { fg = sakura.lavender },
          NeoTreeDirectoryIcon = { fg = sakura.lavender },
          NeoTreeExpander = { fg = sakura.accent },

          -- Archivos específicos
          NeoTreeFileName = { fg = sakura.soft_pink },
          NeoTreeSymbolicLinkTarget = { fg = sakura.sky },

          -- Git en Neo-Tree
          NeoTreeGitAdded = { fg = sakura.mint },
          NeoTreeGitModified = { fg = sakura.peach },
          NeoTreeGitDeleted = { fg = sakura.accent },

          -- =====================
          -- TELESCOPE & OTHERS
          -- =====================
          TelescopeBorder = { fg = sakura.blossom },
          TelescopePromptPrefix = { fg = sakura.bright_pink },
          Pmenu = { bg = "#1a1819", fg = sakura.soft_pink }, -- Menú de autocompletado
          PmenuSel = { bg = sakura.selection, fg = sakura.white },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
}
