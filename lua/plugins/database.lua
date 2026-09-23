return {
  {
    "kristijanhusak/vim-dadbod-ui",
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUILastQueryInfo",
    },
    keys = {
      { "<leader>D", "<cmd>DBUIToggle<cr>", desc = "Toggle DBUI (Database Explorer)" },
      { "<leader>Df", "<cmd>DBUIFindBuffer<cr>", desc = "Find DB Buffer" },
      { "<leader>Dr", "<cmd>DBUILastQueryInfo<cr>", desc = "Last Query Result" },
      {
        "<leader>Dq",
        "<cmd>%DB<cr>",
        desc = "Execute SQL Buffer",
        ft = { "sql", "mysql", "plsql" },
      },
      {
        "<leader>Dq",
        ":'<,'>DB<cr>",
        mode = "v",
        desc = "Execute Selected SQL",
        ft = { "sql", "mysql", "plsql" },
      },
    },
  },
}
