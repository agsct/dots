-- [[ autocommands ]]
-- vars
local augroup = vim.api.nvim_create_augroup
local sct_group = augroup('sct', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', { clear = true })

return {
    vanilla = function()
        -- highlight when yanking text
        autocmd('TextYankPost', {
            desc = 'Highlight when yanking text',
            group = yank_group,
            pattern = '*',
            callback = function()
                vim.highlight.on_yank()
            end
        })
    end,

    plugins = {
        lsp = function()
            autocmd('LspAttach', {
                desc = 'Lsp actions',
                group = sct_group,
                callback = function()
                    require('sct_lazy.maps').autocmd.lsp_attach()
                end
            })
        end
    }
}
