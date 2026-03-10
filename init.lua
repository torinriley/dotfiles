-- LEADER KEY (must be before lazy)
vim.g.mapleader = " "
-- OPTIONS
vim.opt.shortmess:append("I")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 9
vim.opt.updatetime = 51
vim.opt.clipboard = "unnamedplus"
-- BOOTSTRAP lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim", lazypath })
end
vim.opt.rtp:prepend(lazypath)
-- PLUGINS
require("lazy").setup({
   {
      "navarasu/onedark.nvim",
      priority = 1001,
      config = function()
         if vim.env.TERM_PROGRAM ~= "ghostty" then
            vim.o.background = "dark"
            vim.cmd.colorscheme("onedark")
         end
      end
   },
   {
      "goolord/alpha-nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
         local dashboard = require("alpha.themes.dashboard")
         dashboard.section.buttons.val = {
            dashboard.button("e", "  New file", ":ene <BAR> startinsert<CR>"),
            dashboard.button("SPC fr", "  Recent files", ":Telescope oldfiles<CR>"),
            dashboard.button("SPC ff", "  Find file", ":Telescope find_files<CR>"),
            dashboard.button("SPC fg", "  Find text", ":Telescope live_grep<CR>"),
            dashboard.button("q", "  Quit", ":qa<CR>"),
         }
         require("alpha").setup(dashboard.config)
      end
   },
   {
      "nvim-lualine/lualine.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
         require("lualine").setup({ options = { theme = vim.env.TERM_PROGRAM ~= "ghostty" and "onedark" or "auto" } })
      end
   },
   {
      "stevearc/oil.nvim",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
         require("oil").setup()
         vim.keymap.set("n", "-", "<cmd>Oil<cr>")
      end
   },
   {
      "nvim-telescope/telescope.nvim",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
         local b = require("telescope.builtin")
         vim.keymap.set("n", "<leader>ff", b.find_files)
         vim.keymap.set("n", "<leader>fg", b.live_grep)
         vim.keymap.set("n", "<leader>fb", b.buffers)
      end
   },
   {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
         require("nvim-treesitter").setup({
            ensure_installed = { "lua", "python", "javascript", "typescript", "c", "cpp" },
            highlight = { enable = true },
            indent = { enable = true }
         })
      end
   },
   {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
      config = function()
         vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<cr>")
      end
   },
   {
      "neovim/nvim-lspconfig",
      dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
      config = function()
         require("mason").setup()
         require("mason-lspconfig").setup({ ensure_installed = { "lua_ls", "pyright", "ts_ls" }, automatic_installation = true })
         vim.lsp.config("lua_ls", {})
         vim.lsp.config("pyright", {})
         vim.lsp.config("ts_ls", {})
         vim.lsp.enable({ "lua_ls", "pyright", "ts_ls" })
         vim.keymap.set("n", "gd", vim.lsp.buf.definition)
         vim.keymap.set("n", "K", vim.lsp.buf.hover)
         vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
         vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
      end
   },
   {
      "hrsh7th/nvim-cmp",
      dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip" },
      config = function()
         local cmp = require("cmp")
         local ls = require("luasnip")
         cmp.setup({
            snippet = { expand = function(a) ls.lsp_expand(a.body) end },
            mapping = cmp.mapping.preset.insert({
               ["<C-Space>"] = cmp.mapping.complete(),
               ["<CR>"] = cmp.mapping.confirm({ select = true }),
               ["<Tab>"] = cmp.mapping(function(fb) if cmp.visible() then cmp.select_next_item() else fb() end end,
                  { "i", "s" }),
            }),
            sources = cmp.config.sources({ { name = "nvim_lsp" }, { name = "luasnip" }, { name = "buffer" }, { name = "path" } }),
         })
      end
   },
   { "windwp/nvim-autopairs",   event = "InsertEnter", config = true },
   { "lewis6991/gitsigns.nvim", config = true },
   { "numToStr/Comment.nvim",   config = true },
   {
      "akinsho/toggleterm.nvim",
      version = "*",
      config = function()
         require("toggleterm").setup({
            size = 15,
            open_mapping = [[<C-\>]],
            direction = "horizontal",
            shell = vim.o.shell,
         })
      end
   },
   {
      "stevearc/conform.nvim",
      config = function()
         require("conform").setup({
            formatters_by_ft = {
               python = { "black" },
               javascript = { "prettier" },
               typescript = { "prettier" },
               lua = { "stylua" },
            },
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
         })
      end
   },
   {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = function()
         local harpoon = require("harpoon")
         harpoon:setup()
         vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
         vim.keymap.set("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
         vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
         vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
         vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
         vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
      end
   },
   { "Exafunction/codeium.vim", event = "BufEnter" },
})
-- KEYMAPS
vim.keymap.set("n", "<leader>fr", require("telescope.builtin").oldfiles)
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>")
vim.keymap.set("n", "<leader>r", ":w<CR>:!python %<CR>")
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>")
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<cr>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- TRANSPARENCY (ghostty only)
if vim.env.TERM_PROGRAM == "ghostty" then
   vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = function()
         vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
         vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      end,
   })
   vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
   vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end
