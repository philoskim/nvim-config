local spec = {
  "mfussenegger/nvim-dap",
  event = "VeryLazy",
  dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
  },
}

spec.config = function ()
  local mason_dap = require("mason-nvim-dap")
  local dap = require("dap")
  local ui = require("dapui")
  local dap_virtual_text = require("nvim-dap-virtual-text")

  -- Dap Virtual Text
  dap_virtual_text.setup()

  mason_dap.setup({
    ensure_installed = { "cppdbg" },
    automatic_installation = true,
    handlers = {
      function(config)
        require("mason-nvim-dap").default_setup(config)
      end,
    },
  })

  -- Configurations
  dap.configurations = {
  }

  -- Dap UI
  ui.setup()

  vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

  dap.listeners.before.attach.dapui_config = function()
    ui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    ui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    ui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    ui.close()
  end
end

return spec
