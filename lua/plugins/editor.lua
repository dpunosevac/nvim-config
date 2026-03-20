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
      -- Ensure parser install dir is in runtimepath
      local install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site")
      if not vim.tbl_contains(vim.opt.runtimepath:get(), install_dir) then
        vim.opt.runtimepath:append(install_dir)
      end

      require("nvim-treesitter").setup()

      -- Install parsers if missing
      local ensure_installed = {
        "lua", "vim", "vimdoc", "query",
        "python",
        "typescript", "javascript", "tsx", "html", "css",
        "json", "yaml", "toml",
        "markdown", "markdown_inline",
        "bash",
      }
      local installed = require("nvim-treesitter.config").get_installed()
      local to_install = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, ensure_installed)
      if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
      end

      -- Auto-start treesitter highlighting for buffers with a parser
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          pcall(vim.treesitter.start)
        end,
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
