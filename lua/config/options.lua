vim.opt.clipboard = "unnamedplus"
-- Copiar / pegar explícito al clipboard del sistema
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copiar al clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Pegar del clipboard" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Pegar antes (clipboard)" })
