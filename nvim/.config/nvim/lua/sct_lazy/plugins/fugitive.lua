return {
    'tpope/vim-fugitive',
    event = 'BufEnter',
    config = function()
        require('sct_lazy.maps').plugins.fugitive()
    end,
}
