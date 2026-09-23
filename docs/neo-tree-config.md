# Configuración de Neo-tree

## Descripción

Neo-tree es un plugin para Neovim que permite explorar el sistema de archivos, buffers y estado de git de manera visual.

## Configuración Aplicada

### Archivos Ocultos

```lua
filesystem = {
  filtered_items = {
    visible = true,          -- Muestra archivos filtrados
    hide_dotfiles = false,   -- Muestra archivos que empiezan con .
    hide_gitignored = false, -- Muestra archivos ignorados por git
    hide_hidden = false,     -- Muestra archivos ocultos
    never_show = {
      ".git",                -- Nunca mostrar .git
    },
  },
}
```

### Ventana

```lua
window = {
  position = "left",   -- Posición a la izquierda
  width = 35,          -- Ancho de la ventana
  background = "#0d0d0d", -- Color de fondo oscuro
  mappings = {
    ["l"] = "open",       -- Abrir archivo/carpeta
    ["h"] = "close_node", -- Cerrar carpeta
    ["<space>"] = "none", -- Desactivar espacio
  },
}
```

### Comandos

- `<leader>fe` - Abrir explorador de archivos
- `<leader>e` - Atajo para explorador (remap)
- `<leader>ge` - Ver estado de git
- `<leader>be` - Ver buffers abiertos

### Atajos de Navegación

- `l` - Entrar/abrir archivo o carpeta
- `h` - Cerrar carpeta
- `Enter` - Abrir archivo

## Ubicación

La configuración está en: `~/.config/nvim/lua/plugins/ui.lua`
