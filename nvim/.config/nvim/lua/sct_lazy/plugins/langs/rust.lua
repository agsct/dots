-- [[ lsp/rust.lua ]]
-- defines functions for plugins to call on setup
-- this confines rust configuration to this file

return {
    -- [ tree-sitter ensure list ]
    ts_ensure_list = function()
        return 'rust', 'toml'
    end,

    lsp_setup = function()
        local lsp_caps = require('cmp_nvim_lsp').default_capabilities()

        require('mason-lspconfig').setup({
            ensure_installed = { 'rust_analyzer' },
            handlers = {
                rust_analyzer = function()
                    require('lspconfig').rust_analyzer.setup({
                        capabilities = lsp_caps,
                    })
                end
            }
        })
    end,

    dap_setup = function ()
        -- setup adapter
        local dap = require('dap')
        dap.adapters.codelldb = {
            type = 'executable',
            command = 'codelldb'
        }

        -- default targets not specified in .nvim/nvim-dap.lua
        dap.configurations.rust = {
            {
                name = 'Launch (local)',
                type = 'codelldb',
                request = 'launch',
                program = function ()
                    local name = io.popen('grep name Cargo.toml | cut -d\'"\' -f2'):read('*a'):gsub('[\n\r]', ''):gsub('[\n]', '') -- gets target name
                    return vim.fn.getcwd() .. '/target/debug/' .. name
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
            }
        }
    end
}
