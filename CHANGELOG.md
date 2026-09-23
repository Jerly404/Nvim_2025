# Changelog - Configuración Neovim

## Fecha: 2026-03-17

### ✅ Correcciones Aplicadas

#### 1. init.lua
- **Eliminado**: Duplicación de opciones `vim.opt.wrap`, `vim.opt.linebreak`, `vim.opt.showbreak`
- Estas opciones ahora se manejan desde `config/options.lua`

#### 2. lua/config/options.lua
- **Corregido**: Eliminados keymaps del archivo de opciones
- Ahora solo contiene configuraciones de opciones de Neovim

#### 3. lua/config/keymaps.lua
- **Corregido**: Cambiado de `vim.api.nvim_set_keymap` (viejo) a `vim.keymap.set` (nuevo)
- **Agregado**: Keymaps de clipboard (copiar/pegar del sistema)
- **Corregido**: Eliminado keymap de neo-tree (ya está en neo-tree.lua)
- **Agregado**: Validación pcall para nvim-rip-substitute

#### 4. lua/config/lazy.lua
- **Corregido**: Eliminado `return` innecesario al final del archivo
- **Reorganizado**: Plugins deshabilitados ahora están dentro del `spec` correctamente
- **Corregido**: Habilitado neo-tree (era deshabilitado por error)
- **Optimizado**: Estructura más limpia y funcional

#### 5. lua/plugins/transparency.lua
- **Eliminado**: TokyoNight (nunca se usaba, el tema activo es Kanagawa)
- **Corregido**: Solo contiene configuración de Treesitter

#### 6. lua/config/highlights.lua
- **Eliminado**: Highlights duplicados que causaban conflictos
  - `FloatBorder` (ya definido en colorscheme.lua)
  - `NormalFloat` (ya definido en colorscheme.lua)
  - `NeoTreeNormal` y `NeoTreeNormalNC` (ya definido en colorscheme.lua)
- **Agregado**: Solo保留了 Noice-specific highlights

#### 7. lua/plugins/ui.lua
- **Corregido**: Funciones de CodeCompanion ahora usan `pcall` para evitar errores
- `codecompanion_adapter_name()`: Validación con pcall
- `codecompanion_current_model_name()`: Validación con pcall

---

### 🎨 Tema Aplicado: gentleman-kanagawa-blur

**Nombre del plugin**: `gentleman-kanagawa-blur` (basado en Kanagawa)

#### Características aplicadas:
- `transparent = true` (fondo transparente global)
- Fondo `none` para:
  - Normal, NormalFloat, FloatBorder, FloatTitle
  - LineNr, CursorLine
  - TelescopeNormal, TelescopeBorder, TelescopePromptBorder
  - TelescopeResultsBorder, TelescopePreviewBorder
  - LspInfoBorder
  - NeoTree (todos los componentes)

#### Estilos aplicados:
- `commentStyle = { italic = true }`
- `keywordStyle = { italic = true, bold = true }`
- `statementStyle = { bold = true }`

#### Paleta de colores Johan Liebert (del NVIM_CONFIG_DOCS.md):
| Nombre | Hex |
|--------|-----|
| bright_pink | #ff69b4 |
| soft_pink | #ffb6c1 |
| blossom | #da70d6 |
| lavender | #dda0dd |
| sky | #ff85c2 |
| mint | #b4e4cd |
| coral | #ffb5a7 |
| purple_bright | #8b008b |
| purple_light | #e0b0ff |
| johan_red | #ff6b6b |
| accent | #ff1493 |
| white | #fff0f5 |
| selection | #4a3a5c |
| peach | #ffc0cb |
| cream | #fff5e6 |

---

### 📋 Archivos Modificados

| Archivo | Acción |
|---------|--------|
| `init.lua` | Corregido - eliminado duplicaciones |
| `lua/config/options.lua` | Corregido - solo opciones |
| `lua/config/keymaps.lua` | Corregido - estilo moderno + clipboard + pcall |
| `lua/config/lazy.lua` | Corregido - estructura optimizada + neo-tree habilitado |
| `lua/plugins/transparency.lua` | Corregido - eliminado TokyoNight |
| `lua/config/highlights.lua` | Corregido - eliminado duplicados |
| `lua/plugins/ui.lua` | Corregido - validaciones agregadas |
| `lua/plugins/colorscheme.lua` | Aplicado tema gentleman-kanagawa-blur |

---

### 🔧 Próximos Pasos Recomendados

1. Ejecutar `:Lazy` para sincronizar plugins
2. Reiniciar Neovim para aplicar todos los cambios
3. Verificar que el tema y transparencias funcionan correctamente

---

*Documento generado automáticamente*
