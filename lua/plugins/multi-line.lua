return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "BufReadPost",
    init = function()
      vim.g.VM_theme = "purplegray"
      vim.g.VM_show_warnings = 0
      vim.g.VM_silent_exit = 1
    end,
  },
}
