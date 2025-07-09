return {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        require('todo-comments').setup({
            keywords = {
                TODO = { icon = ' ' },
                HACK = { icon = ' ' },
                PERF = { icon = '󰓅 ' },
                NOTE = { icon = ' ' },
                WARN = { icon = ' ' },
                TEST = { icon = '󰙨 ', alt = { 'TESTING' }},
            }
        })
        require('sct_lazy.maps').plugins.todo()
    end,
}
