return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.cmdline = {
        view = "cmdline_popup",
      }

      opts.presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true,
      }

      opts.views = {
        cmdline_popup = {
          border = {
            style = "rounded",
            highlight = "NoiceCmdlineBorder",
          },

          position = {
            row = 2,
            col = "50%",
          },

          size = {
            width = 60,
            height = "auto",
          },

          win_options = {
            winhighlight = {
              Normal = "NoiceCmdline",
              FloatBorder = "NoiceCmdlineBorder",
            },
          },
        },
      }
    end,
  },
}
