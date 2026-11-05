-- ── Options ───────────────────────────────────────────────────────────────────
local o = vim.opt

o.number         = true
o.relativenumber = true
o.cursorline     = true
o.signcolumn     = "yes"
o.wrap           = false
o.scrolloff      = 8
o.sidescrolloff  = 8
o.expandtab      = true
o.tabstop        = 2
o.shiftwidth     = 2
o.smartindent    = true
o.ignorecase     = true
o.smartcase      = true
o.hlsearch       = false
o.incsearch      = true
o.splitright     = true
o.splitbelow     = true
o.termguicolors  = true
o.undofile       = true
o.swapfile       = false
o.backup         = false
o.updatetime     = 250
o.timeoutlen     = 400
o.clipboard      = "unnamedplus"
o.mouse          = "a"

-- ── Leader ────────────────────────────────────────────────────────────────────
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- ── Keymaps ───────────────────────────────────────────────────────────────────
local map = vim.keymap.set

-- Window navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize
map("n", "<C-Up>",    ":resize -2<CR>")
map("n", "<C-Down>",  ":resize +2<CR>")
map("n", "<C-Left>",  ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- Move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centred when jumping
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n",     "nzzzv")
map("n", "N",     "Nzzzv")

-- Save / quit
map("n", "<leader>w", ":w<CR>",   { desc = "Save" })
map("n", "<leader>q", ":q<CR>",   { desc = "Quit" })
map("n", "<leader>Q", ":qa!<CR>", { desc = "Quit all" })

-- Clear search
map("n", "<Esc>", ":nohlsearch<CR>")

-- Paste without clobbering register
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })

-- File explorer
map("n", "<leader>e", ":Lexplore<CR>", { desc = "Toggle file explorer" })

-- Buffer nav
map("n", "<S-l>", ":bnext<CR>")
map("n", "<S-h>", ":bprevious<CR>")
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- Edit / reload config
map("n", "<leader>ve", ":e $MYVIMRC<CR>",      { desc = "Edit init.lua" })
map("n", "<leader>vr", ":source $MYVIMRC<CR>", { desc = "Reload init.lua" })

-- ── Autocommands ──────────────────────────────────────────────────────────────
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function() vim.highlight.on_yank({ timeout = 150 }) end,
})

-- Trim trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("trim_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})

-- 4-space indent for Python/Rust
autocmd("FileType", {
  group = augroup("filetype_indent", { clear = true }),
  pattern = { "python", "rust" },
  callback = function()
    vim.opt_local.tabstop    = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- ── Colorscheme ───────────────────────────────────────────────────────────────
vim.cmd.colorscheme("habamax")

-- ── Optional plugins (lazy.nvim) ──────────────────────────────────────────────
-- Uncomment to enable. First launch will auto-install everything.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  --[[
  { "catppuccin/nvim", name = "catppuccin", priority = 1000,
    config = function() vim.cmd.colorscheme("catppuccin-mocha") end },
  { "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({ options = { theme = "catppuccin" } })
    end },
  ]]--
  { "nvim-telescope/telescope.nvim", tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>",  desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",    desc = "Buffers" },
    },
  },
  { "nvim-treesitter/nvim-treesitter", branch = "master", build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "python", "bash", "json", "yaml", "toml" },
        highlight = { enable = true },
      })
    end },
  { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
  { "lewis6991/gitsigns.nvim", config = true },
})
