-- 1. Configure Node.js environment
pcall(function()
  require("config.nodejs").setup({ silent = true })
end)

-- 2. Bootstrap lazy.nvim, LazyVim, and plugins
require("config.lazy")

-- 3. Load custom highlights
pcall(require, "config.highlights")
