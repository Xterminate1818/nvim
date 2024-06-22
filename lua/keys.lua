local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

function map(mode, input, output) keymap(mode, input, output, opts) end

function amap(input, output)
  keymap("n", input, output, opts)
  keymap("i", input, output, opts)
  keymap("v", input, output, opts)
end

-- Disable f keys
-- amap("<F1>", "<Nop>")
amap("<F2>", "<Nop>")
amap("<F3>", "<Nop>")
amap("<F4>", "<Nop>")
amap("<F5>", "<Nop>")
amap("<F6>", "<Nop>")
amap("<F7>", "<Nop>")
amap("<F8>", "<Nop>")
amap("<F9>", "<Nop>")
amap("<F10>", "<Nop>")
amap("<F11>", "<Nop>")
amap("<F12>", "<Nop>")

-- Force quit
amap("<c-q>", "<cmd>qall!<cr>")
amap("<c-s>", "<cmd>w<cr>")

-- Leader key
map("", "<space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

---- Normal
function nmap(input, output) map("n", input, output) end

-- Save buffer
nmap("<leader>w", ":w<cr>")

-- Resize with arrows
nmap("<C-Up>", ":resize +2<CR>")
nmap("<C-Down>", ":resize -2<CR>")
nmap("<C-Left>", ":vertical resize -2<CR>")
nmap("<C-Right>", ":vertical resize +2<CR>")

-- Navigate windows
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

-- Navigate buffers
nmap("<S-h>", "<Plug>(cokeline-focus-prev)")
nmap("<S-l>", "<Plug>(cokeline-focus-next)")

-- Format buffer
-- vim.keymap.set("n", "<leader>r",
--   function()
--     vim.lsp.buf.format()
--   end,
--   opts)
nmap("<leader>r", ":lua vim.lsp.buf.format()<cr>:w<cr>")

-- Run
nmap("<F4>", ':wa!<cr>:TermExec cmd="cargo build"<cr>')
nmap("<F5>", ':wa!<cr>:TermExec cmd="cargo run"<cr>')
nmap("<F6>", ':wa!<cr>:TermExec cmd="cargo run --release"<cr>')

-- Close current buffer
nmap("<leader>c", ":bd<cr>")

-- Telescope
keymap("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", opts)
keymap("n", "<leader>f", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)

-- NvimTree
nmap("<leader>e", ":NvimTreeToggle<cr>")

-- Lsp stuff
nmap("gl", ':lua vim.diagnostic.open_float({scope="line", border="none", prefix="", header="", source=false})<cr>')
nmap("<leader>la", ":lua vim.lsp.buf.code_action()<cr>")
-- nmap("<leader>la", ":Telescope quickfix<cr>")
nmap("<leader>lh", ":lua vim.lsp.buf.signature_help()<cr>")
nmap("<leader>lr", ":lua vim.lsp.buf.rename()<cr>")
nmap("<leader>s", ":Telescope lsp_document_symbols<cr>")
nmap("<S-k>", ":lua vim.lsp.buf.hover()<cr>")

---- Insert
-- Escape sequence
keymap("i", "jk", "<ESC>", opts)

---- Visual
-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("v", "<A-j>", ":m .+1<CR>==")
map("v", "<A-k>", ":m .-2<CR>==")
map("v", "p", '"_dP')
