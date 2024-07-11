-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
require('lspconfig').jedi_language_server.setup {}
require('lazy').setup {
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            local configs = require 'nvim-treesitter.configs'
            configs.setup {
                ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'cpp', 'python' },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            }
        end,
    },
}

return {
    -- add symbols-outline
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        -- or
        dependencies = { 'nvim-lua/plenary.nvim' },
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
    },
}

