return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
        },
        severity_sort = true,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = LazyVim.config.icons.diagnostics.Error or " ",
            [vim.diagnostic.severity.WARN] = LazyVim.config.icons.diagnostics.Warn or " ",
            [vim.diagnostic.severity.HINT] = LazyVim.config.icons.diagnostics.Hint or " ",
            [vim.diagnostic.severity.INFO] = LazyVim.config.icons.diagnostics.Info or " ",
          },
        },
      },
      inlay_hints = {
        enabled = false, -- Can be toggled with <leader>uh
      },
      servers = {
        html = {
          filetypes = { "html", "blade" },
        },
        cssls = {},
        jsonls = {},
        pyright = {},
        vtsls = {},
        angularls = {},
        tailwindcss = {
          filetypes_include = { "blade" },
          settings = {
            tailwindCSS = {
              includeLanguages = {
                blade = "html",
                php = "html",
              },
            },
          },
        },
        intelephense = {
          filetypes = { "php", "blade" },
          settings = {
            intelephense = {
              filetypes = { "php", "blade" },
              files = {
                maxSize = 5000000,
              },
              stubs = {
                "apache",
                "bcmath",
                "bz2",
                "calendar",
                "Core",
                "curl",
                "date",
                "dba",
                "dom",
                "enchant",
                "fileinfo",
                "filter",
                "ftp",
                "gd",
                "gettext",
                "hash",
                "iconv",
                "imap",
                "intl",
                "json",
                "ldap",
                "libxml",
                "mbstring",
                "mcrypt",
                "mysql",
                "mysqli",
                "password",
                "pcntl",
                "pcre",
                "PDO",
                "pdo_mysql",
                "pdo_pgsql",
                "Phar",
                "readline",
                "regex",
                "session",
                "SimpleXML",
                "soap",
                "sockets",
                "sodium",
                "standard",
                "superglobals",
                "tokenizer",
                "xml",
                "xdebug",
                "xmlreader",
                "xmlwriter",
                "yaml",
                "zip",
                "zlib",
                "laravel",
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { globals = { "vim", "Snacks", "LazyVim" } },
            },
          },
        },
      },
    },
  },
}
