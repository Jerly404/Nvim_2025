local hl = vim.api.nvim_set_hl

-- Línea activa y Selección (Pink transparente & visible)
hl(0, "CursorLine", { bg = "#362032" })
hl(0, "CursorLineNr", { fg = "#ff69b4", bold = true })
hl(0, "Visual", { bg = "#542d4f", bold = true })
hl(0, "VisualNOS", { bg = "#542d4f" })

-- Noice Popup & Commandline
hl(0, "NoiceCmdline", {
  fg = "#c94c6e",
  bg = "NONE",
})

hl(0, "NoiceCmdlineBorder", {
  fg = "#a86b7a",
  bg = "NONE",
})

hl(0, "NoiceCmdlineIcon", {
  fg = "#b87a96",
})

hl(0, "NoiceCmdlineIconCmdline", {
  fg = "#7a9adc",
})

hl(0, "NoiceCmdlineIconSearch", {
  fg = "#a855a8",
})

hl(0, "FloatBorder", {
  fg = "#c94c6e",
  bg = "NONE",
})

hl(0, "NormalFloat", {
  bg = "NONE",
})

vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", fg = "#a04060" })
vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE", fg = "#a04060" })
