return {
  {
    "LazyVim/LazyVim",
    init = function()
      -- Define user commands
      vim.api.nvim_create_user_command("DockerMenu", function()
        require("config.docker").menu()
      end, { desc = "Docker Interactive Menu" })

      vim.api.nvim_create_user_command("DockerScaffold", function()
        require("config.docker").scaffold()
      end, { desc = "Generate Dockerfile and Compose for Project" })

      vim.api.nvim_create_user_command("DockerBuild", function()
        require("config.docker").build_image()
      end, { desc = "Build Docker Image" })

      vim.api.nvim_create_user_command("Lazydocker", function()
        require("config.docker").lazydocker()
      end, { desc = "Open Lazydocker Floating Window" })

      vim.api.nvim_create_user_command("DockerComposeUp", function()
        require("config.docker").compose_up()
      end, { desc = "Run Docker Compose Up -d" })

      vim.api.nvim_create_user_command("DockerComposeDown", function()
        require("config.docker").compose_down()
      end, { desc = "Run Docker Compose Down" })

      vim.api.nvim_create_user_command("DockerComposeRestart", function()
        require("config.docker").compose_restart()
      end, { desc = "Restart Docker Compose Services" })

      vim.api.nvim_create_user_command("DockerComposeLogs", function()
        require("config.docker").compose_logs()
      end, { desc = "View Docker Compose Logs" })

      vim.api.nvim_create_user_command("DockerPrune", function()
        require("config.docker").system_prune()
      end, { desc = "Prune Unused Docker Containers and Images" })
    end,
    keys = {
      {
        "<leader>km",
        function()
          require("config.docker").menu()
        end,
        desc = "Docker Menu",
      },
      {
        "<leader>kd",
        function()
          require("config.docker").lazydocker()
        end,
        desc = "Lazydocker (TUI)",
      },
      {
        "<leader>ks",
        function()
          require("config.docker").scaffold()
        end,
        desc = "Scaffold Project Docker",
      },
      {
        "<leader>kb",
        function()
          require("config.docker").build_image()
        end,
        desc = "Build Docker Image",
      },
      {
        "<leader>ku",
        function()
          require("config.docker").compose_up()
        end,
        desc = "Compose Up (-d)",
      },
      {
        "<leader>kx",
        function()
          require("config.docker").compose_down()
        end,
        desc = "Compose Down",
      },
      {
        "<leader>kr",
        function()
          require("config.docker").compose_restart()
        end,
        desc = "Compose Restart",
      },
      {
        "<leader>kl",
        function()
          require("config.docker").compose_logs()
        end,
        desc = "Compose Logs",
      },
      {
        "<leader>kp",
        function()
          require("config.docker").system_prune()
        end,
        desc = "Docker System Prune",
      },
    },
  },
}
