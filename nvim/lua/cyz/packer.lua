-- This file can be loaded by calling `lua require('plugins')` from your init.vim

vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
      -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use ({ "catppuccin/nvim", as = "catppuccin" })
    use 'lervag/vimtex'
    use ({ 'VonHeikemen/lsp-zero.nvim', 
        requires = {
            {'folke/tokyonight.nvim'},
            {'neovim/nvim-lspconfig'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/nvim-cmp'},
            {'L3MON4D3/LuaSnip'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},
        }
    })
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })

--    use({
--        'nanozuki/tabby.nvim',
--        requires = { 'nvim-tree/nvim-web-devicons' },
--        config = function()
--            -- put config opts here
--        end
--    })

    use "DanilaMihailov/beacon.nvim"
    use "stevearc/dressing.nvim"

    use({
      "ziontee113/icon-picker.nvim",
      config = function()
        require("icon-picker").setup({
          disable_legacy_commands = true
        })
      end,
    })



    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.4',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
          -- vim.cmd('colorscheme rose-pine')
        end
    })

    use 'cyzhou1028/alabaster.nvim'

--    use 'samueljoli/cyberpunk.nvim'

--    use({
--        "andrewferrier/wrapping.nvim",
--        config = function()
--            require("wrapping").setup()
--        end,
--    })   

    -- Install with configuration

    use({
      'projekt0n/github-nvim-theme',
      config = function()
        require('github-theme').setup({
          -- ...
        })

        -- vim.cmd('colorscheme github_dark')
      end
    })

    use ({ 'thedenisnikulin/vim-cyberpunk' })

    use ({ 'echasnovski/mini.hipatterns' })

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,}
    use("nvim-treesitter/playground")
    use("theprimeagen/harpoon")
    use("mbbill/undotree")
    use("nvim-treesitter/nvim-treesitter-context");


end)

