return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )

        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "tsserver",
                "angularls",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,

                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,

 --required               npm install -g @angular/language-service@latest

                ["angularls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.angularls.setup {
                        cmd = {
                            "ngserver",
                            "--stdio",
                            "--tsProbeLocations",
                            "/home/nikita/.nvm/versions/node/v22.2.0/lib/node_modules",
                            "--ngProbeLocations",
                            "/home/nikita/.nvm/versions/node/v22.2.0/lib/node_modules"
                        },
                        on_new_config = function(new_config)
                            new_config.cmd = {
                                "ngserver",
                                "--stdio",
                                "--tsProbeLocations",
                                "/home/nikita/.nvm/versions/node/v22.2.0/lib/node_modules",
                                "--ngProbeLocations",
                                "/home/nikita/.nvm/versions/node/v22.2.0/lib/node_modules"
                            }
                        end,
                        capabilities = capabilities,
                        filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
                        root_dir = lspconfig.util.root_pattern('angular.json', '.git'),
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            })
        })

        vim.diagnostic.config({
        -- update_in_insert = true,
        virtual_text = {
            wrap = true,  -- Allow text wrapping
            max_width = 80,  -- Set maximum width (adjust as needed)
        },
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
            wrap = true,  -- Enable text wrapping in float
            max_width = 80,  -- Set maximum width for float window
            max_height = 20,  -- Set maximum height for float window
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
    })
    end
}
