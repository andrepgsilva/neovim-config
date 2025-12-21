return {
  "rcarriga/nvim-dap-ui",

  version = "*",

  dependencies = {
    'mfussenegger/nvim-dap',
    'nvim-neotest/nvim-nio',
    "jay-babu/mason-nvim-dap.nvim"
  },

  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      automatic_installation = true,
      handlers = {},
      ensure_installed = {
        "php-debug-adapter",
      },
    })

    dapui.setup()

    vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })
    vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

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

    dap.configurations.php = {
      {
        name = "PHP: Listen for Xdebug",
        port = 9003,
        pathMappings = {
          ["/app"] = vim.fn.getcwd(),
        },
        request = "launch",
        type = "php",
        breakpoints = {
          exception = {
            Notice = false,
            Warning = false,
            Error = false,
            Exception = false,
            ["*"] = false,
          },
        },
      },
    }

    vim.keymap.set('n', '<F5>', dap.continue)
    vim.keymap.set('n', '<F10>', dap.step_over)
    vim.keymap.set('n', '<F11>', dap.step_into)
    vim.keymap.set('n', '<F12>', dap.step_out)
    vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>dT', ':DapClearBreakpoints<CR>')
    vim.keymap.set('n', '<leader>dc', function()
      vim.cmd("DapClearBreakpoints")
      dapui.close()
    end
    )
  end,
}
