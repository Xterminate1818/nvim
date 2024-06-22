-- local sev = vim.diagnostic.severity

-- vim.diagnostic.config({
--   virtual_text = false,
--   severity_sort = true,
--   underline = { severity = { sev.WARN, sev.ERROR } },
-- })

-- Format on save
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  callback = function()
    local ft = vim.bo.filetype
    if (ft ~= "html") then
      vim.lsp.buf.format()
    end
  end
})

-- wgsl filetype
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.wgsl",
  callback = function()
    vim.bo.filetype = "wgsl"
  end,
})

vim.filetype.add({ extension = { wgsl = "wgsl" } })


local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.wgsl = {
  install_info = {
    url = "https://github.com/szebniok/tree-sitter-wgsl",
    files = { "src/parser.c" }
  },
}

require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "wgsl" },
  highlight = {
    enable = true
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldlevelstart = 99 -- do not close folds when a buffer is opened

-- lspconfig.tailwindcss.setup {
--   settings = {
--     init_options = {
--       userLanguages = {
--         rust = "rs",
--       },
--     },
--     includeLanguages = {
--       ["rust"] = "html",
--     }
--   },
--   filetypes = {
--     "css",
--     "html",
--     "rust",
--   },
-- }
-- lspconfig.html.setup {
--   filetypes = {
--     "html",
--     "rust",
--   },
-- }
