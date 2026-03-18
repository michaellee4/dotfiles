-- Leader (must be before lazy)
vim.g.mapleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "navarasu/onedark.nvim", priority = 1000, config = function()
    require("onedark").setup({ style = "dark" })
    require("onedark").load()
  end },

  { "williamboman/mason.nvim", config = function()
    require("mason").setup()
  end },

  { "williamboman/mason-lspconfig.nvim", config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "pyright" },
      automatic_installation = true,
    })
  end },

  { "neovim/nvim-lspconfig", config = function()
    vim.lsp.config('pyright', {})
    vim.lsp.enable('pyright')
  end },

  { "mikavilpas/yazi.nvim",
    lazy = false,
    dependencies = { "folke/snacks.nvim" },
    config = function()
      require("yazi").setup({
        open_for_directories = true,
      })
      vim.keymap.set("n", "<leader>ft", "<cmd>Yazi<cr>", { desc = "Open yazi" })
      vim.keymap.set("n", "<leader>fT", "<cmd>Yazi cwd<cr>", { desc = "Open yazi in cwd" })
    end,
  },

  { "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local colors = {
        bg       = "#282c34",
        fg       = "#abb2bf",
        blue     = "#61afef",
        green    = "#98c379",
        purple   = "#c678dd",
        red      = "#e06c75",
        yellow   = "#e5c07b",
        cyan     = "#56b6c2",
        dark     = "#1e2127",
      }

      local theme = {
        normal   = { a = { fg = colors.dark,   bg = colors.blue,   gui = "bold" },
                     b = { fg = colors.fg,     bg = "#3e4451" },
                     c = { fg = colors.fg,     bg = colors.bg } },
        insert   = { a = { fg = colors.dark,   bg = colors.green,  gui = "bold" } },
        visual   = { a = { fg = colors.dark,   bg = colors.purple, gui = "bold" } },
        replace  = { a = { fg = colors.dark,   bg = colors.red,    gui = "bold" } },
        command  = { a = { fg = colors.dark,   bg = colors.yellow, gui = "bold" } },
        inactive = { a = { fg = colors.fg,     bg = colors.dark },
                     c = { fg = colors.fg,     bg = colors.dark } },
      }

      require("lualine").setup({
        options = {
          theme = theme,
          component_separators = { left = "", right = "" },
          section_separators   = { left = "", right = "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1, symbols = { modified = "  ", readonly = "  " } } },
          lualine_x = { "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        completion = { keyword_length = 1 },
        view = { entries = { name = "custom", selection_order = "top_down" } },
        performance = { max_view_entries = 10 },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"]   = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          ["<CR>"]    = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
})

-- Options
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.updatetime = 500 -- ms before CursorHold fires
vim.opt.clipboard = "unnamedplus"

-- Show diagnostics float on hover
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

-- Command aliases for common typos (with -bang to support ! variants)
vim.cmd('command! -bang Q q<bang>')
vim.cmd('command! -bang W w<bang>')
vim.cmd('command! -bang Wq wq<bang>')
vim.cmd('command! -bang WQ wq<bang>')
vim.cmd('command! -bang Wqa wqa<bang>')
vim.cmd('command! -bang WQa wqa<bang>')
vim.cmd('command! -bang WQA wqa<bang>')
vim.cmd('command! -bang Qa qa<bang>')
vim.cmd('command! -bang QA qa<bang>')
