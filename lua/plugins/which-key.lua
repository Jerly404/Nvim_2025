return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "classic",
      win = { border = "rounded" },
      spec = {
        {
          mode = { "n", "v" },
          { "<leader>a", group = "AI / Claude" },
          { "<leader>b", group = "Buffer" },
          { "<leader>c", group = "Code" },
          { "<leader>d", group = "Debug" },
          { "<leader>e", group = "Explorer" },
          { "<leader>f", group = "File / Find" },
          { "<leader>g", group = "Git" },
          { "<leader>gh", group = "Hunks" },
          { "<leader>k", group = "Docker / Containers" },
          { "<leader>l", group = "Laravel" },
          { "<leader>D", group = "Database (Dadbod)" },
          { "<leader>o", group = "Obsidian" },
          { "<leader>q", group = "Quit / Session" },
          { "<leader>s", group = "Search / Grep" },
          { "<leader>t", group = "Terminal" },
          { "<leader>u", group = "UI" },
          { "<leader>z", group = "Zen Mode" },
          { "gp", group = "Goto Preview" },
        },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Local Keymaps",
      },
    },
  },
}
