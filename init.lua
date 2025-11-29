-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.wrap = true -- Habilita que el texto se ajuste a la ventana
vim.opt.linebreak = true -- Evita cortar palabras a la mitad
vim.opt.showbreak = "↳ " -- Indica visualmente cuando una línea se divide
