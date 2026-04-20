return {
  -- Floating lazygit window
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  {
    "esmuellert/codediff.nvim",
    cmd = "CodeDiff",
  },
  -- Generate GitHub permalinks for selected code
  {
    "ruifm/gitlinker.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gl", function() require("gitlinker").get_buf_range_url("n") end, desc = "Git link (line)" },
      { "<leader>gl", function() require("gitlinker").get_buf_range_url("v") end, mode = "v",              desc = "Git link (selection)" },
    },
    opts = {},
  },
  -- Git signs in the gutter + hunk actions
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(keys, fn, desc)
          vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = "Git: " .. desc })
        end

        map("]c", gs.next_hunk, "Next hunk")
        map("[c", gs.prev_hunk, "Prev hunk")
        map("<leader>gb", gs.blame_line, "Blame line")
        map("<leader>gp", gs.preview_hunk, "Preview hunk")
        map("<leader>gs", gs.stage_hunk, "Stage hunk")
        map("<leader>gr", gs.reset_hunk, "Reset hunk")
      end,
    },
  },
}
