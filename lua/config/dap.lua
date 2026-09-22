
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

spec.config = function()
  local dap = require("dap")
  local ui = require("dapui")
  local dap_virtual_text = require("nvim-dap-virtual-text")

  ---------------------------------------------------------------------------
  -- DAP Virtual Text
  ---------------------------------------------------------------------------
  dap_virtual_text.setup()

  ---------------------------------------------------------------------------
  -- Dart / Flutter Debug Adapter
  ---------------------------------------------------------------------------
  dap.adapters.dart = {
    type = "executable",
    command = "dart",
    args = { "debug_adapter" },
  }

  dap.adapters.flutter = {
    type = "executable",
    command = "flutter",
    args = { "debug_adapter" },
  }

  ---------------------------------------------------------------------------
  -- DAP Configurations
  ---------------------------------------------------------------------------
  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch Dart",
      dartSdkPath = "/opt/homebrew/share/flutter/bin/cache/dart-sdk",
      program = "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },

    {
      type = "flutter",
      request = "launch",
      name = "Launch Flutter",
      dartSdkPath = "/opt/homebrew/share/flutter/bin/cache/dart-sdk",
      flutterSdkPath = "/opt/homebrew/share/flutter",
      program = "${workspaceFolder}/lib/main.dart",
      cwd = "${workspaceFolder}",
    },
  }

  ---------------------------------------------------------------------------
  -- DAP UI
  ---------------------------------------------------------------------------
  ui.setup()

  ---------------------------------------------------------------------------
  -- Signs
  ---------------------------------------------------------------------------
  vim.fn.sign_define("DapBreakpoint", {
    text = "🐞",
  })

  ---------------------------------------------------------------------------
  -- Automatically open / close DAP UI
  ---------------------------------------------------------------------------
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
