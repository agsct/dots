-- [[ telescope ]]
-- file finder

return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_POLICY_VERSION_MINIMUM=3.5 -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
        }
    },
    config = function()
        -- [ config ]
        require('telescope').setup({
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = 'smart_case',
                },
            },
        })

        -- [ load extensions ]
        require('telescope').load_extension('fzf')

        -- [ keybinds ]
        require('sct_lazy.maps').plugins.telescope()
    end,
}
