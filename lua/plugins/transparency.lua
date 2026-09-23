return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    opts = {
      extra_groups = {
        -- Floating windows & popups
        "NormalFloat",
        "FloatBorder",
        "FloatTitle",
        "FloatFooter",

        -- Neo-tree side panel explorer
        "NeoTreeNormal",
        "NeoTreeNormalNC",
        "NeoTreeWinSeparator",
        "NeoTreeEndOfBuffer",

        -- Bufferline (Top tab bar)
        "BufferLineFill",
        "BufferLineBackground",
        "BufferLineTab",
        "BufferLineTabSelected",
        "BufferLineBuffer",
        "BufferLineBufferSelected",
        "BufferLineSeparator",
        "BufferLineSeparatorSelected",

        -- Statusline
        "StatusLine",
        "StatusLineNC",

        -- UI columns
        "SignColumn",
        "MsgArea",
        "EndOfBuffer",
        "WinSeparator",
      },
      exclude_groups = {
        -- Keep cursor line & visual selection visible
        "CursorLine",
        "CursorLineNr",
        "Visual",
      },
    },
  },
}
