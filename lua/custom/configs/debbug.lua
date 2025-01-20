local dap = require("dap")
local dapui = require("dapui")
local virtual_text = require("nvim-dap-virtual-text")

dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

virtual_text.setup {
  display_callback = function (variable)
    if #variable.value > 15 then
      return " " .. string.sub(variable.value, 1, 15) .. "... "
    end
    return " " .. variable.value
  end
}
