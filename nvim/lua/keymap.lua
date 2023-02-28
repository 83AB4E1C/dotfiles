local map = vim.keymap.set
vim.g.mapleader = ' '
-- nvimtree
map('n', '<c-q>', '<cmd>NvimTreeToggle<CR>')
-- bufferline
map('n', '<leader>dd', '<cmd>bdelete<CR>')
map('n', '<leader>1', '<cmd>BufferLineGoToBuffer 1<CR>')
map('n', '<leader>2', '<cmd>BufferLineGoToBuffer 2<CR>')
map('n', '<leader>3', '<cmd>BufferLineGoToBuffer 3<CR>')
map('n', '<leader>4', '<cmd>BufferLineGoToBuffer 4<CR>')
-- next buffer previous buffer
map('n', '[b', '<cmd>bn<CR>')
map('n', ']b', '<cmd>bp<CR>')
-- select window
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')
map('n', '<a-[>', '<cmd>vertical resize -5<CR>')
map('n', '<a-]>', '<cmd>vertical resize +5<CR>')
-- insert move
map('i', '<a-h>', '<left>')
map('i', '<a-j>', '<down>')
map('i', '<a-k>', '<up>')
map('i', '<a-l>', '<right>')
-- lspsaga
map('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>')
-- Code action
map({'n','v'}, '<leader>ca', '<cmd>Lspsaga code_action<CR>')
-- Rename
map('n', 'gr', '<cmd>Lspsaga rename<CR>')
-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
map('n', 'gd', '<cmd>Lspsaga peek_definition<CR>')
-- Go to Definition
map('n','gd', '<cmd>Lspsaga goto_definition<CR>')
-- Show line diagnostics you can pass arugment ++unfocus to make
-- show_line_diagnsotic float window unfocus
map('n', '<leader>sl', '<cmd>Lspsaga show_line_diagnostics<CR>')
-- Show cursor diagnostic
-- also like show_line_diagnostics  support pass ++unfocus
map('n', '<leader>sc', '<cmd>Lspsaga show_cursor_diagnostics<CR>')
-- Show buffer diagnostic
map('n', '<leader>sb', '<cmd>Lspsaga show_buf_diagnostics<CR>')
-- Diagnsotic jump can use `<c-o>` to jump back
map('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
map('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<CR>')
-- Diagnostic jump with filter like Only jump to error
map('n', '[E', function()
  require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
map('n', ']E', function()
  require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
-- Outline
map('n','<leader>o', '<cmd>Lspsaga outline<CR>')
-- Hover Doc
map('n', 'K', '<cmd>Lspsaga hover_doc<CR>')
-- Callhierarchy
map('n', '<Leader>ci', '<cmd>Lspsaga incoming_calls<CR>')
map('n', '<Leader>co', '<cmd>Lspsaga outgoing_calls<CR>')
-- Float terminal
map({'n', 't'}, '<A-d>', '<cmd>Lspsaga term_toggle<CR>')
-- coman
map('n', 'gcc', '<cmd>ComComment<CR>')
map('x', 'gcc', ':ComComment<CR>')
map('n', 'gcj', '<cmd>ComAnnotation<CR>')
-- telescope
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>b', '<cmd>Telescope buffers<CR>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
map('n', '<leader>fb', '<cmd>Telescope file_browser<CR>')
-- format with lsp
map('n', '<leader>fm', '<cmd>lua vim.lsp.buf.format()<CR>')
