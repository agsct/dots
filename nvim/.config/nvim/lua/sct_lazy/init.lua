-- [[ init file of the subconfig ]]
-- leader set before anything, to ensure proper leader key is used throughout
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- vanilla options
require('sct_lazy.opts')
require('sct_lazy.maps').vanilla() -- plugins call their respective keymaps
require('sct_lazy.autocmd').vanilla() -- plugins call their respective autocommands

-- plugin setup & options
require('sct_lazy.lazy_init')
