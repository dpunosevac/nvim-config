return {
  -- Icons (required by many plugins)
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      integrations = {
        bufferline = true,
        cmp = true,
        gitsigns = true,
        indent_blankline = { enabled = true },
        mason = true,
        nvimtree = true,
        telescope = { enabled = true },
        treesitter = true,
        treesitter_context = true,
        which_key = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- Bufferline (open buffers as tabs)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    keys = {
      { "<Tab>",   "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
      {
        "<leader>x",
        function()
          -- Close buffer without closing the window
          local buf = vim.api.nvim_get_current_buf()
          -- Switch to alternate or next buffer first
          local ok = pcall(vim.cmd, "bprevious")
          if not ok or vim.api.nvim_get_current_buf() == buf then
            vim.cmd("enew")
          end
          if vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_buf_delete(buf, { force = false })
          end
        end,
        desc = "Close buffer"
      },
    },
    opts = {
      options = {
        mode = "buffers",
        numbers = "none",
        close_command = "bdelete! %d",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(_, _, diag)
          local icons = { error = " ", warning = " " }
          return (diag.error and icons.error .. diag.error or "")
              .. (diag.warning and icons.warning .. diag.warning or "")
        end,
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true,
          },
        },
        show_buffer_close_icons = true,
        show_close_icon = false,
        separator_style = "slant",
      },
    },
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "catppuccin",
        globalstatus = true,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
      { "<C-n>",     "<cmd>NvimTreeFocus<cr>",  desc = "Focus file explorer" },
    },
    opts = {
      view = { width = 30, side = "left" },
      renderer = {
        group_empty = true,
        icons = {
          show = { file = true, folder = true, folder_arrow = true, git = false },
        },
      },
      filters = { dotfiles = false },
      git = { enable = true, ignore = false },
      filesystem_watchers = { enable = true },
    },
  },

  -- Indentation guides with rainbow colors
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local hooks = require("ibl.hooks")

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, "RainbowRed",    { fg = "#E06C75" })
        vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
        vim.api.nvim_set_hl(0, "RainbowBlue",   { fg = "#61AFEF" })
        vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
        vim.api.nvim_set_hl(0, "RainbowGreen",  { fg = "#98C379" })
        vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
        vim.api.nvim_set_hl(0, "RainbowCyan",   { fg = "#56B6C2" })
      end)

      require("ibl").setup({
        indent = {
          highlight = {
            "RainbowRed", "RainbowYellow", "RainbowBlue",
            "RainbowOrange", "RainbowGreen", "RainbowViolet", "RainbowCyan",
          },
        },
        scope = { enabled = true },
        exclude = {
          filetypes = { "help", "lazy", "mason", "notify", "NvimTree", "TelescopePrompt" },
        },
      })
    end,
  },

  -- Keymap hints
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = { delay = 300 },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
      wk.add({
        { "<leader>f", group = "File" },
        { "<leader>g", group = "Git" },
        { "<leader>w", group = "Window" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debug" },
      })
    end,
  },
}
