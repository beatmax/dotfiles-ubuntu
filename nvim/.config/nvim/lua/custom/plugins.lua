local plugins = {
  {
    "Civitasv/cmake-tools.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim"
    },
    init = function()
      local loaded = false
      local function check()
        local cwd = vim.uv.cwd()
        if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
          require("lazy").load({ plugins = { "cmake-tools.nvim" } })
          loaded = true
        end
      end
      check()
      vim.api.nvim_create_autocmd("DirChanged", {
        callback = function()
          if not loaded then
            check()
          end
        end,
      })
    end,
    opts = {},
  },
  {
    "WilsonOh/emoji_picker-nvim",
    cmd = { "EmojiPicker" },
    config = true,
  },
  {
    -- restore cursor position: https://github.com/neovim/neovim/issues/16339
    -- note: "ethanholz/nvim-lastplace" is buggy and not maintained anymore
    "farmergreg/vim-lastplace",
    lazy = false,
  },
  {
    "folke/trouble.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    opts = {},
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    -- better quickfix
    "kevinhwang91/nvim-bqf",
    event = "VeryLazy",
    opts = {},
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  -- TODO, disable for current line in insert mode!!
  -- {
  --   "ntpeters/vim-better-whitespace",
  --   lazy = false,
  -- },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
    opts = function()
      local conf = require "plugins.configs.telescope"
      local lga_actions = require("telescope-live-grep-args.actions")
      vim.list_extend(conf.extensions_list, { "live_grep_args" })
      conf.defaults.mappings.i = {
        ["<C-k>"] = lga_actions.quote_prompt(),
        ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
      }
      return conf
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      actions = {
        open_file = {
          resize_window = false,
        },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {"bash", "comment", "cpp", "css", "html", "python", "rust"},
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "lua-language-server",
        -- TODO, see NOTES
        -- "pyright",
        "rust-analyzer",
      }
    }
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    cmd = "Neogit",
    config = true
  },
  {
    "lewis6991/gitsigns.nvim",
    enabled = not os.getenv("WORKAROUND_VIMDIFF"),
  },
  {
    "mrjones2014/smart-splits.nvim",
    opts = {
      resize_mode = {
        silent = true,
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    config = {
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              diff_merges = "off",
              follow = true,
            },
          },
        },
      },
    },
  },
  {
    'stevearc/aerial.nvim',
    cmd = { "AerialToggle", "AerialOpen", "AerialOpenAll", "AerialNavToggle", "AerialNavOpen", "AerialNext", "AerialPrev" },
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  {
    "subnut/nvim-ghost.nvim",
    cmd = "GhostTextStart",
    init = function ()
      vim.g.nvim_ghost_autostart = 0
    end
  },

  -- rust (https://youtu.be/mh_EJhH49Ms?si=KFvEChTpKHT8O4bh)
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },
  {
    "simrat39/rust-tools.nvim",
    ft = "rust",
    dependencies = "neovim/nvim-lspconfig",
    opts = function ()
      return require "custom.configs.rust-tools"
    end,
    config = function(_, opts)
      require('rust-tools').setup(opts)
    end
  },
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function(_, opts)
      local crates  = require('crates')
      crates.setup(opts)
      require('cmp').setup.buffer({
        sources = {{ name = "crates" }}
      })
      crates.show()
      require("core.utils").load_mappings("crates")
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function()
      local M = require "plugins.configs.cmp"
      M.completion.completeopt = "menu,menuone,noselect"
      M.mapping["<CR>"] = require('cmp').mapping.confirm {
        behavior = require('cmp').ConfirmBehavior.Insert,
        select = false,
      }
      table.insert(M.sources, {name = "crates"})
      return M
    end,
  },
  {
    "ziontee113/icon-picker.nvim",
    lazy = false,
    dependencies = {
      "stevearc/dressing.nvim",
    },
    config = function()
        require("icon-picker").setup({ disable_legacy_commands = true })

        local opts = { noremap = true, silent = true }

        vim.keymap.set("n", "<Leader><Leader>i", "<cmd>IconPickerNormal<cr>", opts)
        vim.keymap.set("n", "<Leader><Leader>y", "<cmd>IconPickerYank<cr>", opts) --> Yank the selected icon into register
        vim.keymap.set("i", "<C-i>", "<cmd>IconPickerInsert<cr>", opts)
    end
  },

  -- debugging
  {
    "sakhnik/nvim-gdb",
    lazy = false,  -- TODO
    -- TODO keys and customization: https://github.com/sakhnik/nvim-gdb
  },
  ---- TODO ----
  -- not fully working (attach, pretty printing); but even then, always leave nvim-gdb as an option
  -- (advantage of this: nicer GUI, multiple languages supported)
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      ensure_installed = {
        "cppdbg",
      },
      -- handlers = {},
      handlers = {
       function(config)
          -- all sources with no handler get passed here
          require('mason-nvim-dap').default_setup(config)
        end,
        cppdbg = function(config)
            config.configurations = {
              {
                name = 'Launch file',
                type = 'cppdbg',
                request = 'launch',
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopAtEntry = true,
              },
              {
                name = 'Attach',
                type = 'cppdbg',
                request = 'attach',
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                processId = function()
                  return vim.fn.input('Pid: ')
                end,
                stopAtEntry = true,
              },
              {
                name = 'Attach to gdbserver',
                type = 'cppdbg',
                request = 'launch',
                MIMode = 'gdb',
                miDebuggerServerAddress = 'localhost:25000',
                miDebuggerPath = '/usr/bin/gdb',
                cwd = '${workspaceFolder}',
                program = function()
                  return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
              },
            }
            require('mason-nvim-dap').default_setup(config)
        end,
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end
  },

}
return plugins
