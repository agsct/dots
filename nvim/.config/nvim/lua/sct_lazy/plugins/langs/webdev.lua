-- [[ lsp/webdev.lua ]]
-- defines functions for plugins to call on setup
-- this confines webdev configuration to this file

return {
    -- [ tree-sitter ensure list ]
    ts_ensure_list = function()
        return 'html', 'css', 'javascript'
    end,

    lsp_setup = function()
        local webdev_lsp_caps = require('cmp_nvim_lsp').default_capabilities()
        webdev_lsp_caps.textDocument.completion.completionItem.snippetSupport = true

        require('mason-lspconfig').setup({
            ensure_installed = { 'html', 'cssls' },
            handlers = {
                html = function()
                    require('lspconfig').html.setup({
                        capabilities = webdev_lsp_caps,
                    })
                end,
            }
        })
    end,
}
