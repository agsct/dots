-- [[ lsp/lua.lua ]]
-- defines functions for plugins to call on setup
-- this confines lua configuration to this file

return {
    -- [ tree-sitter ensure list ]
    ts_ensure_list = function()
        return 'lua', 'luadoc'
    end,

    -- [[ lsp & dap setup ]]
    lsp_setup = function()
        local lsp_caps = require('cmp_nvim_lsp').default_capabilities()

        require('mason-lspconfig').setup({
            ensure_installed = { 'lua_ls' },
            handlers = {
                lua_ls = function ()
                    require('lspconfig').lua_ls.setup({
                        capabilities = lsp_caps,
                        settings = {
                            Lua = {
                                runtime = { version = 'LuaJIT'},
                                diagnostics = { globals = { 'vim' }},
                            }
                        }
                    })
                end,
            }
        })
    end,
}
