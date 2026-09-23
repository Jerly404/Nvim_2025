# Configuración Neovim - Documentación Completa

## 🎨 Colores y Temas

### Temas Principales (`colorscheme.lua`)

| Color | Nombre | Uso |
|-------|--------|-----|
| **gentleman-kanagawa-blur** | Tema activo principal | Tema personalizado basado en Kanagawa |
| **catppuccin/mocha** | Catppuccin Mocha | Tema secundario disponible |
| **kanagawa/wave** | Kanagawa Wave | Tema oscuro alternativo |

### Configuración de Transparencias

- `transparent_background = true` (Catppuccin y Kanagawa)
- Múltiples elementos con fondo `none`:
  - `LineNr`, `NormalFloat`, `FloatBorder`, `FloatTitle`
  - `TelescopeNormal`, `TelescopeBorder`, `LspInfoBorder`

### Estilos de Comentarios

- `commentStyle = { italic = true }` (Kanagawa)
- `keywordStyle = { italic = true }` (Kanagawa)
- `statementStyle = { bold = true }` (Kanagawa)

---

## 🛠️ Herramientas y Plugins

### 🤖 AI Assistants (Múltiples configurados)

| Plugin | Archivo | Estado |
|--------|---------|--------|
| **Avante.nvim** | `avante.lua` | Disabled |
| **CopilotChat.nvim** | `copilot-chat.lua` | Disabled |
| **Claude Code.nvim** | `claude-code.lua` | Enabled |
| **CodeCompanion.nvim** | `code-companion.lua` | Enabled |
| **Gemini CLI.nvim** | `gemini.lua` | Enabled |

### 📁 Gestión de Archivos

| Plugin | Función |
|--------|---------|
| **Oil.nvim** | Explorador de archivos en buffer |
| **mini-files** | Explorador de archivos (LazyVim) |
| **fzf-lua** | Buscador de archivos fuzzy |

### 🔧 Desarrollo

| Plugin | Función |
|--------|---------|
| **nvim-dap** | Depurador (Debug Adapter Protocol) |
| **nvim-dap-ui** | Interfaz para depurador |
| **nvim-dap-virtual-text** | Texto virtual para depuración |
| **goto-preview** | Vista previa de definiciones |

### 📝 Edición

| Plugin | Función |
|--------|---------|
| **mini-surround** | Surround text (LazyVim) |
| **mini-hipatterns** | Resaltado de patrones |
| **mini-diff** | Diff visual (LazyVim) |
| **vim-multiple-cursors** | Múltiples cursores |
| **nvim-rip-substitute** | Sustituciones con ripgrep |

### 📚 Documentación y Notas

| Plugin | Función |
|--------|---------|
| **Obsidian.nvim** | Integración con Obsidian |
| **render-markdown.nvim** | Renderizado de Markdown |
| **nvim-docs-view** | Vista de documentación |

### 🎨 UI y Visualización

| Plugin | Función |
|--------|---------|
| **lualine.nvim** | Statusline |
| **incline.nvim** | Nombre de archivo flotante |
| **snacks.nvim** | Dashboard y notificaciones |
| **zen-mode.nvim** | Modo distracción-free |
| **twilight.nvim** | Atenuar código inactivo |
| **trouble.nvim** | Lista de diagnósticos |
| **symbols-outline.nvim** | Vista de símbolos |

### 🔍 Búsqueda y Navegación

| Plugin | Función |
|--------|---------|
| **snacks_picker** | Selector de archivos (LazyVim) |
| **harpoon2** | Marcadores rápidos |
| **git.nvim** | Integración Git |
| **which-key.nvim** | Popup de keybindings |

### 🔧 Utilidades

| Plugin | Función |
|--------|---------|
| **nvim-tmux-navigation** | Navegación Tmux |
| **todo-comments.nvim** | Resaltado de TODOs |
| **blink.cmp** | Autocompletado |

---

## ⌨️ Keybindings Principales

