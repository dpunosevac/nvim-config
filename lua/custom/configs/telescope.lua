local telescopeConfig = require("telescope.config")
local telescope_builtin = require("telescope.builtin")
local M = {}

-- Clone the default vimgrep_arguments
local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

-- Add custom arguments
table.insert(vimgrep_arguments, "--hidden")
table.insert(vimgrep_arguments, "--glob")
table.insert(vimgrep_arguments, "!**/.git/*")

function M.live_grep_open_files()
    telescope_builtin.live_grep({ grep_open_files = true })
end

function M.live_grep_hidden()
    telescope_builtin.live_grep({ vimgrep_arguments = vimgrep_arguments })
end

return M
