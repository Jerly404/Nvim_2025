return {
  {
    "LazyVim/LazyVim",
    keys = {
      {
        "<C-s>",
        function()
          vim.lsp.buf.format() -- formatea el buffer
          vim.cmd("write") -- guarda el archivo
        end,
        desc = "Format and save buffer",
      },
    },
  },
}
