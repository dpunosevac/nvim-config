local telescope_builtin = require("telescope.builtin")
local M = {}

function M.live_grep_open_files()
    telescope_builtin.live_grep({ grep_open_files = true })
end

return M
