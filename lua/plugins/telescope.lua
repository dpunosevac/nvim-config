return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      { "<leader>sf",  "<cmd>Telescope find_files<CR>",   desc = "Search files" },
      { "<leader>scw", "<cmd>Telescope grep_string <CR>", desc = "Searching current Word" },
      { "<leader>sg",  "<cmd>Telescope live_grep<CR>",    desc = "Search word (Grep)" },
      {
        "<leader>sh",
        function()
          local args = { unpack(require("telescope.config").values.vimgrep_arguments) }
          table.insert(args, "--hidden")
          table.insert(args, "--glob")
          table.insert(args, "!**/.git/*")
          require("telescope.builtin").live_grep({ vimgrep_arguments = args })
        end,
        desc = "Search hidden files"
      },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          sorting_strategy = "ascending",
          layout_config = {
            horizontal = {
              prompt_position = "top",
              preview_width = 0.55,
            },
          },
          file_ignore_patterns = { "node_modules", ".git/" },
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<Esc>"] = actions.close,
            },
          },
        },
      })

      pcall(telescope.load_extension, "fzf")
    end,
  },
}
