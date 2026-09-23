return {
  -- 1. Laravel.nvim: Artisan commands, routes, tinker, resources & hub
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    cmd = { "Laravel" },
    ft = { "php", "blade" },
    keys = {
      { "<leader>la", "<cmd>Laravel artisan<cr>", desc = "Artisan Commands" },
      { "<leader>lr", "<cmd>Laravel routes<cr>", desc = "Routes List" },
      { "<leader>lm", "<cmd>Laravel related<cr>", desc = "Related Files (Model/Ctrl/View)" },
      { "<leader>lt", "<cmd>Laravel tinker<cr>", desc = "Tinker REPL" },
      { "<leader>lh", "<cmd>Laravel hub<cr>", desc = "Laravel Hub" },
      { "<leader>lo", "<cmd>Laravel resources<cr>", desc = "Resources" },
      { "<leader>lc", "<cmd>Laravel commands<cr>", desc = "Commands" },
    },
    opts = {},
  },

  -- 2. Blade Navigation: Jump to components, views, config & env preview
  {
    "ricardoramirezr/blade-nav.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "blade", "php" },
    opts = {
      close_tag_on_complete = true,
    },
  },

  -- 3. Mason tool installation for Laravel, PHP & Database
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "intelephense",
        "blade-formatter",
        "php-debug-adapter",
        "php-cs-fixer",
        "pint",
        "sqlfluff",
      })
    end,
  },
}
