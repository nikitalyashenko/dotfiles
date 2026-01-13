return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
        {
            "microsoft/vscode-js-debug",
            -- After install, build it and rename the dist directory to out
            build = "npm install --legacy-peer-deps --no-save && npx gulp vsDebugServerBundle && rm -rf out && mv dist out",
            version = "1.*",
        },
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = {vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/vsDebugServer.js", "${port}"},
            },
        }

dap.adapters.node2 = {
  type = 'server',
  host = '127.0.0.1',
  port = 9229,
}

dap.configurations.javascript = {
  {
    type = "node2",
    request = "attach",
    name = "Attach to server",
    port = 9229,
    cwd = "/home/nikita/work/nzleads/server",
    restart = true,
  },
}

dap.configurations.typescript = {
  {
    type = "node2",
    request = "attach",
    name = "Attach to server",
    port = 9229,
    cwd = "/home/nikita/work/nzleads/server",
    restart = true,
  },
}

        dapui.setup()

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end

        vim.keymap.set("n", "<Leader>dt", ":DapToggleBreakpoint<CR>")
        vim.keymap.set("n", "<Leader>dc", ":DapContinue<CR>")
        vim.keymap.set("n", "<Leader>dx", ":DapTerminate<CR>")
        vim.keymap.set("n", "<Leader>do", ":DapStepOver<CR>")
    vim.keymap.set("n", "<Leader>dq", function()
  require("dapui").close()
  require("dap").terminate()
  print("DAP session terminated and UI closed")
end)

    end,
}
