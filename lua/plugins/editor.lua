return {
  -- Syntax highlighting and text objects
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "query",
          "python",
          "typescript", "javascript", "tsx", "html", "css",
          "json", "yaml", "toml",
          "markdown", "markdown_inline",
          "bash",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      })

      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
      })
    end,
  },

  -- Auto-close brackets/quotes
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = { check_ts = true },
  },

  -- Comment toggling  (gcc / gc in visual)
  {
    "numToStr/Comment.nvim",
    keys = {
      { "<leader>/", "<Plug>(comment_toggle_linewise_current)", desc = "Toggle comment" },
      { "<leader>/", "<Plug>(comment_toggle_linewise_visual)", mode = "v", desc = "Toggle comment" },
    },
    opts = {},
  },

  -- Detect tabstop/shiftwidth from existing file content
  { "tpope/vim-sleuth" },
}
