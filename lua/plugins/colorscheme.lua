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
        local theme = colors.theme

        local johan = {
          bright_pink = "#b8a9c9",       -- lavanda frío suave
          soft_pink = "#d4d0e3",         -- gris lavanda pálido
          blossom = "#a89bb9",           -- lavanda medio
          lavender = "#8b7ea8",          -- lavanda profundo
          sky = "#a3c4d6",               -- azul cielo frío
          mint = "#9ebfb8",              -- verde menta frío
          peach = "#d4b8a0",             -- durazno/apricot suave
          white = "#e8e6f0",             -- blanco con tinte lavanda
          selection = "#3d3843",        -- gris oscuro violeta
          accent = "#c9a8b0",            -- rosa viejo / rojo dusty (bufanda de Johan)
          johan_red = "#c4a4a4",          -- rojo suave signature de Johan
        }

        return {
          -- =====================
          -- UI BASE (Más contraste)
          -- =====================
          Normal = { bg = "none", fg = johan.white },
          NormalFloat = { bg = "none", fg = johan.soft_pink },
          FloatBorder = { fg = johan.blossom, bg = "none" },
          CursorLine = { bg = "#2d2a2b" }, -- Sutil resalte de línea
          CursorLineNr = { fg = johan.bright_pink, bold = true },
          LineNr = { fg = "#5a5255" },

          -- Borde de división de ventanas
          WinSeparator = { fg = johan.selection, bold = true },

          -- =====================
          -- SYNTAX (Brillante y Pastel)
          -- =====================
          Keyword = { fg = johan.accent, italic = true, bold = true },
          Statement = { fg = johan.accent },
          Conditional = { fg = johan.accent, italic = true },

          Function = { fg = johan.sky, bold = true }, -- Funciones en azul cielo
          Identifier = { fg = johan.blossom },
          Variable = { fg = johan.soft_pink },

          String = { fg = johan.mint }, -- Strings en menta suave
          Number = { fg = johan.peach },
          Boolean = { fg = johan.peach, bold = true },

          Type = { fg = johan.lavender, italic = true },
          Special = { fg = johan.bright_pink },
          Comment = { fg = "#6272a4", italic = true }, -- Comandos estilo Dracula para legibilidad

          -- =====================
          -- 🌑 NEO-TREE (Estilo Johan Liebert)
          -- =====================
          NeoTreeNormal = { fg = johan.soft_pink },
          NeoTreeNormalNC = { fg = johan.soft_pink },
          NeoTreeRootName = { fg = johan.bright_pink, bold = true },
          NeoTreeDirectoryName = { fg = johan.lavender },
          NeoTreeDirectoryIcon = { fg = johan.lavender },
          NeoTreeExpander = { fg = johan.accent },

          -- Archivos específicos
          NeoTreeFileName = { fg = johan.soft_pink },
          NeoTreeSymbolicLinkTarget = { fg = johan.sky },

          -- Git en Neo-Tree
          NeoTreeGitAdded = { fg = johan.mint },
          NeoTreeGitModified = { fg = johan.peach },
          NeoTreeGitDeleted = { fg = johan.accent },

          -- =====================
          -- TELESCOPE & OTHERS
          -- =====================
          TelescopeBorder = { fg = johan.blossom },
          TelescopePromptPrefix = { fg = johan.bright_pink },
          Pmenu = { bg = "#1a1819", fg = johan.soft_pink }, -- Menú de autocompletado
          PmenuSel = { bg = johan.selection, fg = johan.white },

          -- =====================
          -- JOHAN LIEBERT ACCENTS
          -- =====================
          Error = { fg = johan.johan_red },
          ErrorMsg = { fg = johan.johan_red },
          Warning = { fg = johan.peach },
        }
      end,
    },
    config = function(_, opts)
      require("kanagawa").setup(opts)
      vim.cmd("colorscheme kanagawa-dragon")
    end,
  },
}
