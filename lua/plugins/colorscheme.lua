return {
  {
    "rebelot/kanagawa.nvim",
    name = "kanagawa",
    lazy = false,
    priority = 1000,
    opts = {
      compile = true,
      transparent = true,
      theme = "dragon",
      styles = {
        comment = { italic = true },
        keyword = { italic = true, bold = true },
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
        local johan = {
          bright_pink = "#ff69b4", -- rosa brillante
          soft_pink = "#ffb6c1", -- rosa pastel
          blossom = "#da70d6", -- orquídea
          lavender = "#dda0dd", -- ciruela/lavanda pastel
          sky = "#ff85c2", -- rosa cielo brillante
          mint = "#b4e4cd", -- verde menta pastel
          peach = "#ffc0cb", -- rosa claro/tolete pastel
          white = "#fff0f5", -- blanco lavanda
          selection = "#542d4f", -- rosa violeta oscuro para selección
          cursorline_pink = "#362032", -- rosa oscuro sutil para la línea activa
          accent = "#ff1493", -- rosa profundo brillante
          johan_red = "#ff6b6b", -- rojo pastel
          purple_bright = "#8b008b", -- púrpura oscuro
          purple_light = "#e0b0ff", -- púrpura pastel
          coral = "#ffb5a7", -- coral pastel
          cream = "#fff5e6", -- crema pastel
        }

        return {
          -- =====================
          -- UI BASE (Línea activa y Selección Pink)
          -- =====================
          Normal = { bg = "none", fg = johan.white },
          NormalNC = { bg = "none", fg = johan.white },
          NormalFloat = { bg = "none", fg = johan.soft_pink },
          FloatBorder = { fg = johan.purple_bright, bg = "none" },
          CursorLine = { bg = johan.cursorline_pink }, -- Resalte sutil rosa de línea activa
          CursorLineNr = { fg = johan.bright_pink, bold = true },
          LineNr = { fg = "#5a5255" },
          Visual = { bg = johan.selection, bold = true }, -- Selección visual a juego en tono rosa/violeta
          VisualNOS = { bg = johan.selection },

          -- Borde de división de ventanas
          WinSeparator = { fg = johan.purple_bright, bold = true },

          -- =====================
          -- SYNTAX (Brillante y Pastel)
          -- =====================
          Keyword = { fg = johan.accent, italic = true, bold = true },
          Statement = { fg = johan.accent },
          Conditional = { fg = johan.accent, italic = true },

          Function = { fg = johan.sky, bold = true }, -- Funciones en rosa cielo
          Identifier = { fg = johan.blossom },
          Variable = { fg = johan.soft_pink },

          String = { fg = johan.mint }, -- Strings en menta suave
          Number = { fg = johan.coral },
          Boolean = { fg = johan.coral, bold = true },

          Type = { fg = johan.lavender, italic = true },
          Special = { fg = johan.bright_pink },
          Comment = { fg = "#ba94d1", italic = true }, -- Lavanda pastel para comentarios

          -- =====================
          -- 🌑 NEO-TREE (Estilo Johan Liebert)
          -- =====================
          NeoTreeNormal = { fg = johan.soft_pink, bg = "#0d0d0d" },
          NeoTreeNormalNC = { fg = johan.soft_pink, bg = "#0d0d0d" },
          NeoTreeRootName = { fg = johan.bright_pink, bold = true },
          NeoTreeDirectoryName = { fg = johan.purple_light },
          NeoTreeDirectoryIcon = { fg = johan.blossom },
          NeoTreeExpander = { fg = johan.accent },
          NeoTreeFloat = { bg = "#0d0d0d" },
          NeoTreeFloatBorder = { fg = johan.purple_bright, bg = "#0d0d0d" },
          NeoTreeTitleBar = { fg = johan.cream, bg = johan.purple_bright },
          NeoTreeVertSplit = { fg = johan.purple_bright },
          NeoTreeWinSeparator = { fg = johan.purple_bright },

          -- Archivos específicos
          NeoTreeFileName = { fg = johan.soft_pink },
          NeoTreeFileNameOpened = { fg = johan.bright_pink },
          NeoTreeSymbolicLinkTarget = { fg = johan.sky },
          NeoTreeMarkdownLink = { fg = johan.sky, underline = true },

          -- Git en Neo-Tree
          NeoTreeGitAdded = { fg = johan.mint },
          NeoTreeGitModified = { fg = johan.coral },
          NeoTreeGitDeleted = { fg = johan.johan_red },
          NeoTreeGitConflict = { fg = johan.accent },
          NeoTreeGitUntracked = { fg = johan.purple_light },

          -- Indent lines
          NeoTreeIndentMarker = { fg = johan.lavender },

          -- =====================
          -- TELESCOPE & OTHERS
          -- =====================
          TelescopeBorder = { fg = johan.purple_bright },
          TelescopePromptBorder = { fg = johan.purple_bright },
          TelescopeResultsBorder = { fg = johan.blossom },
          TelescopePreviewBorder = { fg = johan.lavender },
          TelescopePromptPrefix = { fg = johan.bright_pink },
          Pmenu = { bg = "#1a1819", fg = johan.soft_pink },
          PmenuSel = { bg = johan.selection, fg = johan.white },

          -- =====================
          -- ACCENTS
          -- =====================
          Error = { fg = johan.johan_red },
          ErrorMsg = { fg = johan.johan_red },
          Warning = { fg = johan.coral },
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
