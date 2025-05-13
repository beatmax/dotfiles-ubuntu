local M = {}

M.aerial = {
  n = {
     ["<leader>aa"] = { "<cmd> AerialToggle <CR>", "Toggle aerial" },
     ["<leader>an"] = { "<cmd> AerialNavToggle <CR>", "Toggle aerial nav" },
     ["<leader>aj"] = { "<cmd> AerialNext <CR>", "Aerial next" },
     ["<leader>ak"] = { "<cmd> AerialPrev <CR>", "Aerial prev" },
  }
}

M.copy = {
  n = {
     ["<leader>ya"] = {"<cmd> ExpandCopy %:p <CR>", "Copy absolute path"},
     ["<leader>yp"] = {"<cmd> ExpandCopy % <CR>", "Copy path"},
     ["<leader>yr"] = {"<cmd> CopyRelPath <CR>", "Copy relative path"},
     ["<leader>yd"] = {"<cmd> ExpandCopy %:p:h <CR>", "Copy directory name"},
     ["<leader>yf"] = {"<cmd> ExpandCopy %:t <CR>", "Copy filename"},
  }
}

M.crates = {
  plugin = true,
  n = {
    ["<leader>rcu"] = {
      function ()
        require('crates').upgrade_all_crates()
      end,
      "Update crates"
    }
  }
}

M.dap = {
  plugin = true,
  n = {
    -- TODO conflict with nvim-gdb? (maybe use plugin=true for both, disable defaults for nvim-gdb)
    -- ["<F5>"] = {"<cmd> DapContinue <CR>", "Start or continue"},
    -- ["<F6>"] = {"<cmd> DapStepOver <CR>", "Step over"},
    -- ["<F7>"] = {"<cmd> DapStepInto <CR>", "Step into"},
    -- ["<F8>"] = {"<cmd> DapStepOut <CR>", "Step out"},
    -- ["<F9>"] = {"<cmd> DapToggleBreakpoint <CR>", "Toggle breakpoint"},

    -- for rust, from: https://youtu.be/mh_EJhH49Ms?si=8mHbdAegtUgZpolD&t=529
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>", "Toggle breakpoint"},
    -- TODO needed?
    -- ["<leader>dus"] = {
    --   function ()
    --     local widgets = require('dap.ui.widgets');
    --     local sidebar = widgets.sidebar(widgets.scopes);
    --     sidebar.open();
    --   end,
    --   "Open debugging sidebar"
    -- }
  }
}

M.emoji = {
  i = {
     ["<C-e>"] = {"<cmd> EmojiPicker <CR>", "Emoji picker"},
  }
}

M.general = {
  n = {
     ["Zz"] = {"<cmd> qa <CR>", "Quit all"},
     -- ["<leader>k"] = {"<cmd> wa <CR> <cmd> make <CR>", "Write all and make"},
     -- ["<leader>k"] = {"<cmd> wa <CR> <cmd> CMakeBuild <CR>", "Write all and make"},
     ["<leader>k"] = {
      function ()
        vim.cmd("wa")
        vim.cmd("CMakeBuild --target install")
      end,
      "Write all and make"},
     ["<leader>ts"] = {"<cmd> windo set spell! <CR>", "Toggle spell checking (all windows)"},
     ["<leader>wr"] = {"<cmd> windo set wrap! <CR>", "Toggle wrap (all windows)"},
  },
  v = {
     ["<leader>fm"] = {vim.lsp.buf.format, "LSP formatting"},
  }
}

M.git = {
  n = {
     ["<leader>gg"] = {"<cmd> Neogit <CR>", "Neogit"},
     ["<leader>gd"] = {"<cmd> DiffviewOpen <CR>", "Diffview open"},
     ["<leader>gc"] = {"<cmd> DiffviewClose <CR>", "Diffview close"},
     ["<leader>gh"] = {"<cmd> DiffviewFileHistory <CR>", "Diffview history"},
     ["<leader>gf"] = {"<cmd> DiffviewFileHistory % <CR>", "Diffview history (current file)"},
  }
}

M.gitsigns = {
  n = {
     ["<leader>sh"] = {"<cmd> Gitsigns stage_hunk <CR>", "Stage hunk"},
     ["<leader>uh"] = {"<cmd> Gitsigns undo_stage_hunk <CR>", "Undo stage hunk"},
  }
}

M.lsp = {
  n = {
     ["go"] = {"<cmd> ClangdSwitchSourceHeader <CR>", "Switch source/header"},
  }
}

M.smart_splits = {
  n = {
    ["<leader>rm"] = {
      function ()
        require('smart-splits').start_resize_mode()
      end,
      "Start resize mode"
    },
    -- TODO workaround for https://github.com/mrjones2014/smart-splits.nvim/issues/192
    ["<leader>rr"] = {
      function ()
        vim.keymap.set('n', '<esc>', ':noh<cr>', { noremap = true })
      end,
      "Restore esc mapping",
    }
  }
}

M.telescope = {
  n = {
     ["<C-b>"] = { "<cmd> Telescope buffers sort_mru=true <CR>", "Find buffers (mru)" },
     ["<leader>fg"] = {"<cmd> Telescope grep_string <CR>", "Search string under cursor"},
     ["<leader>fw"] = {"<cmd> Telescope live_grep_args <CR>", "Live grep (args)"},
     ["<leader>qf"] = {"<cmd> Telescope quickfix <CR>", "List quickfix items"},
     ["<leader>qh"] = {"<cmd> Telescope quickfixhistory <CR>", "List quickfix history"},
     ["<leader>ss"] = {"<cmd> Telescope lsp_document_symbols <CR>", "LSP document symbols"},
     ["<leader>sw"] = {"<cmd> Telescope lsp_dynamic_workspace_symbols <CR>", "LSP dynamic workspace symbols"},
  }
}

M.trouble = {
  n = {
     ["<leader>tt"] = {
      function ()
        vim.cmd("cclose")
        vim.cmd("Trouble quickfix toggle")
      end,
      "Toggle trouble quickfix list"
    }
  }
}

return M