### Navegación

| Keybinding | Función |
|------------|---------|
| `<C-h/j/k/l>` | Navegación Tmux panes |
| `<C-\>` | Ultimo pane activo |
| `<C-Space>` | Siguiente pane |
| `-` | Abrir Oil (directorio padre) |
| `<leader>E` | Oil floating |

### AI Assistants

| Keybinding | Función |
|------------|---------|
| `<leader>a` | Grupo AI |
| `<leader>ac` | Toggle Claude Code |
| `<leader>af` | Focus Claude |
| `<leader>aC` | Continue Claude |
| `<leader>am` | Select model Claude |
| `<leader>ab` | Add buffer to Claude |
| `<leader>as` | Send to Claude (visual) |
| `<leader>aa` | Accept diff (Claude) |
| `<leader>ad` | Deny diff (Claude) |

### CodeCompanion

| Keybinding | Función |
|------------|---------|
| `<leader>ac` | Toggle AI Chat |
| `<leader>an` | Nuevo Chat |
| `<leader>aa` | Actions |
| `ga` | Add to Chat (visual) |
| `<leader>ae` | Explain (visual) |

### Depuración (DAP)

| Keybinding | Función |
|------------|---------|
| `<leader>d` | Grupo debug |
| `<leader>dB` | Breakpoint Condition |
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>da` | Run with Args |
| `<leader>dC` | Run to Cursor |
| `<leader>dg` | Go to Line |
| `<leader>di` | Step into |
| `<leader>dj` | Down |
| `<leader>dk` | Up |
| `<leader>dl` | Run Last |
| `<leader>do` | Step Out |
| `<leader>dO` | Step Over |
| `<leader>dp` | Pause |
| `<leader>dr` | Toggle REPL |
| `<leader>ds` | Session |
| `<leader>dt` | Terminate |
| `<leader>dw` | Widgets |

### Obsidian

| Keybinding | Función |
|------------|---------|
| `<leader>o` | Grupo Obsidian |
| `<leader>oc` | Check Checkbox |
| `<leader>ot` | Insert Template |
| `<leader>oo` | Open in App |
| `<leader>ob` | Backlinks |
| `<leader>ol` | Links |
| `<leader>on` | Nueva nota |
| `<leader>os` | Buscar notas |
| `<leader>oq` | Quick switch |

### Utilidades

| Keybinding | Función |
|------------|---------|
| `<leader>fs` | Rip substitute |
| `<leader>sg` | Grep texto seleccionado |
| `<leader>sG` | Grep en raíz |
| `<leader>md` | Eliminar marks |
| `<leader>cs` | Symbols outline |
| `<leader>z` | Zen mode |
| `<Space>cb` | Comentar bloque |
| `<leader>bq` | Eliminar otros buffers |
| `<leader>fb` | Find Buffers |
| `<C-s>` | Guardar archivo |

### Git

| Keybinding | Función |
|------------|---------|
| `<leader>gb` | Git blame |
| `<leader>go` | Git browse |

### Goto Preview

| Keybinding | Función |
|------------|---------|
| `gpd` | Preview definition |
| `gpD` | Preview declaration |
| `gpi` | Preview implementation |
| `gpy` | Preview type definition |
| `gpr` | Preview references |
| `gP` | Close all previews |

---

## ⚙️ Configuración Global

### Opciones principales (`lazy.lua`)

```lua
-- Spell checking
vim.opt.spell = true
vim.opt.spelllang = { "en" }

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- WSL clipboard support
vim.g.clipboard = {
  name = "win32yank",
  copy = { ... },
  paste = { ... }
}

-- Timeouts
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0
```

### LazyVim Extras activados

```lua
-- Editor plugins
{ import = "lazyvim.plugins.extras.editor.harpoon2" }
{ import = "lazyvim.plugins.extras.editor.mini-files" }
{ import = "lazyvim.plugins.extras.editor.snacks_picker" }

