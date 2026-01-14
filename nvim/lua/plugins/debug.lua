return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "mason-org/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "leoluz/nvim-dap-go",
  },
  keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
      "<leader>5",
      function()
        require("dap").continue()
      end,
      desc = "Debug: Start/Continue",
    },
    {
      "<leader>1",
      function()
        require("dap").step_into()
      end,
      desc = "Debug: Step Into",
    },
    {
      "<leader>2",
      function()
        require("dap").step_over()
      end,
      desc = "Debug: Step Over",
    },
    {
      "<leader>3",
      function()
        require("dap").step_out()
      end,
      desc = "Debug: Step Out",
    },
    {
      "<leader>b",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Debug: Toggle Breakpoint",
    },
    {
      "<leader>B",
      function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end,
      desc = "Debug: Set Breakpoint",
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
      "<leader>7",
      function()
        require("dapui").toggle()
      end,
      desc = "Debug: See last session result.",
    },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    require("mason-nvim-dap").setup({
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        "delve",
        "coreclr",
      },
    })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup({
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
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

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
    vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = "", BreakpointCondition = "", BreakpointRejected = "", LogPoint = "", Stopped = "" }
      or { Breakpoint = "●", BreakpointCondition = "⊜", BreakpointRejected = "⊘", LogPoint = "◆", Stopped = "⭔" }
    for type, icon in pairs(breakpoint_icons) do
      local tp = "Dap" .. type
      local hl = (type == "Stopped") and "DapStop" or "DapBreak"
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    dap.listeners.after.event_initialized["dapui_config"] = dapui.open
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    -- Install golang specific config
    require("dap-go").setup({
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has("win32") == 0,
      },
    })

    -- C# / .NET debugging
    dap.adapters.coreclr = {
      type = "executable",
      command = vim.fn.exepath("netcoredbg"), -- make sure netcoredbg is in PATH
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = {
      {
        -- Launch a .NET project
        type = "coreclr",
        name = "Launch",
        request = "launch",
        program = function()
          local project_path = vim.fs.root(0, function(name)
            return name:match("%.csproj$") ~= nil
          end)

          if not project_path then
            return vim.notify("Couldn't find the csproj path")
          end

          return require("dap.utils").pick_file({
            filter = string.format("Debug/.*/%s", vim.fn.fnamemodify(project_path, ":t:r")),
            path = string.format("%s/bin", project_path),
          })
        end,
      },
      {
        type = "coreclr",
        name = "Attach",
        request = "attach",
        processId = function()
          return require("dap.utils").pick_process({
            filter = function(proc)
              ---@diagnostic disable-next-line: return-type-mismatch
              return proc.name:match(".*/Debug/.*") and not proc.name:find("vstest.console.dll")
            end,
          })
        end,
      },
    }
  end,
}
