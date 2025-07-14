<a href="https://dotfyle.com/DaanHoogendoorn/confignvim"><img src="https://dotfyle.com/DaanHoogendoorn/confignvim/badges/plugins?style=flat" /></a>
<a href="https://dotfyle.com/DaanHoogendoorn/confignvim"><img src="https://dotfyle.com/DaanHoogendoorn/confignvim/badges/leaderkey?style=flat" /></a>
<a href="https://dotfyle.com/DaanHoogendoorn/confignvim"><img src="https://dotfyle.com/DaanHoogendoorn/confignvim/badges/plugin-manager?style=flat" /></a>

# Neovim Config

A modular, modern Neovim configuration with a focus on maintainability, plugin modularity, and language support.

---

## Features

- **Modular plugin management**: Each plugin in its own file under `lua/custom/plugins/`
- **Custom configuration**: Utilities, snippets, and helpers in `lua/custom/config/`
- **Comprehensive LSP support**: Custom LSP configs for many languages in `after/lsp/`
- **Modern UI/UX**: Statusline, colorscheme, notifications, and more
- **AI/Completion**: Copilot, CopilotChat, and more
- **Fuzzy finding/picking**: Powered by the snacks picker

---

## Installation

> Requires Neovim 0.9+  
> Always review code before installing any configuration.

Clone this repository into your Neovim config directory:

```sh
git clone git@github.com:DaanHoogendoorn/config.nvim ~/.config/nvim
```

Launch Neovim and install plugins:

```sh
nvim
# Then run :Lazy sync
```

Update Treesitter parsers (recommended):

```sh
:TSUpdate
```

---

## Directory Structure

- `init.lua` – Entry point
- `lua/custom/plugins/` – Modular plugin specifications
- `lua/custom/config/` – Custom config, snippets, utilities
- `after/lsp/` – Per-language LSP configuration. Also used for auto installation of LSP servers.

---

## Notable Plugins

- **AI/Completion**: Copilot, CopilotChat, Supermaven
- **UI/UX**: catppuccin, lualine, noice, dressing, blink, snacks
- **Editing**: autopairs, autotag, surround, treesitter, treesj, highlightundo
- **Git**: gitsigns, octo
- **Fuzzy Finder / Picker**: snacks
- **LSP**: nvim-lspconfig, mason, fidget, sonarlint, lazydev
- **Formatting/Linting**: conform, nvim-lint
- **Snippets**: LuaSnip, friendly-snippets
- **File Explorer**: mini.files
- **Keybinding**: which-key
- **Troubleshooting**: trouble, todo-comments, ts-comments

(See `lua/custom/plugins/` for the full list.)

---

## Supported Language Servers

Custom LSP configs for:

- CSS (`cssls`, `css-variables-language-server`)
- Emmet (`emmet_language_server`)
- Go (`gopls`)
- HarperDB (`harper_ls`)
- HTML (`html`)
- JSON (`jsonls`)
- Lua (`lua_ls`)
- Markdown (`marksman`)
- PHP (`phpactor`)
- Rust (`rust_analyzer`)
- Sass (`somesass_ls`)
- SonarLint (`sonarlint-language-server`)
- TypeScript (`ts_ls`)
- YAML (`yamlls`)

---

## Usage & Maintenance

- **Install Plugins:** `:Lazy sync`
- **Update Plugins:** `:Lazy update`
- **Update Treesitter Parsers:** `:TSUpdate`
- **Lint/Format:** `stylua .` (uses `.stylua.toml`)
- **Test:** Launch Neovim and verify config/plugins load without errors

---

## License

MIT
