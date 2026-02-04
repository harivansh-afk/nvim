return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local lsp_config = require("config.lsp")

            -- Set up Mason for auto-installation
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "pyright",
                    "ts_ls",
                    "rust_analyzer",
                    "gopls",
                    "clangd",
                    "bashls",
                    "jsonls",
                    "html",
                    "cssls",
                },
                automatic_installation = true,
            })

            local lspconfig = require("lspconfig")
            local capabilities = lsp_config.capabilities()

            -- LspAttach autocmd for keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    if client then
                        lsp_config.on_attach(client, ev.buf)
                    end
                end,
            })

            -- Helper to load per-server config from lua/lsp/ if it exists
            local function get_server_config(server_name)
                local ok, server_config = pcall(require, "lsp." .. server_name)
                if ok then
                    return server_config
                end
                return {}
            end

            -- Auto-setup all installed servers
            require("mason-lspconfig").setup_handlers({
                -- Default handler for all servers
                function(server_name)
                    local server_config = get_server_config(server_name)
                    local config = vim.tbl_deep_extend("force", {
                        capabilities = capabilities,
                    }, server_config)

                    lspconfig[server_name].setup(config)
                end,
            })
        end,
    },
}
