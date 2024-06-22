local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  'nvim-lua/plenary.nvim',
  -- lsp
  {
    'neovim/nvim-lspconfig',
    config = function()
      local cfg = require("lspconfig")
      -- cfg.tailwindcss.setup {
      --   filetypes = {
      --     "css",
      --     "html",
      --     "rust",
      --   },
      --   init_options = {
      --     userLanguages = {
      --       rust = "html"
      --     }
      --   },
      -- }
      cfg.typos_lsp.setup {}
      cfg.eslint.setup {
        fileytypes = {
          "javascript", "html"
        }
      }
      cfg.rust_analyzer.setup {
        -- Other Configs ...
        settings = {
          ["rust-analyzer"] = {
            -- Other Settings ...
            procMacro = {
              ignored = {
                leptos_macro = {
                  "server",
                  "component",
                },
              },
            },
          },
        }
      }
      cfg.lua_ls.setup {}
      cfg.html.setup {}
      cfg.wgsl_analyzer.setup {
        filetypes = { "wgsl" },
      }
      cfg.texlab.setup {}
      cfg.clangd.setup {
        cmd = { "clangd",
          "--offset-encoding=utf-16",
          "--all-scopes-completion",
          "--suggest-missing-includes",
          "--background-index",
          "--pch-storage=disk",
          "--cross-file-rename",
          "--log=info",
          "--completion-style=detailed",
          "--clang-tidy",
        }
      }
      cfg.jedi_language_server.setup {}
    end
  },
  {
    'dgagn/diagflow.nvim',
    config = function()
      require('diagflow').setup {
        padding_right = 2,
      }
    end
  },
  {
    'mfussenegger/nvim-lint',
  },
  -- use 'williamboman/mason-lspconfig'
  -- use { 'williamboman/mason.nvim',
  --   config = function()
  --     require("mason").setup()
  --     require("mason-lspconfig").setup {
  --       automatic_installation = true,
  --     }
  --     require("lspconfig").rust_analyzer.setup {}
  --   end
  -- }
  -- rust
  {
    'saecki/crates.nvim',
    requires = { { 'nvim-lua/plenary.nvim', opt = false } },
    config = function()
      require('crates').setup()
    end
  },
  { 'ron-rs/ron.vim' },
  -- toggleterm
  {
    "akinsho/toggleterm.nvim",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        direction = 'tab',
      })
    end
  },
  -- treesitter
  { 'nvim-treesitter/nvim-treesitter', run = 'TSUpdate' },
  -- fidget loading
  {
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end
  },

  -- file tree
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup({
        hijack_cursor = true,
        git = {
          enable = false,
        },
        view = {
          side = "right"
        },
        diagnostics = {
          enable = true,
          icons = {
            hint = "H",
            info = "I",
            warning = "W",
            error = "E",
          },
        },
        renderer = {
          highlight_opened_files = "name",
          indent_width = 1,
        },
        tab = {
          sync = {
            open = true,
            close = true,
          }
        }
      })
    end
  },
  'nvim-tree/nvim-web-devicons',
  -- colorscheme
  {
    "rebelot/kanagawa.nvim",
    config = function()
      require("kanagawa").setup({})
      vim.cmd("colorscheme kanagawa-wave")
    end
  },
  -- completion
  { 'hrsh7th/nvim-cmp' },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-path',
  'smolck/command-completion.nvim',
  {
    'm4xshen/autoclose.nvim',
    config = function()
      require("autoclose").setup {
        keys = {
          ["("] = { escape = false, close = false, pair = "()" },
          ["["] = { escape = false, close = false, pair = "[]" },
          ["{"] = { escape = false, close = true, pair = "{}" },

          [">"] = { escape = false, close = false, pair = "<>" },
          [")"] = { escape = true, close = false, pair = "()" },
          ["]"] = { escape = true, close = false, pair = "[]" },
          ["}"] = { escape = true, close = false, pair = "{}" },

          ['"'] = { escape = true, close = false, pair = '""' },
          ["'"] = { escape = false, close = false, pair = "''" },
          -- ["`"] = { escape = true, close = true, pair = "``" },
        },
        options = {
          disabled_filetypes = { "text" },
          disable_when_touch = false,
          touch_regex = "[%w(%[{]",
          pair_spaces = false,
          auto_indent = true,
          disable_command_mode = false,
        },
      }
    end
  },
  -- use { 'windwp/nvim-autopairs',
  --   config = function()
  --     require("nvim-autopairs").setup {}
  --   end
  -- }
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("lsp_signature").setup({
        floating_window = false,
        hint_prefix = "",
      })
    end
  },
  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    requires = { { 'nvim-lua/plenary.nvim' } }
  },
  'nvim-telescope/telescope-ui-select.nvim',
  -- commenting
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },
  -- bufferline
  {
    'willothy/nvim-cokeline',
    requires = { { 'nvim-lua/plenary.nvim' } },
    config = function()
      require("cokeline").setup({
        show_if_buffers_are_at_least = 1,
        buffers = {
          new_buffers_position = "number",
        },
        sidebar = {
          filetype = { 'NvimTree', 'neo-tree' },
          components = {
            {
              text = function(buf)
                return 'Files'
              end
            }
          }
        },
        components = {
          {
            text = function(buffer) return ' ' .. buffer.filename .. ' ' end,
          },
        }
      })
    end
  } })
