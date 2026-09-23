return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        lua = { "stylua" },
        javascript = { "prettier", "biome", stop_after_first = true },
        javascriptreact = { "prettier", "biome", stop_after_first = true },
        typescript = { "prettier", "biome", stop_after_first = true },
        typescriptreact = { "prettier", "biome", stop_after_first = true },
        json = { "prettier", "biome", stop_after_first = true },
        jsonc = { "prettier", "biome", stop_after_first = true },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        python = { "black", "ruff_format", stop_after_first = true },
        php = { "pint", "php_cs_fixer", stop_after_first = true },
        blade = { "blade-formatter" },
        sql = { "sqlfluff" },
      },
      formatters = {
        pint = {
          prepend_args = function(self, ctx)
            local local_config = vim.fs.find({ "pint.json" }, { upward = true, path = ctx.filename })[1]
            if local_config then
              return {}
            end
            local global_config = vim.fn.stdpath("config") .. "/pint.json"
            if vim.uv.fs_stat(global_config) then
              return { "--config=" .. global_config }
            end
            return { "--preset=psr12" }
          end,
        },
        php_cs_fixer = {
          prepend_args = function(self, ctx)
            local local_config = vim.fs.find({
              ".php-cs-fixer.php",
              ".php-cs-fixer.dist.php",
            }, { upward = true, path = ctx.filename })[1]
            if local_config then
              return {}
            end
            return { '--rules={"@PSR12": true, "concat_space": {"spacing": "one"}}' }
          end,
        },
      },
    },
  },
}
