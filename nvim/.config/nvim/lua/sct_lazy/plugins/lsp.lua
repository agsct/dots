-- [[ lsp config ]]
-- consists of:
-- - nvim-lspconfig -> provides default nvim lsp client configurations for lsp servers
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
    },
    config = function()
        -- [ general configs ]
        require('mason').setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        local cmp = require('cmp')
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn['vsnip#anonymous'](args.body) -- set vsnip as engine
                end,
            },
            mapping = require('sct_lazy.maps').plugins.cmp(),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
            }, {
                { name = 'buffer' },
            })
        })

        local lsp_caps = require('cmp_nvim_lsp').default_capabilities()
        require('mason-lspconfig').setup({
            handlers = {
                function(server_name) -- default handler
                    require('lspconfig')[server_name].setup({
                        capabilities = lsp_caps
                    })
                end,
            }
        })

        -- [ language specific configurations ]
        require('sct_lazy.plugins.langs.lua').lsp_setup()
        require('sct_lazy.plugins.langs.rust').lsp_setup()

        -- [ create autocmds ]
        require('sct_lazy.autocmd').plugins.lsp()
    end,
}
