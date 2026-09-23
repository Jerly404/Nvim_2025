return {
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Next" },
      { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
    },
    opts = {
      options = {
        close_command = function(n)
          Snacks.bufdelete(n)
        end,
        right_mouse_command = function(n)
          Snacks.bufdelete(n)
        end,
        separator_style = "slant",
        always_show_bufferline = false,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = LazyVim.config.icons.diagnostics
          local ret = (diag.error and icons.Error .. diag.error .. " " or "")
            .. (diag.warning and icons.Warn .. diag.warning or "")
          return vim.trim(ret)
        end,
        show_buffer_close_icons = true,
        show_close_icon = false,
        indicator = {
          icon = "▎",
          style = "icon",
        },
        modified_icon = "●",
        offsets = {
          {
            filetype = "neo-tree",
            text = "󰙅 EXPLORER",
            highlight = "NeoTreeDirectoryIcon",
            text_align = "left",
            separator = true,
          },
          {
            filetype = "oil",
            text = "󰏇 OIL BROWSER",
            highlight = "Directory",
            text_align = "left",
          },
        },
      },
      highlights = {
        fill = {
          bg = "NONE",
        },
        background = {
          fg = "#ba94d1",
          bg = "NONE",
        },
        buffer_selected = {
          fg = "#fff0f5",
          bg = "#362032",
          bold = true,
          italic = false,
        },
        buffer_visible = {
          fg = "#ffb6c1",
          bg = "NONE",
        },
        separator = {
          fg = "#2a1f2d",
          bg = "NONE",
        },
        separator_selected = {
          fg = "#2a1f2d",
          bg = "#362032",
        },
        separator_visible = {
          fg = "#2a1f2d",
          bg = "NONE",
        },
        indicator_selected = {
          fg = "#ff69b4",
          bg = "#362032",
        },
        modified = {
          fg = "#ff85c2",
          bg = "NONE",
        },
        modified_selected = {
          fg = "#ff69b4",
          bg = "#362032",
        },
        modified_visible = {
          fg = "#ff85c2",
          bg = "NONE",
        },
        duplicate_selected = {
          fg = "#ffb6c1",
          bg = "#362032",
          italic = true,
        },
        duplicate_visible = {
          fg = "#ba94d1",
          bg = "NONE",
          italic = true,
        },
        duplicate = {
          fg = "#ba94d1",
          bg = "NONE",
          italic = true,
        },
        pick = {
          fg = "#ff1493",
          bg = "NONE",
          bold = true,
        },
        pick_selected = {
          fg = "#ff1493",
          bg = "#362032",
          bold = true,
        },
        pick_visible = {
          fg = "#ff1493",
          bg = "NONE",
          bold = true,
        },
      },
    },
  },
}
