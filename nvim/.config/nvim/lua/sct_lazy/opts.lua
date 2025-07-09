-- [[ options ]]
-- general stuff
vim.opt.winaltkeys = 'no'
vim.opt.mouse = ''
vim.opt.termguicolors = true

-- number and lines
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.nrformats = 'octal,hex,bin'
vim.opt.showbreak = '> '

-- tab stuff
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.smartindent = true

-- file stuff
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

-- visual help stuff
vim.opt.signcolumn = 'yes:1'
vim.opt.list = true
vim.opt.listchars = { tab = '| ', trail = '·', nbsp = '‿' }
vim.opt.inccommand = 'split'

-- search stuff
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.matchpairs = '(:),{:},[:],<:>'
vim.opt.hlsearch = false

-- splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- time
vim.opt.updatetime = 50

-- diagnostics
vim.diagnostic.config({
    virtual_text = {
        source = "always",
        prefix = '●',
    },
    severity_sort = true,
    float = {
        source = "always",
    },
})
