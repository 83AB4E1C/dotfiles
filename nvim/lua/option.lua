vim.opt.termguicolors = true
vim.opt.hidden = true
vim.opt.encoding = 'utf-8'
vim.opt.clipboard = 'unnamedplus'
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.colorcolumn = '80'
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = -1
vim.opt.laststatus = 3
vim.opt.display = 'lastline'
vim.opt.wildmenu = true
vim.opt.infercase = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.autoread = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.shiftround = true
vim.opt.wrap = false
vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100
vim.opt.redrawtime = 1500
vim.opt.list = true
vim.opt.listchars = 'trail:·,tab:··»,nbsp:+,'
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.foldenable = false
vim.opt.foldlevel = 99
vim.opt.cmdheight = 0

-- wsl yanking to windows clipboard from nvim
if vim.fn.has('wsl') == 1 then
  vim.opt.clipboard = ''
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enable = 0,
  }
end
