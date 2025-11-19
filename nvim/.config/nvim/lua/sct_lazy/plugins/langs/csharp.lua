-- [[ lsp/csharp.lua ]]
-- defines functions for plugins to call on setup
-- this confines csharp configuration to this file

return {
    -- [ tree-sitter ensure list ]
    ts_ensure_list = function()
        return 'c_sharp', 'xml'
    end,

    lsp_setup = function()
        local lsp_caps = require('cmp_nvim_lsp').default_capabilities()

        require('mason-lspconfig').setup({
            ensure_installed = { 'omnisharp' },
            handlers = {
                omnisharp = function()
                    require('lspconfig').csharp_language_server.setup({
                        capabilities = lsp_caps,
                    })
                end
            }
        })
    end,
}
