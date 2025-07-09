return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
        require('nvim-autopairs').setup({})
        -- TODO: further configure once coq/cmp has been set up
    end
}
