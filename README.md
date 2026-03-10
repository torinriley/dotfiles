# nvim

> minimal. fast. mine.
```
 ██████   █████                    ███
░░██████ ░░███                    ░░░
 ░███░███ ░███  █████ ████ █████  ████  █████████
 ░███░░███░███ ░░███ ░███ ███░░  ░░███ ░█░░░░███
 ░███ ░░██████  ░███ ░███░░█████  ░███ ░   ███░
 ░███  ░░█████  ░███ ░███ ░░░░███ ░███   ███░   █
 █████  ░░█████ ░░████████ ██████  █████ █████████
░░░░░    ░░░░░   ░░░░░░░░ ░░░░░░  ░░░░░ ░░░░░░░░░
```

personal neovim config. no bloat. just what works.

---

## stack

| layer | plugin |
|---|---|
| plugin manager | `lazy.nvim` |
| theme | `onedark` (disabled in ghostty) |
| statusline | `lualine` |
| file tree | `neo-tree` + `oil.nvim` |
| fuzzy find | `telescope` |
| lsp | `nvim-lspconfig` + `mason` |
| completion | `nvim-cmp` + `luasnip` |
| syntax | `nvim-treesitter` |
| ai | `codeium` |
| git | `gitsigns` |
| terminal | `toggleterm` |
| format | `conform.nvim` |
| nav | `harpoon2` |

---

## keymaps

**leader = `space`**
```
<leader>ff   find file
<leader>fg   live grep
<leader>fr   recent files
<leader>e    toggle file tree
<leader>w    save
<leader>q    quit
<leader>rn   rename symbol
<leader>ca   code action
<leader>a    harpoon add
<leader>m    harpoon menu
<leader>1-4  harpoon jump
C-\          toggle terminal
gd           go to definition
K            hover docs
```

---

## lsp

auto-installed via mason:
- `lua_ls`
- `pyright`
- `ts_ls`

---

## terminal detection

theme and transparency are conditionally applied based on `$TERM_PROGRAM`:

- **ghostty** → transparent background, no colorscheme
- **everything else** → onedark

---

## install
```bash
git clone https://github.com/torinriley/dotfiles ~/.config/nvim
nvim  # lazy.nvim bootstraps on first launch
```

---

<p align="right"><sub>built for speed. tuned for flow.</sub></p>
