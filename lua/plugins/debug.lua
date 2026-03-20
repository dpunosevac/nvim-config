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

          -- Auto-open DAP UI
          dap.listeners.before.attach.dapui_config = function()
            dapui.open()
          end
          dap.listeners.before.launch.dapui_config = function()
            dapui.open()
          end
        end,
      },

      -- Inline variable display
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          display_callback = function(variable)
            if #variable.value > 15 then
              return " " .. string.sub(variable.value, 1, 15) .. "... "
            end
            return " " .. variable.value
          end,
        },
      },

      -- Python adapter
      {
        "mfussenegger/nvim-dap-python",
        keys = {
          { "<leader>dc", function() require("dap-python").test_class() end,  desc = "Debug: Python test class", ft = "python" },
          { "<leader>dt", function() require("dap-python").test_method() end, desc = "Debug: Python test method", ft = "python" },
        },
        config = function()
          local python = vim.fn.exepath("python3")
          require("dap-python").setup(python)
        end,
      },

      -- Go adapter
      {
        "leoluz/nvim-dap-go",
        keys = {
          { "<leader>dt", function() require("dap-go").debug_test() end, desc = "Debug: Go test", ft = "go" },
        },
        config = function()
          require("dap-go").setup()
        end,
      },
    },

    keys = {
      { "<F1>", function() require("dap").continue() end,      desc = "Debug: Continue" },
      { "<F2>", function() require("dap").step_into() end,     desc = "Debug: Step into" },
      { "<F3>", function() require("dap").step_over() end,     desc = "Debug: Step over" },
      { "<F4>", function() require("dap").step_out() end,      desc = "Debug: Step out" },
      { "<F5>", function() require("dap").step_back() end,     desc = "Debug: Step back" },
      { "<F6>", function() require("dap").run_to_cursor() end, desc = "Debug: Run to cursor" },
      { "<F7>", function() require("dap").restart() end,       desc = "Debug: Restart" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,    desc = "Debug: Toggle breakpoint" },
      { "<leader>de", function() require("dapui").eval(nil, { enter = true }) end, desc = "Debug: Evaluate" },
      { "<leader>dx", function() require("dapui").close() end, desc = "Debug: Close UI" },
    },

    config = function()
      local dap = require("dap")

      -- Python launch configurations
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          justMyCode = false,
        },
        {
          type = "python",
          request = "launch",
          name = "FastAPI (uvicorn)",
          module = "uvicorn",
          args = {
            "investments.app:app",
            "--reload",
            "--host", "127.0.0.1",
            "--port", "8000",
          },
          justMyCode = false,
        },
      }

      -- Breakpoint sign highlights
      vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#c23127", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#ff8800", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#888ca6", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef", bg = "NONE" })
      vim.api.nvim_set_hl(0, "DapStopped", { fg = "#00ff00", bg = "#2e4d3d" })
      vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2e4d3d" })

      -- Breakpoint signs
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpointRejected", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "" })

      -- Preserve DAP highlights across colorscheme changes
      vim.api.nvim_create_augroup("dap_colors", {})
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = "dap_colors",
        pattern = "*",
        desc = "Set DAP marker colors and prevent color theme from resetting them",
        callback = function()
          vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#c23127", bg = "NONE" })
          vim.api.nvim_set_hl(0, "DapBreakpointCondition", { fg = "#ff8800", bg = "NONE" })
          vim.api.nvim_set_hl(0, "DapBreakpointRejected", { fg = "#888ca6", bg = "NONE" })
          vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef", bg = "NONE" })
          vim.api.nvim_set_hl(0, "DapStopped", { fg = "#00ff00", bg = "#2e4d3d" })
          vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2e4d3d" })
        end,
      })
    end,
  },
}
