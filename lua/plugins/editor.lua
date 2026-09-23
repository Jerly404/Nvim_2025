return {
  -- 1. Goto Preview (Floating Definition & Reference Previews)
  {
    "rmagatti/goto-preview",
    event = "BufReadPre",
    opts = function()
      return {
        width = 110,
        height = 25,
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        default_mappings = false,
        resizing_mappings = false,
        post_open_hook = nil,
        focus_on_open = true,
        dismiss_on_move = false,
      }
    end,
    keys = {
      { "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", desc = "Preview Definition" },
      { "gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", desc = "Preview Declaration" },
      { "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", desc = "Preview Implementation" },
      { "gpy", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", desc = "Preview Type Definition" },
      { "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", desc = "Preview References" },
      { "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>", desc = "Close All Previews" },
    },
  },

  -- 2. Mini HiPatterns (Color Previews for Hex, HSL, TailWind)
  {
    "nvim-mini/mini.hipatterns",
    event = "BufReadPre",
    opts = function()
      local hi = require("mini.hipatterns")
      local utils = require("config.gentleman.utils")

      return {
        highlighters = {
          hex_color = hi.gen_highlighter.hex_color(),
          hsl_color = {
            pattern = "hsl%(%d+,? %d+,? %d+%)",
            group = function(_, match)
              local h, s, l = match:match("hsl%((%d+),? (%d+),? (%d+)%)")
              h, s, l = tonumber(h), tonumber(s), tonumber(l)
              local hex_color = utils.hslToHex(h, s, l)
              return hi.compute_hex_color_group(hex_color, "bg")
            end,
          },
        },
      }
    end,
  },
}
