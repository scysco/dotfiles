local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
augroup packer_user_config
autocmd!
autocmd BufWritePost plugins.lua source <afile> | PackerSync
augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- Basic plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use 'lewis6991/impatient.nvim'
  use 'tami5/sqlite.lua'

  -- My plugins here
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use 'kyazdani42/nvim-web-devicons'
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"
  use 'mg979/vim-visual-multi'
  use 'kevinhwang91/rnvimr'

  use 'nvim-lualine/lualine.nvim'
  use 'Mofiqul/dracula.nvim'
  use 'marko-cerovac/material.nvim'
  use 'folke/tokyonight.nvim'

  use {
    "rcarriga/nvim-notify",
    event = "VimEnter",
    config = function()
      vim.notify = require "notify"
    end,
  }

  -- cmp plugins
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-nvim-lsp-document-symbol"

  -- snippets
  -- use "L3MON4D3/LuaSnip" --snippet engine
  -- use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  use 'Neevash/awesome-flutter-snippets'

  -- use 'dsznajder/vscode-es7-javascript-react-snippets'
  use {'dsznajder/vscode-es7-javascript-react-snippets',
    run = 'yarn install --frozen-lockfile && yarn compile'
  }
  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server nvim-lsp-installer
  use 'jose-elias-alvarez/null-ls.nvim'
  -- use 'MunifTanjim/eslint.nvim'
  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use "AckslD/nvim-neoclip.lua"
  -- use 'nvim-telescope/telescope-media-files.nvim'

  -- Project
  use "ahmedkhalf/project.nvim"

  -- Alpha
  use 'goolord/alpha-nvim'

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'windwp/nvim-ts-autotag'

  -- Git
  use 'lewis6991/gitsigns.nvim'

  -- which key
  use "folke/which-key.nvim"

  -- ToggleTerm
  use 'akinsho/toggleterm.nvim'
  -- Flutter
  use 'akinsho/flutter-tools.nvim'
  -- Debug
  use 'mfussenegger/nvim-dap'
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
