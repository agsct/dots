return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.install').prefer_git = true
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                require('sct_lazy.plugins.langs.lua').ts_ensure_list(),
                require('sct_lazy.plugins.langs.rust').ts_ensure_list(),
            },
            highlight = {
                enable = true,
            },
            indent = { enable = true },
        })
    end,
}
