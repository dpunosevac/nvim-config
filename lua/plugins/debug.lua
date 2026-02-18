return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for DAP
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")

          dapui.setup({
            icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
            controls = {
              icons = {
                pause = "⏸",
                play = "▶",
                step_into = "⏎",
                step_over = "⏭",
                step_out = "⏮",
                step_back = "b",
                run_last = "▶▶",
                terminate = "⏹",
                disconnect = "⏏",
              },
            },
          })

          -- Auto-open/close DAP UI
          dap.listeners.after.event_initialized["dapui_config"] = dapui.open
          dap.listeners.before.event_terminated["dapui_config"] = dapui.close
          dap.listeners.before.event_exited["dapui_config"] = dapui.close
        end,
      },

      -- Inline variable display
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          display_callback = function(variable, _, _, _, options)
            if #variable.value > 20 then
              return " " .. string.sub(variable.value, 1, 20) .. "…"
            end
            return " " .. variable.value
          end,
        },
      },

      -- Python adapter
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          -- Uses the first python3 on PATH; if you use a virtualenv activate it
          -- before launching nvim, or change this path to your debugpy installation.
          local python = vim.fn.exepath("python3")
          require("dap-python").setup(python)
        end,
      },
    },

    keys = {
      { "<F1>", function() require("dap").continue() end,          desc = "Debug: Continue" },
      { "<F2>", function() require("dap").step_over() end,         desc = "Debug: Step over" },
      { "<F3>", function() require("dap").step_into() end,         desc = "Debug: Step into" },
      { "<F4>", function() require("dap").step_out() end,          desc = "Debug: Step out" },
      { "<F5>", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle breakpoint" },
      {
        "<F6>",
        function()
          require("dap").set_breakpoint(vim.fn.input("Condition: "))
        end,
        desc = "Debug: Conditional breakpoint",
      },
      {
        "<F7>",
        function()
          require("dapui").eval(nil, { enter = true })
        end,
        desc = "Debug: Evaluate expression",
      },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
    },

    config = function()
      local dap = require("dap")

      -- Breakpoint markers
      vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "🟠", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "🔲", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "🔵", texthl = "", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "DapStoppedLine", numhl = "" })
    end,
  },
}
