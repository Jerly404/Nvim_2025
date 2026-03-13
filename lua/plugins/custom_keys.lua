return {
  {
    "LazyVim/LazyVim",
    keys = {
      -- Guardar + formatear
      {
        "<C-s>",
        function()
          vim.lsp.buf.format()
          vim.cmd("write")
        end,
        desc = "Format and save buffer",
      },

      -- Comentario tipo bloque SOLO en TypeScript
      {
        "<leader>cb",
        function()
          -- Inserta el bloque de comentario
          vim.api.nvim_put({ "/*", " * ", " */" }, "l", true, true)

          -- Mueve el cursor a la línea del *
          vim.cmd("normal! kA")
        end,
        desc = "Insert block comment",
        ft = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "java",
          "c",
          "cpp",
          "css",
          "scss",
          "go",
          "rust",
        },
      },
    },
  },
}
