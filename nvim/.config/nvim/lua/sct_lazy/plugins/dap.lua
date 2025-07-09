-- [[ dap ]]

return {
    'mfussenegger/nvim-dap',
    dependencies = {
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
        'nvim-neotest/nvim-nio',
        'williamboman/mason.nvim',
        'ldelossa/nvim-dap-projects',
    },
    config = function ()
        local dap = require('dap')
        local ui = require('dapui')

        -- general init setup
        ui.setup()

        -- lang specific init setup
        require('sct_lazy.plugins.langs.rust').dap_setup()

        -- keymaps
        require('sct_lazy.maps').plugins.dap()

        -- ui listeners
        dap.listeners.before.attach.dapui_config = function ()
            ui.open()
        end
        dap.listeners.before.launch.dapui_config = function ()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function ()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function ()
            ui.close()
        end

        require('nvim-dap-projects').search_project_config()

    end
}
