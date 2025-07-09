-- [[ keymaps ]]
-- keymappings and helpful functions

-- [ local funcs ]
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s')
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end


-- [ mappings ]
return {
    vanilla = function()
        -- basic
        vim.keymap.set('n', '<leader>dk', vim.diagnostic.goto_prev, { desc = 'go to previous [D]iagnostic message' })
        vim.keymap.set('n', '<leader>dj', vim.diagnostic.goto_next, { desc = 'go to next [D]iagnostic message' })
        vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'show diagnostic [E]rror messages' })
        vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'open diagnostic [Q]uickfix list' })

        vim.keymap.set('n', '<left>', '<Nop>')
        vim.keymap.set('n', '<right>', '<Nop>')
        vim.keymap.set('n', '<up>', '<Nop>')
        vim.keymap.set('n', '<down>', '<Nop>')

        -- leader-based
        vim.keymap.set('n', '<leader>ee', vim.cmd.Ex, { desc = 'open explorer' })
        vim.keymap.set('n', '<leader>es', vim.cmd.Hex, { desc = 'open explorer in split' })
        vim.keymap.set('n', '<leader>ev', vim.cmd.Vex, { desc = 'open explorer in vertical split' })

        vim.keymap.set('n', '<leader>mc', '0i- [ ] <esc>j0', { desc = '[m]ake [c]heckbox' })
    end,

    autocmd = {
        lsp_attach = function(opts)
            vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
            vim.keymap.set('n', '<leader>lR', function() vim.lsp.buf.rename() end, opts)
            vim.keymap.set('n', '<leader>l.', function() vim.lsp.buf.code_action() end, opts)
            vim.keymap.set('n', '<leader>lf', function() vim.lsp.buf.format({ async = true }) end, opts)
        end,
    },

    plugins = {
        cmp = function()
            local cmp = require('cmp')
            return cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif vim.fn['vsnip#available'](1) == 1 then
                        feedkey('<Plug>(vsnip-expand-or-jump)', '')
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
                ['<S-Tab>'] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif vim.fn['vsnip#jumpable'](-1) == 1 then
                        feedkey('<Plug>(vsnip-jump-prev)', '')
                    end
                end, { 'i', 's' }),
                ['<C-j>'] = cmp.mapping.scroll_docs(4),
                ['<C-k>'] = cmp.mapping.scroll_docs(-4),
                ['<C-q>'] = cmp.mapping.abort(),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
            })
        end,

        dap = function ()
            local dap = require('dap')
            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[d]ap [t]oggle breakpoint' })
            vim.keymap.set('n', '<leader>dgc', dap.run_to_cursor, { desc = '[d]ap [g]oto cursor' })
            vim.keymap.set('n', '<leader>d?', function ()
                require('dapui').eval(nil, { enter = true })
            end, { desc = '[d]ap eval var under cursor' })
            vim.keymap.set('n', '<leader>dc', dap.continue, { desc = '[d]ap [c]ontinue' })
            vim.keymap.set('n', '<leader>dl', dap.step_into, { desc = '[d]ap step into' })
            vim.keymap.set('n', '<leader>dj', dap.step_over, { desc = '[d]ap step over' })
            vim.keymap.set('n', '<leader>dh', dap.step_out, { desc = '[d]ap step out' })
            vim.keymap.set('n', '<leader>dk', dap.step_back, { desc = '[d]ap step back' })
            vim.keymap.set('n', '<leader>dr', dap.restart, { desc = '[d]ap restart' })
        end,

        fugitive = function()
            vim.keymap.set('n', '<leader>gs', ':G<CR>', { desc = '[g]it [s]tatus' })
            vim.keymap.set('n', '<leader>gf', ':G fetch --all -p<CR>', { desc = '[g]it [f]etch' })
            vim.keymap.set('n', '<leader>ga', ':G add .<CR>', { desc = '[g]it [a]dd all' })
            vim.keymap.set('n', '<leader>gc', ':G commit<CR>', { desc = '[g]it [c]ommit' })
            vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<CR>', { desc = '[g]it [d]iff in vertical split' })
            vim.keymap.set('n', '<leader>gps', ':G push origin<CR>', { desc = '[g]it [p]u[s]h commits to origin' })
            vim.keymap.set('n', '<leader>gpl', ':G push origin<CR>', { desc = '[g]it [p]u[l]l commits from origin' })
            vim.keymap.set('n', '<leader>gr', ':redir @+ | G rev-parse HEAD | redir END<CR>', { desc = '[g]it [r]ev-parse HEAD' })
        end,

        telescope = function()
            local builtin = require('telescope.builtin')
            -- file pickers
            vim.keymap.set('n', '<leader>ff', builtin.find_files,
                { desc = '[f]ind [f]iles' })
            vim.keymap.set('n', '<leader>fg', builtin.git_files,
                { desc = '[f]ind [g]it files' })
            vim.keymap.set('n', '<leader>fG', builtin.live_grep,
                { desc = '[f]ind by [G]rep' })

            -- vim pickers
            vim.keymap.set('n', '<leader>fb', builtin.buffers,
                { desc = '[f]ind [b]uffers' })
            vim.keymap.set('n', '<leader>fr', builtin.registers,
                { desc = '[f]ind [r]egisters' })
            vim.keymap.set('n', '<leader>fk', builtin.keymaps,
                { desc = '[f]ind [k]eymaps' })
            vim.keymap.set('n', '<leader><leader>', builtin.resume,
                { desc = 'resume previous picker' })

            -- lsp pickers
            vim.keymap.set('n', '<leader>lr', builtin.lsp_references,
                { desc = '[l]sp [r]eferences for word under cursor' })
            vim.keymap.set('n', '<leader>li', builtin.lsp_implementations,
                { desc = '[l]sp [i]mplementations' })

            vim.keymap.set('n', '<leader>ld', builtin.lsp_definitions,
                { desc = '[l]sp [d]efinitions' })

            vim.keymap.set('n', '<leader>lt', builtin.lsp_type_definitions,
                { desc = '[l]sp [t]ype defintions' })
        end,

        todo = function()
            local todo = require('todo-comments')
            vim.keymap.set('n', '<leader>tk', function()
                todo.jump_prev()
            end, { desc = 'previous todo comment' })

            vim.keymap.set('n', '<leader>tj', function()
                todo.jump_next()
            end, { desc = 'next todo comment' })
        end,
    }
}