-- Debugging
{ import = "lazyvim.plugins.extras.dap.core" }

-- Formatting
{ import = "lazyvim.plugins.extras.formatting.biome" }
{ import = "lazyvim.plugins.extras.formatting.prettier" }

-- Linting
{ import = "lazyvim.plugins.extras.linting.eslint" }

-- Languages
{ import = "lazyvim.plugins.extras.lang.json" }
{ import = "lazyvim.plugins.extras.lang.markdown" }

-- Coding
{ import = "lazyvim.plugins.extras.coding.mini-surround" }
{ import = "lazyvim.plugins.extras.editor.mini-diff" }
{ import = "lazyvim.plugins.extras.coding.blink" }

-- Utilities
{ import = "lazyvim.plugins.extras.util.mini-hipatterns" }

-- AI
{ import = "lazyvim.plugins.extras.ai.copilot" }
```

### LSP Configuration (`overrides.lua`)

- **angularls**: Angular Language Server
- **nil_ls**: Nix Language Server (con nixpkgs-fmt)

---

## 📁 Estructura de Archivos

```
~/.config/nvim/
├── init.lua                    # Entry point
├── lua/
│   ├── config/
│   │   ├── lazy.lua           # Plugin manager config
│   │   ├── keymaps.lua        # Keybindings
│   │   ├── options.lua        # Neovim options
│   │   ├── autocmds.lua       # Autocommands
│   │   ├── nodejs.lua        # Node.js config
│   │   └── gentleman/
│   │       └── utils.lua      # Utilidades HSL
│   └── plugins/
│       ├── avante.lua         # AI Assistant
│       ├── blink.lua          # Autocomplete
│       ├── claude-code.lua    # AI
│       ├── code-companion.lua # AI Chat
│       ├── copilot.lua        # Copilot (disabled)
│       ├── copilot-chat.lua   # Copilot Chat
│       ├── colorscheme.lua    # Temas
│       ├── disabled.lua       # Plugins deshabilitados
│       ├── editor.lua         # Editor plugins
│       ├── fzflua.lua         # Fuzzy finder
│       ├── gemini.lua         # Gemini AI
│       ├── markdown.lua       # Markdown
│       ├── nvim-dap.lua      # Debugging
│       ├── obsidian.lua      # Notes
│       ├── oil.lua           # File explorer
│       ├── overrides.lua     # LSP config
│       ├── rip.lua           # Rip substitute
│       ├── ui.lua            # UI plugins
│       ├── vim-tmux-navigation.lua
│       ├── which-key.lua
│       └── ...
├── spell/
│   ├── es_words.txt          # Palabras español
│   ├── en_words.txt          # Palabras inglés
│   └── en_custom.txt         # Palabras custom
├── stylua.toml               # Formatter config
├── lazyvim.json              # LazyVim config
└── lazy-lock.json            # Lock de plugins
```

---

## 🎯 Características Principales

Esta configuración es muy completa, con énfasis en:

1. **Desarrollo frontend** (Angular, React, TypeScript)
2. **Asistentes AI** (múltiples opciones configuradas)
3. **Productividad** (Tmux, Oil, DAP, Harpoon)
4. **Notas** (Obsidian integration)
5. **Experiencia visual** (temas transparentes, zen mode, twilight)
6. **Debugging** (DAP completo con UI)
7. **Gestión de archivos** (Oil, fzf-lua, mini-files)

---

## 📝 Notas Adicionales

### Plugins Deshabilitados

```lua
- bufferline.nvim
- avante.nvim
- CopilotC-Nvim/CopilotChat.nvim
- opencode.nvim
- codecompanion.nvim
- precognition.nvim
- smear-cursor.nvim
```

### Plugins Habilitados Especiales

- **claude-code.nvim**: Habilitado (AI assistant principal)
- **oil.nvim**: Explorador de archivos nativo
- **obsidian.nvim**: Integración de notas

---

*Documento generado automáticamente desde la configuración de Neovim*
