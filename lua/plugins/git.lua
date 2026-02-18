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

  -- Diffview: merge conflict resolution & file history
  -- Usage for conflicts: open a file with conflicts, run :DiffviewOpen
  -- You'll see: LOCAL (yours) | BASE | REMOTE (theirs) + result at bottom
  -- Edit the bottom panel to resolve, save, then :DiffviewClose
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>",          desc = "Diffview open" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>",         desc = "Diffview close" },
      { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",   desc = "Branch history" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        -- 3-way merge view: LOCAL | BASE | REMOTE on top, result at bottom
        merge_tool = {
          layout = "diff3_mixed",
          disable_diagnostics = true,
        },
      },
    },
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
