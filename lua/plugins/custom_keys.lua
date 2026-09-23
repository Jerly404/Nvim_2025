return {
  {
    "LazyVim/LazyVim",
    keys = {
      -- Format and save file with Ctrl+S (Normal & Insert mode), exiting to Normal mode
      {
        "<C-s>",
        function()
          vim.cmd("stopinsert")
          if vim.fn.mode():find("[vV\x16]") then
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
          end
          LazyVim.format({ force = true })
          vim.cmd("silent! write")
          vim.notify("Formatted & Saved!", vim.log.levels.INFO, { title = "Format" })
        end,
        mode = { "n", "i", "v" },
        desc = "Format and Save",
      },

      -- Block comment helper (<leader>cb)
      {
        "<leader>cb",
        function()
          vim.api.nvim_put({ "/*", " * ", " */" }, "l", true, true)
          vim.cmd("normal! kA")
        end,
        desc = "Insert Block Comment",
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
